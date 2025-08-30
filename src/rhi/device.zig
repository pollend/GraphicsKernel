const rhi = @import("rhi.zig");
const volk = @import("volk");
const vma = @import("vma");
const physical_adapter = @import("physical_adapter.zig");
const queue = @import("queue.zig");
const std = @import("std");
const renderer = @import("renderer.zig");

pub const Device = @This();

allocator: std.mem.Allocator,
render: *renderer.Renderer,
queues: std.ArrayListUnmanaged(queue.Queue, 6),
physical_device: physical_adapter.PhysicalAdapter,
target: union(rhi.Target) {
    vk: rhi.wrapper_platform_type(.vk, struct {
        maintenance5_features: bool,
        conservative_raster_tier: bool,
        swapchain_mutable_format: bool,
        memory_budget: bool,
        device: volk.c.VkDevce,
        vma_allocator: vma.c.VmaAllocator,
    })
} = undefined


