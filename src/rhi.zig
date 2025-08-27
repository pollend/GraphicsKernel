const std = @import("std");
const volk = @import("volk");
const vma = @import("vma");

const Target = enum {
    Vulkan,
    DirectX12,
    Metal,
};

const Config = struct {
    supported: []const Target,
};


pub const MaxSwapchainImages = 8;
pub const NumberOfFramesInFlight = 3;

pub const TextureViewType = enum(u8) {
    SHADER_RESOURCE_1D,
    SHADER_RESOURCE_1D_ARRAY,
    SHADER_RESOURCE_STORAGE_1D,
    SHADER_RESOURCE_STORAGE_1D_ARRAY,
    SHADER_RESOURCE_2D,
    SHADER_RESOURCE_2D_ARRAY,
    SHADER_RESOURCE_CUBE,
    SHADER_RESOURCE_CUBE_ARRAY,
    SHADER_RESOURCE_STORAGE_2D,
    SHADER_RESOURCE_STORAGE_2D_ARRAY,
    COLOR_ATTACHMENT,
    DEPTH_STENCIL_ATTACHMENT,
    DEPTH_READONLY_STENCIL_ATTACHMENT,
    DEPTH_ATTACHMENT_STENCIL_READONLY,
    DEPTH_STENCIL_READONLY,
    SHADING_RATE_ATTACHMENT,
};

pub const TextureUsageBits = enum(u32) {
    NONE = 0,
    SHADER_RESOURCE = 0x1,
    SHADER_RESOURCE_STORAGE = 0x2,
    COLOR_ATTACHMENT = 0x4,
    DEPTH_STENCIL_ATTACHMENT = 0x8,
    SHADING_RATE = 0x10,
};

pub const SampleCount = enum(u8) {
    COUNT_1 = 1,
    COUNT_2 = 2,
    COUNT_4 = 4,
    COUNT_8 = 8,
    COUNT_16 = 16,
    COUNT_COUNT = 5,
};

pub const DeviceAPI = enum(u8) {
    UNKNOWN,
    VK,
    D3D11,
    D3D12,
    MTL,
};

pub const SwapchainFormat = enum(u8) {
    BT709_G10_16BIT,
    BT709_G22_8BIT,
    BT709_G22_10BIT,
    BT2020_G2084_10BIT,
};

pub const RIQueueType = enum(u8) {
    GRAPHICS,
    COMPUTE,
    COPY,
    LEN,
};

pub const RIAdapterType = enum(u8) {
    OTHER,
    CPU,
    VIRTUAL_GPU,
    INTEGRATED_GPU,
    DISCRETE_GPU,
};

pub const RIResult = enum(i32) {
    INCOMPLETE_DEVICE = -2,
    FAIL = -1,
    SUCCESS = 0,
    INCOMPLETE,
};

pub const RIBufferUsage = enum(u32) {
    NONE = 0,
    SHADER_RESOURCE = 0x1,
    SHADER_RESOURCE_STORAGE = 0x2,
    VERTEX_BUFFER = 0x4,
    INDEX_BUFFER = 0x8,
    CONSTANT_BUFFER = 0x10,
    ARGUMENT_BUFFER = 0x20,
    SCRATCH = 0x40,
    BINDING_TABLE = 0x80,
    ACCELERATION_STRUCTURE_BUILD_INPUT = 0x100,
    ACCELERATION_STRUCTURE_STORAGE = 0x200,
};

pub const RITextureType = enum(u8) {
    TEXTURE_1D,
    TEXTURE_2D,
    TEXTURE_3D,
};

pub const RIVendor = enum(u8) {
    UNKNOWN,
    NVIDIA,
    AMD,
    INTEL,
};

pub const RITopology = enum(u8) {
    POINT_LIST,
    LINE_LIST,
    LINE_STRIP,
    TRIANGLE_LIST,
    TRIANGLE_STRIP,
    LINE_LIST_WITH_ADJACENCY,
    LINE_STRIP_WITH_ADJACENCY,
    TRIANGLE_LIST_WITH_ADJACENCY,
    TRIANGLE_STRIP_WITH_ADJACENCY,
    PATCH_LIST,
};

pub const RICompareFunc = enum(u8) {
    NONE,
    ALWAYS,
    NEVER,
    EQUAL,
    NOT_EQUAL,
    LESS,
    LESS_EQUAL,
    GREATER,
    GREATER_EQUAL,
};

pub const RICullMode = enum(u8) {
    NONE = 0,
    FRONT = 0x1,
    BACK = 0x2,
    BOTH = 0x3,
};

pub const RIIndexType = enum(u8) {
    TYPE_16,
    TYPE_32,
};

pub const RIColorWriteMask = enum(u8) {
    NONE = 0,
    R = 0x1,
    G = 0x2,
    B = 0x4,
    A = 0x8,
    RGB = 0x7,
    RGBA = 0xF,
};

