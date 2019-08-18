load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@com_github_zaucy_rules_7zip//:repo.bzl", "http_7z")

_vulkan_sdk_well_knowns = {
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
    )
}

def _vulkan_sdk_repo_impl(rctx):
    common_executables = [
        "glslangValidator",
        "glslc",
        "spirv-as",
        "spirv-cfg",
        "spriv-cross",
        "spriv-dis",
        "spirv-opt",
        "spirv-remap",
        "spirv-val",
    ]

    build_file_content = """
# This file is generated
package(default_visibility = ["//visibility:public"])
"""

    for commonExec in common_executables:
        commonExecVarName = commonExec.replace('-', '_')
        build_file_content += """
_windows_{execVarName} = "@vulkan_sdk_windows//:Bin/{execName}.exe"
_linux_{execVarName} = "@vulkan_sdk_linux//:bin/{execName}"
_macos_{execVarName} = "@vulkan_sdk_macos//:bin/{execName}"
alias(
    name = "{execName}",
    actual = select({{
        # Windows
        "@bazel_tools//src/conditions:windows": _windows_{execVarName},
        "@bazel_tools//src/conditions:windows_msvc": _windows_{execVarName},
        "@bazel_tools//src/conditions:windows_msys": _windows_{execVarName},

        # Linux
        "@bazel_tools//src/conditions:linux_x86_64": _linux_{execVarName},

        # MacOS
        "@bazel_tools//src/conditions:darwin": _macos_{execVarName},
        "@bazel_tools//src/conditions:darwin_x86_64": _macos_{execVarName},
    }}),
)
""".format(execName = commonExec, execVarName = commonExecVarName)

    rctx.file("WORKSPACE", content = "workspace(name = \"vulkan_sdk\")\n")
    rctx.file("BUILD.bazel", build_file_content)

_vulkan_sdk_repo = repository_rule(
    implementation = _vulkan_sdk_repo_impl,
    attrs = {},
)

def vulkan_repos(version = "1.1.114.0"):

    vulkan_sdk_info = _vulkan_sdk_well_knowns[version]

    export_all_build_file_content = """
exports_files(glob(["**/*"]), visibility = ["//visibility:public"])
    """

    http_7z(
        name = "vulkan_sdk_windows",
        url = vulkan_sdk_info.windows.url,
        # strip_prefix = vulkan_sdk_info.windows.strip_prefix,
        sha256 = vulkan_sdk_info.windows.sha256,
        build_file_content = export_all_build_file_content,
    )

    http_archive(
        name = "vulkan_sdk_linux",
        url = vulkan_sdk_info.linux.url,
        strip_prefix = vulkan_sdk_info.linux.strip_prefix,
        sha256 = vulkan_sdk_info.linux.sha256,
        build_file_content = export_all_build_file_content,
    )

    http_archive(
        name = "vulkan_sdk_macos",
        url = vulkan_sdk_info.macos.url,
        strip_prefix = vulkan_sdk_info.macos.strip_prefix,
        sha256 = vulkan_sdk_info.macos.sha256,
        build_file_content = export_all_build_file_content,
    )

    _vulkan_sdk_repo(name = "vulkan_sdk")
