const rhi = @import("rhi.zig");
const std = @import("std");
const volk = @import("volk");
const vulkan = @import("vulkan.zig");

pub const Vendor = enum(u8) {
    unknown,
    nvidia,
    amd,
    intel
};


pub const PresetLevel = enum(u8) {
    none,
    office,  // this means unsupported
    verylow, // mostly for mobile gpu
    low,
    medium,
    high,
    ultra
};

pub const AdapterType = enum(u8) {
    other,
    cpu,
    virtual,
    integrated,
    discrete,
};



pub const PhysicalAdapter = @This();
name: [256]u8 = std.mem.zeroes([256]u8),
luid: u64 = 0,
video_memory_size: u64 = 0,
system_memory_size: u64 = 0,
device_id: u32 = 0,
vendor: Vendor = .unknown, 
preset_level: PresetLevel = .none, 
adapter_type: AdapterType = .other, 

// Viewports
viewport_max_num: u32 = 0,
viewport_bounds_range: [2]i32 = [_]i32{0, 0},

// Attachments
attachment_max_dim: u16 = 0,
attachment_layer_max_num: u16 = 0,
color_attachment_max_num: u16 = 0,

// Multi-sampling
color_sample_max_num: u8 = 0,
depth_sample_max_num: u8 = 0,
stencil_sample_max_num: u8 = 0,
zero_attachments_sample_max_num: u8 = 0,
texture_color_sample_max_num: u8 = 0,
texture_integer_sample_max_num: u8 = 0,
texture_depth_sample_max_num: u8 = 0,
texture_stencil_sample_max_num: u8 = 0,
storage_texture_sample_max_num: u8 = 0,

// Resource dimensions
texture_1d_max_dim: u16 = 0,
texture_2d_max_dim: u16 = 0,
texture_3d_max_dim: u16 = 0,
texture_array_layer_max_num: u16 = 0,
typed_buffer_max_dim: u32 = 0,

// Memory
device_upload_heap_size: u64 = 0, // ReBAR
memory_allocation_max_num: u32 = 0,
sampler_allocation_max_num: u32 = 0,
constant_buffer_max_range: u32 = 0,
storage_buffer_max_range: u32 = 0,
buffer_texture_granularity: u32 = 0,
buffer_max_size: u64 = 0,

// Memory alignment
upload_buffer_texture_row_alignment: u32 = 0,
upload_buffer_texture_slice_alignment: u32 = 0,
buffer_shader_resource_offset_alignment: u32 = 0,
constant_buffer_offset_alignment: u32 = 0,
// scratch_buffer_offset_alignment: u32, // commented out
// shader_binding_table_alignment: u32, // commented out

// Pipeline layout
pipeline_layout_descriptor_set_max_num: u32 = 0,
pipeline_layout_root_constant_max_size: u32 = 0,
pipeline_layout_root_descriptor_max_num: u32 = 0,

// Descriptor set
descriptor_set_sampler_max_num: u32 = 0,
descriptor_set_constant_buffer_max_num: u32 = 0,
descriptor_set_storage_buffer_max_num: u32 = 0,
descriptor_set_texture_max_num: u32 = 0,
descriptor_set_storage_texture_max_num: u32 = 0,

// Shader resources
per_stage_descriptor_sampler_max_num: u32 = 0,
per_stage_descriptor_constant_buffer_max_num: u32 = 0,
per_stage_descriptor_storage_buffer_max_num: u32 = 0,
per_stage_descriptor_texture_max_num: u32 = 0,
per_stage_descriptor_storage_texture_max_num: u32 = 0,
per_stage_resource_max_num: u32 = 0,

// Vertex shader
vertex_shader_attribute_max_num: u32 = 0,
vertex_shader_stream_max_num: u32 = 0,
vertex_shader_output_component_max_num: u32 = 0,

