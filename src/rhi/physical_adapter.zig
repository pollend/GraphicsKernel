const rhi = @import("rhi.zig");

pub fn PhysicalAdapter(comptime config: rhi.BuildConfig) type {
    return struct {
        pub const Self = @This();
        target: union(rhi.Target) {
            vk: if (config.is_target_supported(.vk)) struct {
                // Vulkan-specific fields
            } else void,
            dx12: if (config.is_target_supported(.dx12)) struct {
                // DirectX 12-specific fields
            } else void,
            mtl: if (config.is_target_supported(.mtl)) struct {
                // Metal-specific fields
            } else void,
        }
    };
}
