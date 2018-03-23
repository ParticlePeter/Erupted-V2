module vulkan_xcb;

// to your projects dub.sdl add:
// dependency "xcb-d" version = "~>2.1.0"
public import xcb.xcb;
import erupted.platform.mixin_extensions;

// mixin platform code
mixin Platform_Extensions!VK_USE_PLATFORM_XCB_KHR;