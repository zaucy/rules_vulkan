# Vulkan SDK with Bazel

## Installation

rules_vulkan relies on [rules_7zip](https://github.com/zaucy/rules_7zip) for extracting the vulkan sdk on windows

```python
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "com_github_zaucy_rules_7zip",
    strip_prefix = "rules_7zip-e95ba876db445cf2c925c02c4bc18ed37a503fd8",
    url = "https://github.com/zaucy/rules_7zip/archive/e95ba876db445cf2c925c02c4bc18ed37a503fd8.zip",
    sha256 = "b66e1c712577b0c029d4c94228dba9c8aacdcdeb88c3b1eeeffd00247ba5a856",
)

load("@com_github_zaucy_rules_7zip//:setup.bzl", "setup_7zip")
setup_7zip()

http_archive(
    name = "com_github_zaucy_rules_vulkan",
    strip_prefix = "rules_vulkan-33e9a8d0c236dcfb21dc890ea319c36d7cfab010",
    url = "https://github.com/zaucy/rules_vulkan/archive/33e9a8d0c236dcfb21dc890ea319c36d7cfab010.zip",
    sha256 = "7732cf33196c10ad581a935344d1822ae56adde7a41954cb777932e9fd619453",
)

load("@com_github_zaucy_rules_vulkan//:repo.bzl", "vulkan_repos")
vulkan_repos()

```

## License

This repository is licensed under MIT. Please note that rules_vulkan downloads the Vulkan SDK from [LunarG](https://www.lunarg.com/) which has it's own licenses and agreements you must adhere to.
