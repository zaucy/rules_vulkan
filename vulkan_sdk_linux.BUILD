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
    hdrs = glob([
        "include/**/*.h",
    ]),
    strip_include_prefix = "include",
    deps = [":vulkan-1"],
)