// Tessellation shaders
tess_control_shader_generation_max_level: f32 = 0,
tess_control_shader_patch_point_max_num: u32 = 0,
tess_control_shader_per_vertex_input_component_max_num: u32 = 0,
tess_control_shader_per_vertex_output_component_max_num: u32 = 0,
tess_control_shader_per_patch_output_component_max_num: u32 = 0,
tess_control_shader_total_output_component_max_num: u32 = 0,
tess_evaluation_shader_input_component_max_num: u32 = 0,
tess_evaluation_shader_output_component_max_num: u32 = 0,

// Geometry shader
geometry_shader_invocation_max_num: u32 = 0,
geometry_shader_input_component_max_num: u32 = 0,
geometry_shader_output_component_max_num: u32 = 0,
geometry_shader_output_vertex_max_num: u32 = 0,
geometry_shader_total_output_component_max_num: u32 = 0,

// Fragment shader
fragment_shader_input_component_max_num: u32 = 0,
fragment_shader_output_attachment_max_num: u32 = 0,
fragment_shader_dual_source_attachment_max_num: u32 = 0,

// Compute shader
compute_shader_shared_memory_max_size: u32 = 0,
compute_shader_work_group_max_num: [3]u32 = [_]u32{0, 0, 0},
compute_shader_work_group_invocation_max_num: u32 = 0,
compute_shader_work_group_max_dim: [3]u32 = [_]u32{0, 0, 0},

// Precision bits
viewport_precision_bits: u32 = 0,
sub_pixel_precision_bits: u32 = 0,
sub_texel_precision_bits: u32 = 0,
mipmap_precision_bits: u32 = 0,

// Other
timestamp_frequency_hz: u64 = 0,
draw_indirect_max_num: u32 = 0,
sampler_lod_bias_min: f32 = 0,
sampler_lod_bias_max: f32 = 0,
sampler_anisotropy_max: f32 = 0,
texel_offset_min: i32 = 0,
texel_offset_max: u32 = 0,
texel_gather_offset_min: i32 = 0,
texel_gather_offset_max: u32 = 0,
clip_distance_max_num: u32 = 0,
cull_distance_max_num: u32 = 0,
combined_clip_and_cull_distance_max_num: u32 = 0,
// shading_rate_attachment_tile_size: u8, // commented out
// shader_model: u8, // commented out

// Tiers
// conservative_raster_tier: u8, // commented out
// sample_locations_tier: u8, // commented out
// ray_tracing_tier: u8, // commented out
// shading_rate_tier: u8, // commented out
bindless_tier: u8 = 0,

// Features (bitfields replaced with bool)
is_texture_filter_min_max_supported: bool = false,
is_logic_func_supported: bool = false,
is_depth_bounds_test_supported: bool = false,
is_draw_indirect_count_supported: bool = false,
is_independent_front_and_back_stencil_reference_and_masks_supported: bool = false,
is_copy_queue_timestamp_supported: bool = false,
is_enchanced_barrier_supported: bool = false,
is_memory_tier2_supported: bool = false,
is_dynamic_depth_bias_supported: bool = false,
is_viewport_origin_bottom_left_supported: bool = false,
is_region_resolve_supported: bool = false,

// Shader features
is_shader_native_i16_supported: bool = false,
is_shader_native_f16_supported: bool = false,
is_shader_native_i32_supported: bool = false,
is_shader_native_f32_supported: bool = false,
is_shader_native_i64_supported: bool = false,
is_shader_native_f64_supported: bool = false,
is_shader_atomics_i16_supported: bool = false,
is_shader_atomics_i32_supported: bool = false,
is_shader_atomics_i64_supported: bool = false,

// Emulated features
is_draw_parameters_emulation_enabled: bool = false,

