package(default_visibility = ["//visibility:public"])

exports_files(glob(["**/*"]))

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
    hdrs = glob([
        "Include/**/*.h",
    ]),
    deps = [":vulkan-1"],
)

# GLSL.std.450.h
# spirv.h
# spirv.hpp
# spirv.hpp11
# spirv.json
# spirv.lua
# spirv.py
