const rhi = @import("rhi.zig");
const volk = @import("volk");

pub const Queue = @This();

pub const QueueType = enum {
    graphics,
    compute,
    transfer,
};

target: union(rhi.Target) {
    vk: rhi.wrapper_platform_type(.vk, struct {
        flags: volk.c.VkQueueFlags,
        family_index: u32,
        slot_index: u32,
        queue: volk.c.VkQueue,
    })
}
