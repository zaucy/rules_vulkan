#include "vulkan/vulkan.h"

#include <vector>

int main(int argc, char ** argv) {
    VkInstance instance_;

    VkApplicationInfo app_info{};
    app_info.sType = VK_STRUCTURE_TYPE_APPLICATION_INFO;
    app_info.pApplicationName = "Hello Triangle";
    app_info.applicationVersion = VK_MAKE_VERSION(1, 0, 0);
    app_info.pEngineName = "No Engine";
    app_info.engineVersion = VK_MAKE_VERSION(1, 0, 0);
    app_info.apiVersion = VK_API_VERSION_1_0;

    VkInstanceCreateInfo create_info{};
    create_info.sType = VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO;
    create_info.pApplicationInfo = &app_info;
    create_info.enabledLayerCount = 0;
    create_info.enabledLayerCount = 0;
    create_info.pNext = nullptr;
    create_info.enabledLayerCount = 0;
    create_info.ppEnabledLayerNames = nullptr;
    create_info.pNext = nullptr;

    VkResult result = vkCreateInstance(&create_info, nullptr, &instance_);
    if (result != VK_SUCCESS) {
    
    }
}
