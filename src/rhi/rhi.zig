const texture = @import("texture.zig");
const volk = @import("volk");
const vma = @import("vma");
const vulkan = @import("vulkan.zig");
const builtin = @import("builtin");

pub const Renderer = @import("renderer.zig").Renderer;
pub const Api = enum {
    vk,
    dx12,
    mtl,
};

pub const PlatformApis = blk: {
    const os = builtin.os.tag;
    switch (os) {
        .windows => break :blk .{ .vk, .dx12 },
        .linux => break :blk .{ .vk },
        .macos => break :blk .{ .mtl },
        .ios => break :blk .{ .mtl },
        else => break :blk .{},
    }
};

pub fn is_target_supported(comptime target: Api) bool {
    for (PlatformApis) |t| {
        if (t == target) return true;
    }
    return false;
}

pub fn wrapper_api_type(api: Api, comptime impl: type) type{
    if(is_target_supported(api)){
        return impl;
    } else {
        return void;
    }
}

