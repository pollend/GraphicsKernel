const std = @import("std");

// Although this function looks imperative, it does not perform the build
// directly and instead it mutates the build graph (`b`) that will be then
// executed by an external runner. The functions in `std.Build` implement a DSL
// for defining build steps and express dependencies between them, allowing the
// build runner to parallelize the build automatically (and the cache system to
// know when a step doesn't need to be re-run).
pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const mod = b.addModule("GraphicsKernel", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
    });
   
    const exe_mod = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
        .imports = &.{
            .{ .name = "GraphicsKernel", .module = mod },
        },
    });
    
    const sdl_dep = b.dependency("sdl", .{
        .target = target,
        .optimize = optimize,
        //.preferred_linkage = .static,
        //.strip = null,
        //.sanitize_c = null,
        //.pic = null,
        //.lto = null,
        //.emscripten_pthreads = false,
        //.install_build_config_h = false,
    });
    const sdl_lib = sdl_dep.artifact("SDL3");
    exe_mod.linkLibrary(sdl_lib);


    const exe = b.addExecutable(.{
        .name = "GraphicsKernel",
        .root_module = exe_mod 
    });
    
    //const release_flags = [_][]const u8{};
    //const debug_flags = [_][]const u8{"-o2"};
    //const flags = if (optimize == .Debug) &debug_flags else &release_flags;
    
    if (b.lazyDependency("volk", .{
        .target = target,
        .optimize = optimize,
    })) |volk_dep| {
        exe_mod.addImport(
            "volk",
            volk_dep.module("volk"),
        );
        exe_mod.linkLibrary(volk_dep.artifact("volk"));
    }

    if(b.lazyDependency("vma", .{
        .target = target,
        .optimize = optimize,
    })) |vma_dep| {
        exe_mod.addImport(
            "vma",
            vma_dep.module("vma"),
        );
        exe_mod.linkLibrary(vma_dep.artifact("vma"));
    }

    b.installArtifact(exe);
    const run_step = b.step("run", "Run the app");
    const run_cmd = b.addRunArtifact(exe);
    run_step.dependOn(&run_cmd.step);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
    const mod_tests = b.addTest(.{
        .root_module = mod,
    });

    const run_mod_tests = b.addRunArtifact(mod_tests);
    const exe_tests = b.addTest(.{
        .root_module = exe.root_module,
    });

    const run_exe_tests = b.addRunArtifact(exe_tests);

    const test_step = b.step("test", "Run tests");
    test_step.dependOn(&run_mod_tests.step);
    test_step.dependOn(&run_exe_tests.step);
}
