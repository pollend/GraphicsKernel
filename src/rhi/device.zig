const rhi = @import("rhi.zig");
const volk = @import("volk");
const vma = @import("vma");
const std = @import("std");
const vulkan = @import("vulkan.zig");

pub const Device = @This();

allocator: std.mem.Allocator,
render: *rhi.Renderer,
queues: std.ArrayList(rhi.Queue),
adapter: rhi.PhysicalAdapter,
target: union(rhi.Target) { vk: rhi.wrapper_platform_type(.vk, struct {
    maintenance_5_feature: bool,
    conservaitve_raster_tier: bool,
    swapchain_mutable_format: bool,
    memory_budget: bool,
    device: volk.c.VkDevce,
    vma_allocator: vma.c.VmaAllocator,
}) } = undefined,

fn supports_extension( extensions: [][:0]const u8, value: []const u8) bool {
    for (extensions) |ext| {
        if (std.mem.eql(u8, ext, value)) {
            return true;
        }
    }
    return false;
}

pub fn init(allocator: std.mem.Allocator, renderer: *rhi.Renderer, adapter: *rhi.PhysicalAdapter) !Device {

    if (rhi.is_target_selected(.vk, renderer)) {
        var extension_num: u32 = 0;
        try vulkan.wrap_err(volk.c.vkEnumerateDeviceExtensionProperties.?(adapter.target.vk.physical_device, null, &extension_num, null));
        const extension_properties: []volk.c.VkExtensionProperties = try allocator.alloc(volk.c.VkExtensionProperties, extension_num);
        defer allocator.free(extension_properties);
        try vulkan.wrap_err(volk.c.vkEnumerateDeviceExtensionProperties.?(adapter.target.vk.physical_device, null, &extension_num, extension_properties.ptr));
        var enabled_extension_names = std.ArrayList([:0]const u8).empty;
        defer enabled_extension_names.deinit(allocator);

        for(vulkan.default_device_extensions) |default_ext| {
            if(vulkan.vk_has_extension(extension_properties, default_ext)) {
                try enabled_extension_names.append(default_ext);
            }
        }

        const queue_family_props = family_props: {
	    var familyNum: u32 = 0;
	    volk.c.vkGetPhysicalDeviceQueueFamilyProperties.?(adapter.target.vk.physical_device, &familyNum, null);
            const res: []volk.c.VkQueueFamilyProperties = try allocator.alloc(volk.c.VkQueueFamilyProperties, familyNum);
	    volk.c.vkGetPhysicalDeviceQueueFamilyProperties.?(adapter.target.vk.physical_device, &familyNum, res.ptr );
	    break :family_props res;
	};
	defer allocator.free(queue_family_props);

        var device_queue_create_info = std.ArrayList(volk.c.VkDeviceQueueCreateInfo).empty;
	//VkDeviceCreateInfo deviceCreateInfo = { VK_STRUCTURE_TYPE_DEVICE_CREATE_INFO };
	//deviceCreateInfo.pQueueCreateInfos = deviceQueueCreateInfo;
	const priorities: []f32 = .{1.0, 0.9, 0.8, 0.7, 0.6, 0.5};
        {
            const queue_buf: [16][]const u8 = undefined;
            var queue_feature = std.ArrayList([]const u8).initBuffer(&queue_buf);
            var i = 0; 
            while(i < queue_family_props.len) : (i += 1) {
                queue_feature.appendAssumeCapacity("test");
		if(queue_family_props[i].queueFlags & volk.c.VK_QUEUE_GRAPHICS_BIT) 
		    queue_feature.appendAssumeCapacity("VK_QUEUE_GRAPHICS_BIT");
		if(queue_family_props[i].queueFlags & volk.c.VK_QUEUE_COMPUTE_BIT )
                    queue_feature.appendAssumeCapacity("VK_QUEUE_COMPUTE_BIT"); 
		if(queue_family_props[i].queueFlags & volk.c.VK_QUEUE_TRANSFER_BIT)
		    queue_feature.appendAssumeCapacity("VK_QUEUE_TRANSFER_BIT");
		if(queue_family_props[i].queueFlags & volk.c.VK_QUEUE_SPARSE_BINDING_BIT)
		    queue_feature.appendAssumeCapacity("VK_QUEUE_SPARSE_BINDING_BIT");
		if(queue_family_props[i].queueFlags & volk.c.VK_QUEUE_PROTECTED_BIT) 
                    queue_feature.appendAssumeCapacity("VK_QUEUE_PROTECTED_BIT"); 
		if(queue_family_props[i].queueFlags & volk.c.VK_QUEUE_VIDEO_DECODE_BIT_KHR)
		    queue_feature.appendAssumeCapacity("VK_QUEUE_VIDEO_DECODE_BIT_KHR");
		if(queue_family_props[i].queueFlags & volk.c.VK_QUEUE_VIDEO_ENCODE_BIT_KHR) 
                    queue_feature.appendAssumeCapacity("VK_QUEUE_VIDEO_ENCODE_BIT_KHR"); 
		if(queue_family_props[i].queueFlags & volk.c.VK_QUEUE_OPTICAL_FLOW_BIT_NV )
		    queue_feature.appendAssumeCapacity("VK_QUEUE_OPTICAL_FLOW_BIT_NV");
                queue_feature.clearRetainingCapacity();
            }
        }


        //var device_create_info: volk.c.VkDeviceCreateInfo = .{ .sType = volk.c.VK_STRUCTURE_TYPE_DEVICE_CREATE_INFO };
        //device_create_info.ppEnabledExtensionNames
        //var features: volk.c.VkPhysicalDeviceFeatures2 = .{ .sType = volk.c.VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_FEATURES_2 };
        //var features11: volk.c.VkPhysicalDeviceVulkan11Features = .{ .sType = volk.c.VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_VULKAN_1_1_FEATURES };
        //vulkan.add_next(&features, &features11);

        //var features12: volk.c.VkPhysicalDeviceVulkan12Features = .{ .sType = volk.c.VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_VULKAN_1_2_FEATURES };
        //vulkan.add_next(&features, &features12);

        //var features13: volk.c.VkPhysicalDeviceVulkan13Features = .{ .sType = volk.c.VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_VULKAN_1_3_FEATURES };
        //if (renderer.backend.vk.api_version >= volk.c.VK_API_VERSION_1_3) {
        //    vulkan.add_next(&features, &features13);
        //}

        return .{ 
            .allocator = renderer.allocator, 
            .render = renderer, 
            .queues = std.ArrayList(rhi.Queue).empty, 
            .adapter = adapter.*, 
            .target = .{ .vk = {} } 
        };
    }
    return error.Unitialized;
}
