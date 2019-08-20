package(default_visibility = ["//visibility:public"])

alias(
    name = "glslangValidator",
    actual = "Bin/glslangValidator.exe",
)

alias(
    name = "glslc",
    actual = "Bin/glslc.exe",
)

alias(
    name = "spirv-as",
    actual = "Bin/spirv-as.exe",
)

alias(
    name = "spirv-cfg",
    actual = "Bin/spirv-cfg.exe",
)

alias(
    name = "spriv-cross",
    actual = "Bin/spriv-cross.exe",
)

alias(
    name = "spriv-dis",
    actual = "Bin/spriv-dis.exe",
)

alias(
    name = "spirv-opt",
    actual = "Bin/spirv-opt.exe",
)

alias(
    name = "spirv-remap",
    actual = "Bin/spirv-remap.exe",
)

alias(
    name = "spirv-val",
    actual = "Bin/spirv-val.exe",
)

cc_import(
    name = "vulkan-1",
    visibility = ["//visibility:private"],
    interface_library = "Lib/vulkan-1.lib",
    system_provided = True,
)

cc_library(
    name = "vulkan",
    strip_include_prefix = "Include",
    hdrs = [
        "Include/vulkan/vk_icd.h",
        "Include/vulkan/vk_layer.h",
        "Include/vulkan/vk_platform.h",
        "Include/vulkan/vk_sdk_platform.h",
        "Include/vulkan/vulkan.h",
        "Include/vulkan/vulkan.hpp",
        "Include/vulkan/vulkan_android.h",
        "Include/vulkan/vulkan_core.h",
        "Include/vulkan/vulkan_fuchsia.h",
        "Include/vulkan/vulkan_ggp.h",
        "Include/vulkan/vulkan_ios.h",
        "Include/vulkan/vulkan_macos.h",
        "Include/vulkan/vulkan_metal.h",
        "Include/vulkan/vulkan_vi.h",
        "Include/vulkan/vulkan_wayland.h",
        "Include/vulkan/vulkan_win32.h",
        "Include/vulkan/vulkan_xcb.h",
        "Include/vulkan/vulkan_xlib.h",
        "Include/vulkan/vulkan_xlib_xrandr.h",
    ],
    deps = [":vulkan-1"],
)

# GLSL.std.450.h
# spirv.h
# spirv.hpp
# spirv.hpp11
# spirv.json
# spirv.lua
# spirv.py