pub const RIBlendFactor = enum(u8) {
    ZERO,
    ONE,
    SRC_COLOR,
    ONE_MINUS_SRC_COLOR,
    DST_COLOR,
    ONE_MINUS_DST_COLOR,
    SRC_ALPHA,
    ONE_MINUS_SRC_ALPHA,
    DST_ALPHA,
    ONE_MINUS_DST_ALPHA,
    CONSTANT_COLOR,
    ONE_MINUS_CONSTANT_COLOR,
    CONSTANT_ALPHA,
    ONE_MINUS_CONSTANT_ALPHA,
    SRC_ALPHA_SATURATE,
    SRC1_COLOR,
    ONE_MINUS_SRC1_COLOR,
    SRC1_ALPHA,
    ONE_MINUS_SRC1_ALPHA,
};

pub const RIWindowType = enum(u8) {
    X11,
    WIN32,
    METAL,
    WAYLAND,
};

// --- Structs ---

pub const RIBuffer = struct {
    // Only Vulkan for now
    vk: ?*volk.VkBuffer = null,
};

pub const RIBarrierImageHandle = struct {
    vk: ?struct {
        stage: volk.VkPipelineStageFlags2,
        access: volk.VkAccessFlags2,
        layout: volk.VkImageLayout,
    } = null,
};

pub const RIBarrierBufferHandle = struct {
    vk: ?struct {
        stage: volk.VkPipelineStageFlags2,
        access: volk.VkAccessFlags2,
    } = null,
};

pub const Texture = struct {
    vk: ?*volk.VkImage = null,
};

//pub const RIDescriptorFlags = enum(u8) {
//    VK_DESC_BEGIN = 0,
//    VK_DESC_OWN_SAMPLER = 0x1,
//    VK_DESC_OWN_IMAGE_VIEW = 0x2,
//};
//
////pub const RIDescriptor = struct {
////    cookie: hash_t,
////    flags: u8,
////    buffer: ?*RIBuffer = null,
////    texture: ?*RITexture = null,
////    vk: ?struct {
////        type: VkDescriptorType,
////        image: ?VkDescriptorImageInfo = null,
////        buffer: ?VkDescriptorBufferInfo = null,
////    } = null,
////};

pub const Rect = struct {
    x: i16,
    y: i16,
    width: i16,
    height: i16,
};

pub const Viewport = struct {
    x: f32,
    y: f32,
    width: f32,
    height: f32,
    depthMin: f32,
    depthMax: f32,
    originBottomLeft: bool,
};

pub const Cmd = struct {
    vk: struct {
        pool: volk.VkCommandPool,
        cmd: volk.VkCommandBuffer,
    } = null,
};

pub const Queue = struct {
    vk: ?struct {
        queueFlags: volk.VkQueueFlags,
        queueFamilyIdx: u16,
        slotIdx: u16,
        queue: volk.VkQueue,
    } = null,
};

pub const RISwapchain = struct {
    presentQueue: ?*Queue = null,
    imageCount: u16,
    width: u16,
    height: u16,
    format: u32,
    textures: [MaxSwapchainImages]Texture,
    vk: ?struct {
        frameIndex: u32,
        textureIndex: u32,
        presentID: u64,
        swapchain: volk.VkSwapchainKHR,
        surface: volk.VkSurfaceKHR,
        images: [MaxSwapchainImages]volk.VkImage,
        imageAcquireSem: [MaxSwapchainImages]volk.VkSemaphore,
        finishSem: [MaxSwapchainImages]volk.VkSemaphore,
    } = null,
};

//pub const Renderer = struct {
//    api: u8,
//    vk: ?struct {
//        apiVersion: u32,
//        instance: volk.VkInstance,
//        debugMessageUtils: volk.VkDebugUtilsMessengerEXT,
//    } = null,
//};

//pub const BackendInit = struct {
//    api: u8,
//    applicationName: [*:0]const u8,
//    vk: ?struct {
//        enableValidationLayer: bool,
//        numFilterLayers: usize,
//        filterLayers: [*]const [*:0]const u8,
//    } = null,
//};

