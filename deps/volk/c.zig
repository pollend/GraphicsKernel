const builtin = @import("builtin");

pub const c = @cImport({
    for (defines) |d| @cDefine(d, "1");

    @cInclude("volk.h");
});

pub const defines = switch (builtin.os.tag) {
    .windows => &[_][]const u8{
        "VK_USE_PLATFORM_WIN32_KHR",
    },
    .linux => &[_][]const u8{
        "VK_USE_PLATFORM_XLIB_KHR",
        "VK_USE_PLATFORM_WAYLAND_KHR",
    },
    .macos, .ios => &[_][]const u8{
        "VK_USE_PLATFORM_METAL_EXT",
    },
    else => &[_][]const u8{},
};

