const volk = @import("volk");

pub fn wrap_err(value: c_int) !void {
    switch(value) {
        volk.c.VK_SUCCESS => return ,
        volk.c.VK_NOT_READY => return error.NotReady,
        volk.c.VK_TIMEOUT => return error.Timeout,
        volk.c.VK_EVENT_SET => return error.EventSet,
        volk.c.VK_EVENT_RESET => return error.EventReset,
        volk.c.VK_INCOMPLETE => return error.Incomplete,
        volk.c.VK_ERROR_OUT_OF_HOST_MEMORY => return error.OutOfHostMemory,
        volk.c.VK_ERROR_OUT_OF_DEVICE_MEMORY => return error.OutOfDeviceMemory,
        volk.c.VK_ERROR_INITIALIZATION_FAILED => return error.InitializationFailed,
        volk.c.VK_ERROR_DEVICE_LOST => return error.DeviceLost,
        volk.c.VK_ERROR_MEMORY_MAP_FAILED => return error.MemoryMapFailed,
        volk.c.VK_ERROR_LAYER_NOT_PRESENT => return error.LayerNotPresent,
        volk.c.VK_ERROR_EXTENSION_NOT_PRESENT => return error.ExtensionNotPresent,
        else => return error.Unknown,
    }
}

pub fn make_version(major: u32, minor: u32, patch: u32) u32 {
    return (major << 22) | (minor << 12) | patch;
}



