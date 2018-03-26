module vulkan_windows;

// this module is in druntime
// no need for an external dependency
public import core.sys.windows.windows;
import erupted.platform_extensions;

// mixin platform code
mixin Platform_Extensions!VK_USE_PLATFORM_WIN32_KHR;