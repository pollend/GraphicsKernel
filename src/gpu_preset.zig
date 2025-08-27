pub const Level = enum(u8) {
    GPU_PRESET_NONE = 0,
    GPU_PRESET_OFFICE,
    GPU_PRESET_VERYLOW,
    GPU_PRESET_LOW,
    GPU_PRESET_MEDIUM,
    GPU_PRESET_HIGH,
    GPU_PRESET_ULTRA,
    GPU_PRESET_COUNT,
};

pub const Preset = struct {
  vendorId: u32,
  modelId: u32,
  preset: Level 
};

pub const PRESETS = [_]Preset{
  // Intel
  Preset{ .vendorId = 0x8086, .modelId = 0x0042, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x0046, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x0102, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x0106, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x010A, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x0112, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x0116, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x0122, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x0126, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x0152, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x0156, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x015A, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x0162, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x0166, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x016A, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x0402, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x0406, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x040A, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x040B, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x040E, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x0412, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x0416, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x041A, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x041B, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x041E, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x0422, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x0426, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x042A, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x042B, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x042E, .preset = .GPU_PRESET_VERYLOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x0900, .preset = .GPU_PRESET_LOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x0901, .preset = .GPU_PRESET_LOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x0902, .preset = .GPU_PRESET_LOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x0903, .preset = .GPU_PRESET_LOW },
  Preset{ .vendorId = 0x8086, .modelId = 0x0904, .preset = .GPU_PRESET_LOW },
  // ...continue with AMD, NVIDIA, Qualcomm entries in the same format...
};
