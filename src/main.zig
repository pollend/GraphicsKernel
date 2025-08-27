const std = @import("std");
const GraphicsKernel = @import("GraphicsKernel");
const c = @cImport({
    @cDefine("SDL_DISABLE_OLD_NAMES", {});
    @cInclude("SDL3/SDL.h");
    @cInclude("SDL3/SDL_revision.h");
    @cDefine("SDL_MAIN_HANDLED", {}); // We are providing our own entry point
    @cInclude("SDL3/SDL_main.h");
});
const sdl_util = @import("sdl_util.zig");
const rhi = @import("rhi/rhi.zig");

//const renderer =  rhi.Renderer(.{
//    .supported = &.{ .vk },
//});

pub fn main() !void {
    try sdl_util.sdl3_error(c.SDL_Init(c.SDL_INIT_VIDEO));
    
    //_ = renderer.Texture.init();
    //_ = try renderer.init(.{
    //    .vk = .{
    //        .app_name = "GraphicsKernel",
    //        .enableValidationLayer = 1,
    //        .filterLayers = 
    //             "VK_LAYER_KHRONOS_validation"
    //        ,
    //    },
    //});
    //const adapter: rhi.PhysicalAdapter = undefined;

//    var major: i32 = 0;
//    var minor: i32 = 0;
//    var rev: i32 = 0;
//
//    glfw.getVersion(&major, &minor, &rev);
//    std.debug.print("GLFW {}.{}.{}\n", .{ major, minor, rev });
//
//    //Example of something that fails with GLFW_NOT_INITIALIZED - but will continue with execution
//    //var monitor: ?*glfw.Monitor = glfw.getPrimaryMonitor();
//
//    try glfw.init();
//    defer glfw.terminate();
//    std.debug.print("GLFW Init Succeeded.\n", .{});
//
//    const window: *glfw.Window = try glfw.createWindow(800, 640, "Hello World", null, null);
//    defer glfw.destroyWindow(window);
//
//    while (!glfw.windowShouldClose(window)) {
//        if (glfw.getKey(window, glfw.KeyEscape) == glfw.Press) {
//            glfw.setWindowShouldClose(window, true);
//        }
//
//        glfw.pollEvents();
//    }
}

//test "simple test" {
//    const gpa = std.testing.allocator;
//    var list: std.ArrayList(i32) = .empty;
//    defer list.deinit(gpa); // Try commenting this out and see if zig detects the memory leak!
//    try list.append(gpa, 42);
//    try std.testing.expectEqual(@as(i32, 42), list.pop());
//}
//
//test "fuzz example" {
//    const Context = struct {
//        fn testOne(context: @This(), input: []const u8) anyerror!void {
//            _ = context;
//            // Try passing `--fuzz` to `zig build test` and see if it manages to fail this test case!
//            try std.testing.expect(!std.mem.eql(u8, "canyoufindme", input));
//        }
//    };
//    try std.testing.fuzz(Context{}, Context.testOne, .{});
//}
