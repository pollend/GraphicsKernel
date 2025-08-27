const rhi = @import("rhi.zig");
const volk = @import("volk");
const vma = @import("vma");

pub fn Texture(comptime config: rhi.BuildConfig) type {
    return struct {
        pub const Self = @This();
        pub fn init() Self {
            return Self{
                .target = .{
                    .vk = .{
                        .image = undefined,
                    },
                } 
            };
        }

        target: union(rhi.Api) {
            vk: if (config.is_target_supported(.vk)) struct {
                image: *volk.c.VkImage
            } else void,
            dx12: if (config.is_target_supported(.dx12)) struct {
                // Vulkan-specific fields
            } else void,
            mtl: if (config.is_target_supported(.mtl)) struct {
                // Vulkan-specific fields
            } else void,
        }
    };
}
