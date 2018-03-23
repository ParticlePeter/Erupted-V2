module erupted.platform.windows;

public import core.sys.windows.windows;
import erupted.platform.mixin_extensions;

mixin Platform_Extensions!VK_USE_PLATFORM_WIN32_KHR;