// API-specific fields
target:  union(rhi.Backend) {
    vk: rhi.wrapper_platform_type(.vk, struct {
        physical_device: volk.c.VkPhysicalDevice = std.mem.zeroes(volk.c.VkPhysicalDevice),
        api_version: u32 = 0,
        is_swap_chain_supported: bool = false,
        is_buffer_device_address_supported: bool = false,
        is_amd_device_coherent_memory_supported: bool = false,
        is_present_id_supported: bool = false,
    }),
    dx12: rhi.wrapper_platform_type(.dx12, struct {}),
    mtl: rhi.wrapper_platform_type(.mtl, struct {}),
} = undefined, 

pub fn enumerate_adapters(alloc: std.mem.Allocator, renderer: *rhi.Renderer) !std.ArrayList(PhysicalAdapter) {
    var result = std.ArrayList(PhysicalAdapter).empty;
    errdefer result.deinit(alloc);
    if(rhi.is_target_selected(.vk, renderer)) {
        var deviceGroupsCount: u32 = 0;
        try vulkan.wrap_err(volk.c.vkEnumeratePhysicalDeviceGroups.?(renderer.backend.vk.instance, &deviceGroupsCount, null));
        const physicalDeviceProperties = try alloc.alloc(volk.c.VkPhysicalDeviceGroupProperties, deviceGroupsCount);
        defer alloc.free(physicalDeviceProperties );
        try vulkan.wrap_err(volk.c.vkEnumeratePhysicalDeviceGroups.?(renderer.backend.vk.instance, &deviceGroupsCount, physicalDeviceProperties.ptr ));
        var i: usize = 0;
        while (i < deviceGroupsCount) : (i += 1) {
            var physicalAdapter: PhysicalAdapter = .{};
            physicalAdapter.target.vk.physical_device = physicalDeviceProperties[i].physicalDevices[0];

            var extension_num: u32 = 0;
            try vulkan.wrap_err(volk.c.vkEnumerateDeviceExtensionProperties.?(physicalAdapter.target.vk.physical_device, null, &extension_num, null));
            const extension_properties = try alloc.alloc(volk.c.VkExtensionProperties, extension_num);
            try vulkan.wrap_err(volk.c.vkEnumerateDeviceExtensionProperties.?(physicalAdapter.target.vk.physical_device, null, &extension_num, extension_properties.ptr));
				
            var properties: volk.c.VkPhysicalDeviceProperties2 = .{ .sType = volk.c.VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_PROPERTIES_2 };
			var props11: volk.c.VkPhysicalDeviceVulkan11Properties = .{ .sType = volk.c.VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_VULKAN_1_1_PROPERTIES };
			var props12: volk.c.VkPhysicalDeviceVulkan12Properties = .{ .sType = volk.c.VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_VULKAN_1_2_PROPERTIES };
			var props13: volk.c.VkPhysicalDeviceVulkan13Properties = .{ .sType = volk.c.VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_VULKAN_1_3_PROPERTIES };
			var deviceIDProperties: volk.c.VkPhysicalDeviceIDProperties = .{ .sType = volk.c.VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_ID_PROPERTIES };

			vulkan.add_next(&properties, &props11);
			vulkan.add_next(&properties, &props12);
			vulkan.add_next(&properties, &props13);
			vulkan.add_next(&properties, &deviceIDProperties);
            
			var features: volk.c.VkPhysicalDeviceFeatures2 = .{ .sType = volk.c.VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_FEATURES_2 };
            var features11: volk.c.VkPhysicalDeviceVulkan11Features = .{ .sType = volk.c.VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_VULKAN_1_1_FEATURES };
			var features12: volk.c.VkPhysicalDeviceVulkan12Features = .{ .sType = volk.c.VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_VULKAN_1_2_FEATURES };
			var features13: volk.c.VkPhysicalDeviceVulkan13Features = .{ .sType = volk.c.VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_VULKAN_1_3_FEATURES };
        
            vulkan.add_next(&features, &features11);
            vulkan.add_next(&features, &features12);
            vulkan.add_next(&features, &features13);

        }
    }
    return result;
}