pub const PhysicalAdapter = struct {
    name: [256]u8,
    luid: u64,
    videoMemorySize: u64,
    systemMemorySize: u64,
    deviceId: u32,
    vendor: u8,
    presetLevel: u8,
    type: u8,
    viewportMaxNum: u32,
    viewportBoundsRange: [2]i32,
    attachmentMaxDim: u16,
    attachmentLayerMaxNum: u16,
    colorAttachmentMaxNum: u16,
    colorSampleMaxNum: u8,
    depthSampleMaxNum: u8,
    stencilSampleMaxNum: u8,
    zeroAttachmentsSampleMaxNum: u8,
    textureColorSampleMaxNum: u8,
    textureIntegerSampleMaxNum: u8,
    textureDepthSampleMaxNum: u8,
    textureStencilSampleMaxNum: u8,
    storageTextureSampleMaxNum: u8,
    texture1DMaxDim: u16,
    texture2DMaxDim: u16,
    texture3DMaxDim: u16,
    textureArrayLayerMaxNum: u16,
    typedBufferMaxDim: u32,
    deviceUploadHeapSize: u64,
    memoryAllocationMaxNum: u32,
    samplerAllocationMaxNum: u32,
    constantBufferMaxRange: u32,
    storageBufferMaxRange: u32,
    bufferTextureGranularity: u32,
    bufferMaxSize: u64,
    uploadBufferTextureRowAlignment: u32,
    uploadBufferTextureSliceAlignment: u32,
    bufferShaderResourceOffsetAlignment: u32,
    constantBufferOffsetAlignment: u32,
    pipelineLayoutDescriptorSetMaxNum: u32,
    pipelineLayoutRootConstantMaxSize: u32,
    pipelineLayoutRootDescriptorMaxNum: u32,
    descriptorSetSamplerMaxNum: u32,
    descriptorSetConstantBufferMaxNum: u32,
    descriptorSetStorageBufferMaxNum: u32,
    descriptorSetTextureMaxNum: u32,
    descriptorSetStorageTextureMaxNum: u32,
    perStageDescriptorSamplerMaxNum: u32,
    perStageDescriptorConstantBufferMaxNum: u32,
    perStageDescriptorStorageBufferMaxNum: u32,
    perStageDescriptorTextureMaxNum: u32,
    perStageDescriptorStorageTextureMaxNum: u32,
    perStageResourceMaxNum: u32,
    vertexShaderAttributeMaxNum: u32,
    vertexShaderStreamMaxNum: u32,
    vertexShaderOutputComponentMaxNum: u32,
    tessControlShaderGenerationMaxLevel: f32,
    tessControlShaderPatchPointMaxNum: u32,
    tessControlShaderPerVertexInputComponentMaxNum: u32,
    tessControlShaderPerVertexOutputComponentMaxNum: u32,
    tessControlShaderPerPatchOutputComponentMaxNum: u32,
    tessControlShaderTotalOutputComponentMaxNum: u32,
    tessEvaluationShaderInputComponentMaxNum: u32,
    tessEvaluationShaderOutputComponentMaxNum: u32,
    geometryShaderInvocationMaxNum: u32,
    geometryShaderInputComponentMaxNum: u32,
    geometryShaderOutputComponentMaxNum: u32,
    geometryShaderOutputVertexMaxNum: u32,
    geometryShaderTotalOutputComponentMaxNum: u32,
    fragmentShaderInputComponentMaxNum: u32,
    fragmentShaderOutputAttachmentMaxNum: u32,
    fragmentShaderDualSourceAttachmentMaxNum: u32,
    computeShaderSharedMemoryMaxSize: u32,
    computeShaderWorkGroupMaxNum: [3]u32,
    computeShaderWorkGroupInvocationMaxNum: u32,
    computeShaderWorkGroupMaxDim: [3]u32,
    viewportPrecisionBits: u32,
    subPixelPrecisionBits: u32,
    subTexelPrecisionBits: u32,
    mipmapPrecisionBits: u32,
    timestampFrequencyHz: u64,
    drawIndirectMaxNum: u32,
    samplerLodBiasMin: f32,
    samplerLodBiasMax: f32,
    samplerAnisotropyMax: f32,
    texelOffsetMin: i32,
    texelOffsetMax: u32,
    texelGatherOffsetMin: i32,
    texelGatherOffsetMax: u32,
    clipDistanceMaxNum: u32,
    cullDistanceMaxNum: u32,
    combinedClipAndCullDistanceMaxNum: u32,
    bindlessTier: u8,
    isTextureFilterMinMaxSupported: bool,
    isLogicFuncSupported: bool,
    isDepthBoundsTestSupported: bool,
    isDrawIndirectCountSupported: bool,
    isIndependentFrontAndBackStencilReferenceAndMasksSupported: bool,
    isCopyQueueTimestampSupported: bool,
    isEnchancedBarrierSupported: bool,
    isMemoryTier2Supported: bool,
    isDynamicDepthBiasSupported: bool,
    isViewportOriginBottomLeftSupported: bool,
    isRegionResolveSupported: bool,
    isShaderNativeI16Supported: bool,
    isShaderNativeF16Supported: bool,
    isShaderNativeI32Supported: bool,
    isShaderNativeF32Supported: bool,
    isShaderNativeI64Supported: bool,
    isShaderNativeF64Supported: bool,
    isShaderAtomicsI16Supported: bool,
    isShaderAtomicsI32Supported: bool,
    isShaderAtomicsI64Supported: bool,
    isDrawParametersEmulationEnabled: bool,
    vk: struct {
        apiVersion: u32,
        physicalDevice: volk.VkPhysicalDevice,
        isSwapChainSupported: bool,
        isBufferDeviceAddressSupported: bool,
        isAMDDeviceCoherentMemorySupported: bool,
        isPresentIDSupported: bool,
    },
};

pub const Device = struct {
    physicalAdapter: PhysicalAdapter,
//    renderer: ?*Renderer = null,
    queues: [RIQueueType.LEN]Queue,
    vk: ?struct {
        maintenance5Features: bool,
        conservaitveRasterTier: bool,
        swapchainMutableFormat: bool,
        memoryBudget: bool,
        device: volk.VkDevice,
        vmaAllocator: vma.VmaAllocator,
    } = null,
};

