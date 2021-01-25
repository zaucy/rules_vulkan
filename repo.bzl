load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@com_github_zaucy_rules_7zip//:repo.bzl", "http_7z")

_vulkan_sdk_well_knowns = {
    "1.2.162.1": struct(
        windows = struct(
            url = "https://sdk.lunarg.com/sdk/download/1.2.162.1/windows/VulkanSDK-1.2.162.1-Installer.exe",
            strip_prefix = "",
            sha256 = "ada71bb25f5775c648048d22185d65c0bf49678ac1060e9fa79edcafe9816440",
        ),
        linux = struct(
            url = "https://sdk.lunarg.com/sdk/download/1.2.162.1/linux/vulkansdk-linux-x86_64-1.2.162.1.tar.gz",
            strip_prefix = "1.2.162.1/x86_64",
            sha256 = "8314c1b000ed3f18f9e3c1f32c496dd3e654662249861371aa1724edef809177",
        ),
        macos = struct(
            url = "https://sdk.lunarg.com/sdk/download/1.2.162.1/mac/vulkansdk-macos-1.2.162.1.tar.gz",
            strip_prefix = "vulkansdk-macos-1.2.162.1/macOS",
            sha256 = "2781c334997598c2828d8a3368aef7b7c94a25204c90d5503396e40c7a03fd5c",
        ),
    ),
    "1.1.114.0": struct(
        windows = struct(
            url = "https://sdk.lunarg.com/sdk/download/1.1.114.0/windows/VulkanSDK-1.1.114.0-Installer.exe",
            strip_prefix = "",
            sha256 = "6233e3095b67b883a55b4fa61fd0376feecb1de1e0a7b3962fa7a85cdd0e663f",
        ),
        linux = struct(
            url = "https://sdk.lunarg.com/sdk/download/1.1.114.0/linux/vulkansdk-linux-x86_64-1.1.114.0.tar.gz",
            strip_prefix = "1.1.114.0/x86_64",
            sha256 = "796d3eedea9d2f5fd0720e5ebd9cc6072c95d5e958abea6d07b121db3973e968",
        ),
        macos = struct(
            url = "https://sdk.lunarg.com/sdk/download/1.1.114.0/mac/vulkansdk-macos-1.1.114.0.tar.gz",
            strip_prefix = "vulkansdk-macos-1.1.114.0/macOS",
            sha256 = "db5df93d10b7f689daad9a455baa4eeacb36826edc8270b45585559a4fbb5569",
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
        "@bazel_tools//src/conditions:darwin": _macos_{targetVarName},
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

def vulkan_repos(version = "1.2.162.1"):
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
