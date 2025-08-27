pub const Renderer = @This();

const rhi = @import("rhi.zig");
const volk = @import("volk");
const vulkan = @import("vulkan.zig");
const std = @import("std");
const assert = std.debug.assert;

target: rhi.Api,
backend: union(rhi.Api) {
    vk: rhi.wrapper_api_type(.vk, struct {
        apiVersion: u32, 
        instance: volk.c.VkInstance,
        debugMessageUtils: volk.c.VkDebugUtilsMessengerEXT 
    }),
    dx12: rhi.wrapper_api_type(.dx12, struct {
    
    }),
    mtl: rhi.wrapper_api_type(.mtl, struct {

    }) 
},

pub fn init(alloc: std.mem.Allocator,impl: union(rhi.Api) {
    vk: struct {
        app_name: [*c]const u8,
        enableValidationLayer: u1,
        filterLayers: []const u8
    },
    dx12: struct {},
    mtl: struct {},
}) Renderer {
    switch (impl) {
        .vk => |opt| {
            try vulkan.wrap_err(volk.c.volkInitialize());
           
            //const defaultDeviceExtension: [*c]const u8 = .{
            //   volk.c.VK_KHR_SWAPCHAIN_EXTENSION_NAME,
            //   volk.c.VK_KHR_MAINTENANCE1_EXTENSION_NAME,
            //   volk.c.VK_KHR_SHADER_DRAW_PARAMETERS_EXTENSION_NAME,
            //   volk.c.VK_EXT_SHADER_SUBGROUP_BALLOT_EXTENSION_NAME,
            //   volk.c.VK_EXT_SHADER_SUBGROUP_VOTE_EXTENSION_NAME,
            //   volk.c.VK_KHR_DEDICATED_ALLOCATION_EXTENSION_NAME,
            //   volk.c.VK_KHR_GET_MEMORY_REQUIREMENTS_2_EXTENSION_NAME,

            //   volk.c.VK_KHR_DRAW_INDIRECT_COUNT_EXTENSION_NAME,
            //   volk.c.VK_EXT_DEVICE_FAULT_EXTENSION_NAME,
            //   // Fragment shader interlock extension to be used for ROV type functionality in Vulkan
            //   volk.c.VK_EXT_FRAGMENT_SHADER_INTERLOCK_EXTENSION_NAME,

            //   //************************************************************************/
            //   // AMD Specific Extensions
            //   //************************************************************************/
            //   volk.c.VK_AMD_DRAW_INDIRECT_COUNT_EXTENSION_NAME,
            //   volk.c.VK_AMD_SHADER_BALLOT_EXTENSION_NAME,
            //   volk.c.VK_AMD_GCN_SHADER_EXTENSION_NAME,
            //   volk.c.VK_AMD_BUFFER_MARKER_EXTENSION_NAME,
            //   volk.c.VK_AMD_DEVICE_COHERENT_MEMORY_EXTENSION_NAME,
            //   //************************************************************************/
            //   // Multi GPU Extensions
            //   //************************************************************************/
            //   volk.c.VK_KHR_DEVICE_GROUP_EXTENSION_NAME,
            //   //************************************************************************/
            //   // Bindless & Non Uniform access Extensions
            //   //************************************************************************/
            //   volk.c.VK_EXT_DESCRIPTOR_INDEXING_EXTENSION_NAME,
            //   volk.c.VK_KHR_MAINTENANCE3_EXTENSION_NAME,
            //   // Required by raytracing and the new bindless descriptor API if we use it in future
            //   volk.c.VK_KHR_BUFFER_DEVICE_ADDRESS_EXTENSION_NAME,
            //   //************************************************************************/
            //   // Shader Atomic Int 64 Extension
            //   //************************************************************************/
            //   volk.c.VK_KHR_SHADER_ATOMIC_INT64_EXTENSION_NAME,
            //   //************************************************************************/
            //   // Raytracing
            //   //************************************************************************/
            //   volk.c.VK_KHR_RAY_QUERY_EXTENSION_NAME,
            //   volk.c.VK_KHR_RAY_TRACING_PIPELINE_EXTENSION_NAME,
            //   // Required by VK_KHR_ray_tracing_pipeline
            //   volk.c.VK_KHR_SPIRV_1_4_EXTENSION_NAME,
            //   // Required by VK_KHR_spirv_1_4
            //   volk.c.VK_KHR_SHADER_FLOAT_CONTROLS_EXTENSION_NAME,

            //   volk.c.VK_KHR_ACCELERATION_STRUCTURE_EXTENSION_NAME,
            //   // Required by VK_KHR_acceleration_structure
            //   volk.c.VK_KHR_DEFERRED_HOST_OPERATIONS_EXTENSION_NAME,
            //   //************************************************************************/
            //   // YCbCr format support
            //   //************************************************************************/
            //   // Requirement for VK_KHR_sampler_ycbcr_conversion
            //   volk.c.VK_KHR_BIND_MEMORY_2_EXTENSION_NAME,
            //   volk.c.VK_KHR_SAMPLER_YCBCR_CONVERSION_EXTENSION_NAME,
            //   volk.c.VK_KHR_BIND_MEMORY_2_EXTENSION_NAME,
            //   volk.c.VK_KHR_IMAGE_FORMAT_LIST_EXTENSION_NAME,
            //   volk.c.VK_KHR_IMAGE_FORMAT_LIST_EXTENSION_NAME,
            //   volk.c.VK_EXT_SAMPLE_LOCATIONS_EXTENSION_NAME,
            //   //************************************************************************/
            //   // Dynamic rendering
            //   //************************************************************************/
            //   volk.c.VK_KHR_DYNAMIC_RENDERING_EXTENSION_NAME,
            //   volk.c.VK_KHR_DEPTH_STENCIL_RESOLVE_EXTENSION_NAME, // Required by VK_KHR_DYNAMIC_RENDERING_EXTENSION_NAME
            //   volk.c.VK_KHR_CREATE_RENDERPASS_2_EXTENSION_NAME,         // Required by VK_KHR_DEPTH_STENCIL_RESOLVE_EXTENSION_NAME
            //   volk.c.VK_KHR_MULTIVIEW_EXTENSION_NAME,                   // Required by VK_KHR_CREATE_RENDERPASS_2_EXTENSION_NAME
            //   //************************************************************************/
            //   // Nsight Aftermath
            //   //************************************************************************/
            //   volk.c.VK_EXT_ASTC_DECODE_MODE_EXTENSION_NAME
            //};

            var appInfo: volk.c.VkApplicationInfo = undefined;
            appInfo.sType = volk.c.VK_STRUCTURE_TYPE_APPLICATION_INFO;
            appInfo.pNext = null;
            appInfo.pApplicationName = opt.app_name;
            appInfo.pEngineName = "Kernel";
            appInfo.applicationVersion = vulkan.make_version( 1, 0, 0 );
            appInfo.engineVersion = vulkan.make_version( 1, 0, 0 );
            appInfo.apiVersion = volk.c.VK_API_VERSION_1_3;
           
            const enabledValidationFeatures: []volk.c.VkValidationFeatureEnableEXT = .{ volk.c.VK_VALIDATION_FEATURE_ENABLE_DEBUG_PRINTF_EXT };

            const validationFeatures: []volk.c.VkValidationFeaturesEXT  = .{ volk.c.VK_STRUCTURE_TYPE_VALIDATION_FEATURES_EXT };
            validationFeatures.enabledValidationFeatureCount = enabledValidationFeatures.len;
            validationFeatures.pEnabledValidationFeatures = enabledValidationFeatures;

            var instanceCreateInfo: volk.c.VkInstanceCreateInfo  = .{ volk.c.VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO };
            instanceCreateInfo.pApplicationInfo = &appInfo;
            const enabledLayerNames: [8][]const u8 = .{};
            const enabledExtensionNames: [8][]const u8 = .{};
            instanceCreateInfo.ppEnabledLayerNames = enabledLayerNames;
            instanceCreateInfo.enabledLayerCount = 0;
            instanceCreateInfo.ppEnabledExtensionNames = enabledExtensionNames;
            instanceCreateInfo.enabledExtensionCount = 0;

            //const layerProperties: *volk.c.VkLayerProperties  = null;
            //const extProperties: *volk.c.VkExtensionProperties = null;
            {
                var instanceLayers: u32 = 0;
                volk.c.vkEnumerateInstanceLayerProperties( &instanceLayers, null);
                const layerProperties = try alloc.alloc(volk.c.VkLayerProperties, instanceLayers);
                defer alloc.free(layerProperties);
                volk.c.vkEnumerateInstanceLayerProperties( &instanceLayers, layerProperties );
                //layerProperties = malloc( enumInstanceLayers * sizeof( VkLayerProperties ) );
                var i: usize = 0;
                while (i < instanceLayers) : (i += 1) {
                    var useLayer: bool = false;
                    useLayer |= ( opt.enableValidationLayer and  std.mem.eql(u8, layerProperties[i].layerName, "VK_LAYER_KHRONOS_validation") );
                    if (opt.filterLayers.len > 0) {
                        useLayer |= std.mem.indexOf(u8, opt.filterLayers, layerProperties[i].layerName) != null;
                    }
                    //Com_Printf( "Instance Layer: %s(%d): %s", layerProperties[i].layerName, layerProperties[i].specVersion, useLayer ? "ENABLED" : "DISABLED" );
                    if( useLayer ) {
                        //assert( instanceCreateInfo.enabledLayerCount < @intCast(u32, enabledLayerNames.len) );
                        enabledLayerNames[instanceCreateInfo.enabledLayerCount] = layerProperties[i].layerName;
                        instanceCreateInfo.enabledLayerCount += 1;
                    }
                }
            }
//            {
//                    uint32_t extensionNum = 0;
//                    vkEnumerateInstanceExtensionProperties( NULL, &extensionNum, NULL );
//
//                    extProperties = malloc( extensionNum * sizeof( VkExtensionProperties ) );
//                    vkEnumerateInstanceExtensionProperties( NULL, &extensionNum, extProperties );
//
//                    const bool supportSurfaceExtension = __VK_isExtensionSupported( VK_KHR_SURFACE_EXTENSION_NAME, extProperties, extensionNum );
//                    for( size_t i = 0; i < extensionNum; i++ ) {
//                            bool useExtension = false;
//
//                            if( supportSurfaceExtension ) {
////#ifdef VK_USE_PLATFORM_WIN32_KHR
//                                        useExtension |= ( strcmp( extProperties[i].extensionName, VK_KHR_WIN32_SURFACE_EXTENSION_NAME ) == 0 );
////#endif
////#ifdef VK_USE_PLATFORM_METAL_EXT
//                                        useExtension |= ( strcmp( extProperties[i].extensionName, VK_EXT_METAL_SURFACE_EXTENSION_NAME ) == 0 );
////#endif
////#ifdef VK_USE_PLATFORM_XLIB_KHR
//                                        useExtension |= ( strcmp( extProperties[i].extensionName, VK_KHR_XLIB_SURFACE_EXTENSION_NAME ) == 0 );
////#endif
////#ifdef VK_USE_PLATFORM_WAYLAND_KHR
//                                        useExtension |= ( strcmp( extProperties[i].extensionName, VK_KHR_WAYLAND_SURFACE_EXTENSION_NAME ) == 0 );
////#endif
//                                }
//                                useExtension |= ( strcmp( extProperties[i].extensionName, VK_KHR_SURFACE_EXTENSION_NAME ) == 0 );
//                                useExtension |= ( strcmp( extProperties[i].extensionName, VK_EXT_SWAPCHAIN_COLOR_SPACE_EXTENSION_NAME ) == 0 );
//                                useExtension |= ( strcmp( extProperties[i].extensionName, VK_EXT_DEBUG_UTILS_EXTENSION_NAME ) == 0 );
//                                Com_Printf( "Instance Extensions: %s(%d): %s", extProperties[i].extensionName, extProperties[i].specVersion, useExtension ? "ENABLED" : "DISABLED" );
//                                if( useExtension ) {
//                                        assert( instanceCreateInfo.enabledExtensionCount < Q_ARRAY_COUNT( enabledExtensionNames ) );
//                                        enabledExtensionNames[instanceCreateInfo.enabledExtensionCount++] = extProperties[i].extensionName;
//                                }
//                        }
//                }
//
//                if( init->vk.enableValidationLayer ) {
//                        R_VK_ADD_STRUCT( &instanceCreateInfo, &validationFeatures );
//                }
//
//                VkResult result = vkCreateInstance( &instanceCreateInfo, NULL, &renderer->vk.instance );
//                free( layerProperties );
//                free( extProperties );
//                if( !VK_WrapResult( result ) ) {
//                        return RI_FAIL;
//                }
//                volkLoadInstance(renderer->vk.instance);
//                if( init->vk.enableValidationLayer && vkCreateDebugUtilsMessengerEXT) {
//                        VkDebugUtilsMessengerCreateInfoEXT createInfo = { VK_STRUCTURE_TYPE_DEBUG_UTILS_MESSENGER_CREATE_INFO_EXT };
//                        createInfo.pUserData = renderer;
//                        createInfo.pfnUserCallback = __VK_DebugUtilsMessenger;
//
//                        createInfo.messageSeverity = VK_DEBUG_UTILS_MESSAGE_SEVERITY_VERBOSE_BIT_EXT | VK_DEBUG_UTILS_MESSAGE_SEVERITY_INFO_BIT_EXT;
//                        createInfo.messageSeverity |= VK_DEBUG_UTILS_MESSAGE_SEVERITY_WARNING_BIT_EXT | VK_DEBUG_UTILS_MESSAGE_SEVERITY_ERROR_BIT_EXT;
//
//                        createInfo.messageType = VK_DEBUG_UTILS_MESSAGE_TYPE_GENERAL_BIT_EXT | VK_DEBUG_UTILS_MESSAGE_TYPE_VALIDATION_BIT_EXT;
//                        createInfo.messageType |= VK_DEBUG_UTILS_MESSAGE_TYPE_PERFORMANCE_BIT_EXT;
//                        vkCreateDebugUtilsMessengerEXT( renderer->vk.instance, &createInfo, NULL, &renderer->vk.debugMessageUtils );
//                }
//        }
            return Renderer {
                .target = .vk,
                .backend = .{
                    .vk = .{
                        .apiVersion = appInfo.apiVersion,
                        .instance = undefined,
                        .debugMessageUtils = undefined,
                    }
                }
            };
        },
        .dx12 => {
            if (!rhi.is_target_supported(.dx12)) @panic("DirectX 12 target not supported in this build configuration");
            return Renderer{
                .target = .dx12,
                .backend = .{
                    .dx12 = {}
                }
            };
        },
        .mtl => {
            if (!rhi.is_target_supported(.mtl)) @panic("Metal target not supported in this build configuration");
            return Renderer{
                .target = .mtl,
                .backend = .{
                    .mtl = {}
                }
            };
        }
    }
}
