load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@com_github_zaucy_rules_7zip//:repo.bzl", "http_7z")

_vulkan_sdk_well_knowns = {
    "1.3.243.0": struct(
        windows = struct(
            url = "https://sdk.lunarg.com/sdk/download/1.3.243.0/windows/VulkanSDK-1.3.243.0-Installer.exe",
            strip_prefix = "",
            sha256 = "a45954b5f0ae682d43268df6e548168de58809240efb021f52531a631760caaf",
        ),
        linux = struct(
            url = "https://sdk.lunarg.com/sdk/download/1.3.243.0/linux/vulkansdk-linux-x86_64-1.3.243.0.tar.gz",
            strip_prefix = "1.3.243.0/x86_64",
            sha256 = "3bc06935f3363307daf68eb744e11e46d31f6b0a9e9f1d0d59271471ea27ad7c",
        ),
        macos = struct(
            url = "https://vertexwahn.de/lfs/v1/vulkansdk-macos-1.3.243.0.zip",
            strip_prefix = "VulkanSDK/1.3.243.0/macOS",
            sha256 = "6d769f313ce0e7f6bdd10dc207f88777d0774d2be65f574670fe462529f4dd11",
        ),
    ),
}

def _vulkan_sdk_repo_impl(rctx):
    commonTargets = [
        # Pre-built executables
        "glslangValidator",
        "glslc",
        "spirv-as",
        "spirv-cfg",
        "spriv-cross",
        "spriv-dis",
        "spirv-opt",
        "spirv-remap",
        "spirv-val",

        # C/C++ Libraries
        "vulkan",
    ]

    build_file_content = ""

    for commonTarget in commonTargets:
        commonTargetVarName = commonTarget.replace("-", "_")
        build_file_content += """
_windows_{targetVarName} = "@vulkan_sdk_windows//:{targetName}"
_linux_{targetVarName} = "@vulkan_sdk_linux//:{targetName}"
_macos_{targetVarName} = "@vulkan_sdk_macos//:{targetName}"
alias(
    name = "{targetName}",
    visibility = ["//visibility:public"],
    actual = select({{
        # Windows
        "@bazel_tools//src/conditions:windows": _windows_{targetVarName},
        "@bazel_tools//src/conditions:windows_msvc": _windows_{targetVarName},

        # Linux
        "@bazel_tools//src/conditions:linux_x86_64": _linux_{targetVarName},

        # MacOS
        #"@bazel_tools//src/conditions:darwin": _macos_{targetVarName},
        "@bazel_tools//src/conditions:darwin_x86_64": _macos_{targetVarName},
    }}),
)
""".format(targetName = commonTarget, targetVarName = commonTargetVarName)

    rctx.file("WORKSPACE", content = "workspace(name = \"vulkan_sdk\")\n")
    rctx.file("BUILD.bazel", build_file_content)

_vulkan_sdk_repo = repository_rule(
    implementation = _vulkan_sdk_repo_impl,
    attrs = {
        "version": attr.string(),
    },
)

def vulkan_repos(version = "1.3.243.0"):
    ws = "@com_github_zaucy_rules_vulkan//"

    vulkan_sdk_info = _vulkan_sdk_well_knowns[version]

    http_7z(
        name = "vulkan_sdk_windows",
        url = vulkan_sdk_info.windows.url,
        # strip_prefix = vulkan_sdk_info.windows.strip_prefix,
        sha256 = vulkan_sdk_info.windows.sha256,
        build_file = ws + ":vulkan_sdk_windows.BUILD",
    )

    http_archive(
        name = "vulkan_sdk_linux",
        url = vulkan_sdk_info.linux.url,
        strip_prefix = vulkan_sdk_info.linux.strip_prefix,
        sha256 = vulkan_sdk_info.linux.sha256,
        build_file = ws + ":vulkan_sdk_linux.BUILD",
    )

    http_archive(
        name = "vulkan_sdk_macos",
        url = vulkan_sdk_info.macos.url,
        strip_prefix = vulkan_sdk_info.macos.strip_prefix,
        sha256 = vulkan_sdk_info.macos.sha256,
        build_file = ws + ":vulkan_sdk_macos.BUILD",
    )

    _vulkan_sdk_repo(name = "vulkan_sdk", version = version)
