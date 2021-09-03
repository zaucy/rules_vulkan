package(default_visibility = ["//visibility:public"])

exports_files(glob(["**/*"]))

alias(
    name = "glslangValidator",
    actual = "bin/glslangValidator",
)

alias(
    name = "glslc",
    actual = "bin/glslc",
)

alias(
    name = "spirv-as",
    actual = "bin/spirv-as",
)

alias(
    name = "spirv-cfg",
    actual = "bin/spirv-cfg",
)

alias(
    name = "spriv-cross",
    actual = "bin/spriv-cross",
)

alias(
    name = "spriv-dis",
    actual = "bin/spriv-dis",
)

alias(
    name = "spirv-opt",
    actual = "bin/spirv-opt",
)

alias(
    name = "spirv-remap",
    actual = "bin/spirv-remap",
)

alias(
    name = "spirv-val",
    actual = "bin/spirv-val",
)

cc_import(
    name = "vulkan-1",
    shared_library = "lib/libvulkan.so.1",
    visibility = ["//visibility:private"],
)

cc_library(
    name = "vulkan",
    hdrs = [
        "include/vulkan/vk_icd.h",
        "include/vulkan/vk_layer.h",
        "include/vulkan/vk_platform.h",
        "include/vulkan/vk_sdk_platform.h",
        "include/vulkan/vulkan.h",
        "include/vulkan/vulkan.hpp",
        "include/vulkan/vulkan_android.h",
        "include/vulkan/vulkan_core.h",
        "include/vulkan/vulkan_fuchsia.h",
        "include/vulkan/vulkan_ggp.h",
        "include/vulkan/vulkan_ios.h",
        "include/vulkan/vulkan_macos.h",
        "include/vulkan/vulkan_metal.h",
        "include/vulkan/vulkan_vi.h",
        "include/vulkan/vulkan_wayland.h",
        "include/vulkan/vulkan_win32.h",
        "include/vulkan/vulkan_xcb.h",
        "include/vulkan/vulkan_xlib.h",
        "include/vulkan/vulkan_xlib_xrandr.h",
    ],
    strip_include_prefix = "include",
    deps = [":vulkan-1"],
)
