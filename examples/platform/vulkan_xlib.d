module vulkan_xlib;

// to your projects dub.sdl add:
// dependency "xlib-d" version = "~>0.1.1"
public import X11.Xlib;
import erupted.platform_extensions;

// mixin platform code
mixin Platform_Extensions!VK_USE_PLATFORM_XLIB_KHR;