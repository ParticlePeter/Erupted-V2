/**
 * Dlang vulkan platform specific types and functions as mixin template
 *
 * Copyright: Copyright 2015-2016 The Khronos Group Inc.; Copyright 2016 Alex Parrill, Peter Particle.
 * License:   $(https://opensource.org/licenses/MIT, MIT License).
 * Authors: Copyright 2016 Alex Parrill, Peter Particle
 */
module erupted.platform.mixin_extensions;

nothrow @nogc:


/// define platform extension names as enums
/// these enums can be used directly in Platform_Extensions mixin template
enum VK_KHR_xlib_surface;
enum VK_KHR_xcb_surface;
enum VK_KHR_wayland_surface;
enum VK_KHR_mir_surface;
enum VK_KHR_android_surface;
enum VK_KHR_win32_surface;
enum VK_KHR_external_memory_win32;
enum VK_KHR_win32_keyed_mutex;
enum VK_KHR_external_semaphore_win32;
enum VK_KHR_external_fence_win32;
enum VK_NV_external_memory_win32;
enum VK_NV_win32_keyed_mutex;
enum VK_NN_vi_surface;
enum VK_EXT_acquire_xlib_display;
enum VK_MVK_ios_surface;
enum VK_MVK_macos_surface;
enum VK_ANDROID_external_memory_android_hardware_buffer;


/// extensions to a specific platform are grouped in these enum sequences
import std.meta : AliasSeq;
alias VK_USE_PLATFORM_XLIB_KHR        = AliasSeq!( VK_KHR_xlib_surface );
alias VK_USE_PLATFORM_XCB_KHR         = AliasSeq!( VK_KHR_xcb_surface );
alias VK_USE_PLATFORM_WAYLAND_KHR     = AliasSeq!( VK_KHR_wayland_surface );
alias VK_USE_PLATFORM_MIR_KHR         = AliasSeq!( VK_KHR_mir_surface );
alias VK_USE_PLATFORM_ANDROID_KHR     = AliasSeq!( VK_KHR_android_surface, VK_ANDROID_external_memory_android_hardware_buffer );
alias VK_USE_PLATFORM_WIN32_KHR       = AliasSeq!( VK_KHR_win32_surface, VK_KHR_external_memory_win32, VK_KHR_win32_keyed_mutex, VK_KHR_external_semaphore_win32, VK_KHR_external_fence_win32, VK_NV_external_memory_win32, VK_NV_win32_keyed_mutex );
alias VK_USE_PLATFORM_VI_NN           = AliasSeq!( VK_NN_vi_surface );
alias VK_USE_PLATFORM_XLIB_XRANDR_EXT = AliasSeq!( VK_EXT_acquire_xlib_display );
alias VK_USE_PLATFORM_IOS_MVK         = AliasSeq!( VK_MVK_ios_surface );
alias VK_USE_PLATFORM_MACOS_MVK       = AliasSeq!( VK_MVK_macos_surface );



/// instantiate platform and extension specific code with this mixin template
/// required types and data structures must be imported into the module where
/// this template is instantiated
mixin template Platform_Extensions( extensions... ) {

    // publicly import erupted package modules
    public import erupted.types;
    public import erupted.functions;
    import erupted.dispatch_device;

    // remove duplicates from alias sequence
    // this might happen if a platform extension collection AND a single extension, which is included in the collection, was specified
    // e.g.: mixin Platform_Extensions!( VK_USE_PLATFORM_WIN32_KHR, VK_KHR_external_memory_win32 );
    import std.meta : NoDuplicates;
    alias noDuplicateExtensions = NoDuplicates!extensions;

    // 1. loop through alias sequence and mixin corresponding
    // extension types, aliased function pointer type definitions and __gshared function pointer declarations
    static foreach( extension; noDuplicateExtensions ) {

        // VK_KHR_xlib_surface : types and function pointer type aliases
        static if( __traits( isSame, extension, VK_KHR_xlib_surface )) {
                enum VK_KHR_xlib_surface = 1;

            enum VK_KHR_XLIB_SURFACE_SPEC_VERSION = 6;
            enum VK_KHR_XLIB_SURFACE_EXTENSION_NAME = "VK_KHR_xlib_surface";
            
            alias VkXlibSurfaceCreateFlagsKHR = VkFlags;
            
            struct VkXlibSurfaceCreateInfoKHR {
                VkStructureType              sType = VK_STRUCTURE_TYPE_XLIB_SURFACE_CREATE_INFO_KHR;
                const( void )*               pNext;
                VkXlibSurfaceCreateFlagsKHR  flags;
                Display*                     dpy;
                Window                       window;
            }
            
            alias PFN_vkCreateXlibSurfaceKHR                             = VkResult  function( VkInstance instance, const( VkXlibSurfaceCreateInfoKHR )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkSurfaceKHR* pSurface );
            alias PFN_vkGetPhysicalDeviceXlibPresentationSupportKHR      = VkBool32  function( VkPhysicalDevice physicalDevice, uint32_t queueFamilyIndex, Display* dpy, VisualID visualID );
        }

        // VK_KHR_xcb_surface : types and function pointer type aliases
        else static if( __traits( isSame, extension, VK_KHR_xcb_surface )) {
                enum VK_KHR_xcb_surface = 1;

            enum VK_KHR_XCB_SURFACE_SPEC_VERSION = 6;
            enum VK_KHR_XCB_SURFACE_EXTENSION_NAME = "VK_KHR_xcb_surface";
            
            alias VkXcbSurfaceCreateFlagsKHR = VkFlags;
            
            struct VkXcbSurfaceCreateInfoKHR {
                VkStructureType             sType = VK_STRUCTURE_TYPE_XCB_SURFACE_CREATE_INFO_KHR;
                const( void )*              pNext;
                VkXcbSurfaceCreateFlagsKHR  flags;
                xcb_connection_t*           connection;
                xcb_window_t                window;
            }
            
            alias PFN_vkCreateXcbSurfaceKHR                              = VkResult  function( VkInstance instance, const( VkXcbSurfaceCreateInfoKHR )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkSurfaceKHR* pSurface );
            alias PFN_vkGetPhysicalDeviceXcbPresentationSupportKHR       = VkBool32  function( VkPhysicalDevice physicalDevice, uint32_t queueFamilyIndex, xcb_connection_t* connection, xcb_visualid_t visual_id );
        }

        // VK_KHR_wayland_surface : types and function pointer type aliases
        else static if( __traits( isSame, extension, VK_KHR_wayland_surface )) {
                enum VK_KHR_wayland_surface = 1;

            enum VK_KHR_WAYLAND_SURFACE_SPEC_VERSION = 6;
            enum VK_KHR_WAYLAND_SURFACE_EXTENSION_NAME = "VK_KHR_wayland_surface";
            
            alias VkWaylandSurfaceCreateFlagsKHR = VkFlags;
            
            struct VkWaylandSurfaceCreateInfoKHR {
                VkStructureType                 sType = VK_STRUCTURE_TYPE_WAYLAND_SURFACE_CREATE_INFO_KHR;
                const( void )*                  pNext;
                VkWaylandSurfaceCreateFlagsKHR  flags;
                const( wl_display )*            display;
                const( wl_surface )*            surface;
            }
            
            alias PFN_vkCreateWaylandSurfaceKHR                          = VkResult  function( VkInstance instance, const( VkWaylandSurfaceCreateInfoKHR )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkSurfaceKHR* pSurface );
            alias PFN_vkGetPhysicalDeviceWaylandPresentationSupportKHR   = VkBool32  function( VkPhysicalDevice physicalDevice, uint32_t queueFamilyIndex, const( wl_display )* display );
        }

        // VK_KHR_mir_surface : types and function pointer type aliases
        else static if( __traits( isSame, extension, VK_KHR_mir_surface )) {
                enum VK_KHR_mir_surface = 1;

            enum VK_KHR_MIR_SURFACE_SPEC_VERSION = 4;
            enum VK_KHR_MIR_SURFACE_EXTENSION_NAME = "VK_KHR_mir_surface";
            
            alias VkMirSurfaceCreateFlagsKHR = VkFlags;
            
            struct VkMirSurfaceCreateInfoKHR {
                VkStructureType             sType = VK_STRUCTURE_TYPE_MIR_SURFACE_CREATE_INFO_KHR;
                const( void )*              pNext;
                VkMirSurfaceCreateFlagsKHR  flags;
                MirConnection*              connection;
                MirSurface*                 mirSurface;
            }
            
            alias PFN_vkCreateMirSurfaceKHR                              = VkResult  function( VkInstance instance, const( VkMirSurfaceCreateInfoKHR )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkSurfaceKHR* pSurface );
            alias PFN_vkGetPhysicalDeviceMirPresentationSupportKHR       = VkBool32  function( VkPhysicalDevice physicalDevice, uint32_t queueFamilyIndex, MirConnection* connection );
        }

        // VK_KHR_android_surface : types and function pointer type aliases
        else static if( __traits( isSame, extension, VK_KHR_android_surface )) {
                enum VK_KHR_android_surface = 1;

            enum VK_KHR_ANDROID_SURFACE_SPEC_VERSION = 6;
            enum VK_KHR_ANDROID_SURFACE_EXTENSION_NAME = "VK_KHR_android_surface";
            
            alias VkAndroidSurfaceCreateFlagsKHR = VkFlags;
            
            struct VkAndroidSurfaceCreateInfoKHR {
                VkStructureType                 sType = VK_STRUCTURE_TYPE_ANDROID_SURFACE_CREATE_INFO_KHR;
                const( void )*                  pNext;
                VkAndroidSurfaceCreateFlagsKHR  flags;
                const( ANativeWindow )*         window;
            }
            
            alias PFN_vkCreateAndroidSurfaceKHR                          = VkResult  function( VkInstance instance, const( VkAndroidSurfaceCreateInfoKHR )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkSurfaceKHR* pSurface );
        }

        // VK_KHR_win32_surface : types and function pointer type aliases
        else static if( __traits( isSame, extension, VK_KHR_win32_surface )) {
                enum VK_KHR_win32_surface = 1;

            enum VK_KHR_WIN32_SURFACE_SPEC_VERSION = 6;
            enum VK_KHR_WIN32_SURFACE_EXTENSION_NAME = "VK_KHR_win32_surface";
            
            alias VkWin32SurfaceCreateFlagsKHR = VkFlags;
            
            struct VkWin32SurfaceCreateInfoKHR {
                VkStructureType               sType = VK_STRUCTURE_TYPE_WIN32_SURFACE_CREATE_INFO_KHR;
                const( void )*                pNext;
                VkWin32SurfaceCreateFlagsKHR  flags;
                HINSTANCE                     hinstance;
                HWND                          hwnd;
            }
            
            alias PFN_vkCreateWin32SurfaceKHR                            = VkResult  function( VkInstance instance, const( VkWin32SurfaceCreateInfoKHR )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkSurfaceKHR* pSurface );
            alias PFN_vkGetPhysicalDeviceWin32PresentationSupportKHR     = VkBool32  function( VkPhysicalDevice physicalDevice, uint32_t queueFamilyIndex );
        }

        // VK_KHR_external_memory_win32 : types and function pointer type aliases
        else static if( __traits( isSame, extension, VK_KHR_external_memory_win32 )) {
                enum VK_KHR_external_memory_win32 = 1;

            enum VK_KHR_EXTERNAL_MEMORY_WIN32_SPEC_VERSION = 1;
            enum VK_KHR_EXTERNAL_MEMORY_WIN32_EXTENSION_NAME = "VK_KHR_external_memory_win32";
            
            struct VkImportMemoryWin32HandleInfoKHR {
                VkStructureType                     sType = VK_STRUCTURE_TYPE_IMPORT_MEMORY_WIN32_HANDLE_INFO_KHR;
                const( void )*                      pNext;
                VkExternalMemoryHandleTypeFlagBits  handleType;
                HANDLE                              handle;
                LPCWSTR                             name;
            }
            
            struct VkExportMemoryWin32HandleInfoKHR {
                VkStructureType                sType = VK_STRUCTURE_TYPE_EXPORT_MEMORY_WIN32_HANDLE_INFO_KHR;
                const( void )*                 pNext;
                const( SECURITY_ATTRIBUTES )*  pAttributes;
                DWORD                          dwAccess;
                LPCWSTR                        name;
            }
            
            struct VkMemoryWin32HandlePropertiesKHR {
                VkStructureType  sType = VK_STRUCTURE_TYPE_MEMORY_WIN32_HANDLE_PROPERTIES_KHR;
                void*            pNext;
                uint32_t         memoryTypeBits;
            }
            
            struct VkMemoryGetWin32HandleInfoKHR {
                VkStructureType                     sType = VK_STRUCTURE_TYPE_MEMORY_GET_WIN32_HANDLE_INFO_KHR;
                const( void )*                      pNext;
                VkDeviceMemory                      memory;
                VkExternalMemoryHandleTypeFlagBits  handleType;
            }
            
            alias PFN_vkGetMemoryWin32HandleKHR                          = VkResult  function( VkDevice device, const( VkMemoryGetWin32HandleInfoKHR )* pGetWin32HandleInfo, HANDLE* pHandle );
            alias PFN_vkGetMemoryWin32HandlePropertiesKHR                = VkResult  function( VkDevice device, VkExternalMemoryHandleTypeFlagBits handleType, HANDLE handle, VkMemoryWin32HandlePropertiesKHR* pMemoryWin32HandleProperties );
        }

        // VK_KHR_win32_keyed_mutex : types and function pointer type aliases
        else static if( __traits( isSame, extension, VK_KHR_win32_keyed_mutex )) {
                enum VK_KHR_win32_keyed_mutex = 1;

            enum VK_KHR_WIN32_KEYED_MUTEX_SPEC_VERSION = 1;
            enum VK_KHR_WIN32_KEYED_MUTEX_EXTENSION_NAME = "VK_KHR_win32_keyed_mutex";
            
            struct VkWin32KeyedMutexAcquireReleaseInfoKHR {
                VkStructureType           sType = VK_STRUCTURE_TYPE_WIN32_KEYED_MUTEX_ACQUIRE_RELEASE_INFO_KHR;
                const( void )*            pNext;
                uint32_t                  acquireCount;
                const( VkDeviceMemory )*  pAcquireSyncs;
                const( uint64_t )*        pAcquireKeys;
                const( uint32_t )*        pAcquireTimeouts;
                uint32_t                  releaseCount;
                const( VkDeviceMemory )*  pReleaseSyncs;
                const( uint64_t )*        pReleaseKeys;
            }
            
        }

        // VK_KHR_external_semaphore_win32 : types and function pointer type aliases
        else static if( __traits( isSame, extension, VK_KHR_external_semaphore_win32 )) {
                enum VK_KHR_external_semaphore_win32 = 1;

            enum VK_KHR_EXTERNAL_SEMAPHORE_WIN32_SPEC_VERSION = 1;
            enum VK_KHR_EXTERNAL_SEMAPHORE_WIN32_EXTENSION_NAME = "VK_KHR_external_semaphore_win32";
            
            struct VkImportSemaphoreWin32HandleInfoKHR {
                VkStructureType                        sType = VK_STRUCTURE_TYPE_IMPORT_SEMAPHORE_WIN32_HANDLE_INFO_KHR;
                const( void )*                         pNext;
                VkSemaphore                            semaphore;
                VkSemaphoreImportFlags                 flags;
                VkExternalSemaphoreHandleTypeFlagBits  handleType;
                HANDLE                                 handle;
                LPCWSTR                                name;
            }
            
            struct VkExportSemaphoreWin32HandleInfoKHR {
                VkStructureType                sType = VK_STRUCTURE_TYPE_EXPORT_SEMAPHORE_WIN32_HANDLE_INFO_KHR;
                const( void )*                 pNext;
                const( SECURITY_ATTRIBUTES )*  pAttributes;
                DWORD                          dwAccess;
                LPCWSTR                        name;
            }
            
            struct VkD3D12FenceSubmitInfoKHR {
                VkStructureType     sType = VK_STRUCTURE_TYPE_D3D12_FENCE_SUBMIT_INFO_KHR;
                const( void )*      pNext;
                uint32_t            waitSemaphoreValuesCount;
                const( uint64_t )*  pWaitSemaphoreValues;
                uint32_t            signalSemaphoreValuesCount;
                const( uint64_t )*  pSignalSemaphoreValues;
            }
            
            struct VkSemaphoreGetWin32HandleInfoKHR {
                VkStructureType                        sType = VK_STRUCTURE_TYPE_SEMAPHORE_GET_WIN32_HANDLE_INFO_KHR;
                const( void )*                         pNext;
                VkSemaphore                            semaphore;
                VkExternalSemaphoreHandleTypeFlagBits  handleType;
            }
            
            alias PFN_vkImportSemaphoreWin32HandleKHR                    = VkResult  function( VkDevice device, const( VkImportSemaphoreWin32HandleInfoKHR )* pImportSemaphoreWin32HandleInfo );
            alias PFN_vkGetSemaphoreWin32HandleKHR                       = VkResult  function( VkDevice device, const( VkSemaphoreGetWin32HandleInfoKHR )* pGetWin32HandleInfo, HANDLE* pHandle );
        }

        // VK_KHR_external_fence_win32 : types and function pointer type aliases
        else static if( __traits( isSame, extension, VK_KHR_external_fence_win32 )) {
                enum VK_KHR_external_fence_win32 = 1;

            enum VK_KHR_EXTERNAL_FENCE_WIN32_SPEC_VERSION = 1;
            enum VK_KHR_EXTERNAL_FENCE_WIN32_EXTENSION_NAME = "VK_KHR_external_fence_win32";
            
            struct VkImportFenceWin32HandleInfoKHR {
                VkStructureType                    sType = VK_STRUCTURE_TYPE_IMPORT_FENCE_WIN32_HANDLE_INFO_KHR;
                const( void )*                     pNext;
                VkFence                            fence;
                VkFenceImportFlags                 flags;
                VkExternalFenceHandleTypeFlagBits  handleType;
                HANDLE                             handle;
                LPCWSTR                            name;
            }
            
            struct VkExportFenceWin32HandleInfoKHR {
                VkStructureType                sType = VK_STRUCTURE_TYPE_EXPORT_FENCE_WIN32_HANDLE_INFO_KHR;
                const( void )*                 pNext;
                const( SECURITY_ATTRIBUTES )*  pAttributes;
                DWORD                          dwAccess;
                LPCWSTR                        name;
            }
            
            struct VkFenceGetWin32HandleInfoKHR {
                VkStructureType                    sType = VK_STRUCTURE_TYPE_FENCE_GET_WIN32_HANDLE_INFO_KHR;
                const( void )*                     pNext;
                VkFence                            fence;
                VkExternalFenceHandleTypeFlagBits  handleType;
            }
            
            alias PFN_vkImportFenceWin32HandleKHR                        = VkResult  function( VkDevice device, const( VkImportFenceWin32HandleInfoKHR )* pImportFenceWin32HandleInfo );
            alias PFN_vkGetFenceWin32HandleKHR                           = VkResult  function( VkDevice device, const( VkFenceGetWin32HandleInfoKHR )* pGetWin32HandleInfo, HANDLE* pHandle );
        }

        // VK_NV_external_memory_win32 : types and function pointer type aliases
        else static if( __traits( isSame, extension, VK_NV_external_memory_win32 )) {
                enum VK_NV_external_memory_win32 = 1;

            enum VK_NV_EXTERNAL_MEMORY_WIN32_SPEC_VERSION = 1;
            enum VK_NV_EXTERNAL_MEMORY_WIN32_EXTENSION_NAME = "VK_NV_external_memory_win32";
            
            struct VkImportMemoryWin32HandleInfoNV {
                VkStructureType                    sType = VK_STRUCTURE_TYPE_IMPORT_MEMORY_WIN32_HANDLE_INFO_NV;
                const( void )*                     pNext;
                VkExternalMemoryHandleTypeFlagsNV  handleType;
                HANDLE                             handle;
            }
            
            struct VkExportMemoryWin32HandleInfoNV {
                VkStructureType                sType = VK_STRUCTURE_TYPE_EXPORT_MEMORY_WIN32_HANDLE_INFO_NV;
                const( void )*                 pNext;
                const( SECURITY_ATTRIBUTES )*  pAttributes;
                DWORD                          dwAccess;
            }
            
            alias PFN_vkGetMemoryWin32HandleNV                           = VkResult  function( VkDevice device, VkDeviceMemory memory, VkExternalMemoryHandleTypeFlagsNV handleType, HANDLE* pHandle );
        }

        // VK_NV_win32_keyed_mutex : types and function pointer type aliases
        else static if( __traits( isSame, extension, VK_NV_win32_keyed_mutex )) {
                enum VK_NV_win32_keyed_mutex = 1;

            enum VK_NV_WIN32_KEYED_MUTEX_SPEC_VERSION = 1;
            enum VK_NV_WIN32_KEYED_MUTEX_EXTENSION_NAME = "VK_NV_win32_keyed_mutex";
            
            struct VkWin32KeyedMutexAcquireReleaseInfoNV {
                VkStructureType           sType = VK_STRUCTURE_TYPE_WIN32_KEYED_MUTEX_ACQUIRE_RELEASE_INFO_NV;
                const( void )*            pNext;
                uint32_t                  acquireCount;
                const( VkDeviceMemory )*  pAcquireSyncs;
                const( uint64_t )*        pAcquireKeys;
                const( uint32_t )*        pAcquireTimeoutMilliseconds;
                uint32_t                  releaseCount;
                const( VkDeviceMemory )*  pReleaseSyncs;
                const( uint64_t )*        pReleaseKeys;
            }
            
        }

        // VK_NN_vi_surface : types and function pointer type aliases
        else static if( __traits( isSame, extension, VK_NN_vi_surface )) {
                enum VK_NN_vi_surface = 1;

            enum VK_NN_VI_SURFACE_SPEC_VERSION = 1;
            enum VK_NN_VI_SURFACE_EXTENSION_NAME = "VK_NN_vi_surface";
            
            alias VkViSurfaceCreateFlagsNN = VkFlags;
            
            struct VkViSurfaceCreateInfoNN {
                VkStructureType           sType = VK_STRUCTURE_TYPE_VI_SURFACE_CREATE_INFO_NN;
                const( void )*            pNext;
                VkViSurfaceCreateFlagsNN  flags;
                void*                     window;
            }
            
            alias PFN_vkCreateViSurfaceNN                                = VkResult  function( VkInstance instance, const( VkViSurfaceCreateInfoNN )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkSurfaceKHR* pSurface );
        }

        // VK_EXT_acquire_xlib_display : types and function pointer type aliases
        else static if( __traits( isSame, extension, VK_EXT_acquire_xlib_display )) {
                enum VK_EXT_acquire_xlib_display = 1;

            enum VK_EXT_ACQUIRE_XLIB_DISPLAY_SPEC_VERSION = 1;
            enum VK_EXT_ACQUIRE_XLIB_DISPLAY_EXTENSION_NAME = "VK_EXT_acquire_xlib_display";
            
            alias PFN_vkAcquireXlibDisplayEXT                            = VkResult  function( VkPhysicalDevice physicalDevice, Display* dpy, VkDisplayKHR display );
            alias PFN_vkGetRandROutputDisplayEXT                         = VkResult  function( VkPhysicalDevice physicalDevice, Display* dpy, RROutput rrOutput, VkDisplayKHR* pDisplay );
        }

        // VK_MVK_ios_surface : types and function pointer type aliases
        else static if( __traits( isSame, extension, VK_MVK_ios_surface )) {
                enum VK_MVK_ios_surface = 1;

            enum VK_MVK_IOS_SURFACE_SPEC_VERSION = 2;
            enum VK_MVK_IOS_SURFACE_EXTENSION_NAME = "VK_MVK_ios_surface";
            
            alias VkIOSSurfaceCreateFlagsMVK = VkFlags;
            
            struct VkIOSSurfaceCreateInfoMVK {
                VkStructureType             sType = VK_STRUCTURE_TYPE_IOS_SURFACE_CREATE_INFO_MVK;
                const( void )*              pNext;
                VkIOSSurfaceCreateFlagsMVK  flags;
                const( void )*              pView;
            }
            
            alias PFN_vkCreateIOSSurfaceMVK                              = VkResult  function( VkInstance instance, const( VkIOSSurfaceCreateInfoMVK )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkSurfaceKHR* pSurface );
        }

        // VK_MVK_macos_surface : types and function pointer type aliases
        else static if( __traits( isSame, extension, VK_MVK_macos_surface )) {
                enum VK_MVK_macos_surface = 1;

            enum VK_MVK_MACOS_SURFACE_SPEC_VERSION = 2;
            enum VK_MVK_MACOS_SURFACE_EXTENSION_NAME = "VK_MVK_macos_surface";
            
            alias VkMacOSSurfaceCreateFlagsMVK = VkFlags;
            
            struct VkMacOSSurfaceCreateInfoMVK {
                VkStructureType               sType = VK_STRUCTURE_TYPE_MACOS_SURFACE_CREATE_INFO_MVK;
                const( void )*                pNext;
                VkMacOSSurfaceCreateFlagsMVK  flags;
                const( void )*                pView;
            }
            
            alias PFN_vkCreateMacOSSurfaceMVK                            = VkResult  function( VkInstance instance, const( VkMacOSSurfaceCreateInfoMVK )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkSurfaceKHR* pSurface );
        }

        // VK_ANDROID_external_memory_android_hardware_buffer : types and function pointer type aliases
        else static if( __traits( isSame, extension, VK_ANDROID_external_memory_android_hardware_buffer )) {
                enum VK_ANDROID_external_memory_android_hardware_buffer = 1;

            enum VK_ANDROID_EXTERNAL_MEMORY_ANDROID_HARDWARE_BUFFER_SPEC_VERSION = 3;
            enum VK_ANDROID_EXTERNAL_MEMORY_ANDROID_HARDWARE_BUFFER_EXTENSION_NAME = "VK_ANDROID_external_memory_android_hardware_buffer";
            
            struct VkAndroidHardwareBufferUsageANDROID {
                VkStructureType  sType = VK_STRUCTURE_TYPE_ANDROID_HARDWARE_BUFFER_USAGE_ANDROID;
                void*            pNext;
                uint64_t         androidHardwareBufferUsage;
            }
            
            struct VkAndroidHardwareBufferPropertiesANDROID {
                VkStructureType  sType = VK_STRUCTURE_TYPE_ANDROID_HARDWARE_BUFFER_PROPERTIES_ANDROID;
                void*            pNext;
                VkDeviceSize     allocationSize;
                uint32_t         memoryTypeBits;
            }
            
            struct VkAndroidHardwareBufferFormatPropertiesANDROID {
                VkStructureType                sType = VK_STRUCTURE_TYPE_ANDROID_HARDWARE_BUFFER_FORMAT_PROPERTIES_ANDROID;
                void*                          pNext;
                VkFormat                       format;
                uint64_t                       externalFormat;
                VkFormatFeatureFlags           formatFeatures;
                VkComponentMapping             samplerYcbcrConversionComponents;
                VkSamplerYcbcrModelConversion  suggestedYcbcrModel;
                VkSamplerYcbcrRange            suggestedYcbcrRange;
                VkChromaLocation               suggestedXChromaOffset;
                VkChromaLocation               suggestedYChromaOffset;
            }
            
            struct VkImportAndroidHardwareBufferInfoANDROID {
                VkStructureType            sType = VK_STRUCTURE_TYPE_IMPORT_ANDROID_HARDWARE_BUFFER_INFO_ANDROID;
                const( void )*             pNext;
                const( AHardwareBuffer )*  buffer;
            }
            
            struct VkMemoryGetAndroidHardwareBufferInfoANDROID {
                VkStructureType  sType = VK_STRUCTURE_TYPE_MEMORY_GET_ANDROID_HARDWARE_BUFFER_INFO_ANDROID;
                const( void )*   pNext;
                VkDeviceMemory   memory;
            }
            
            struct VkExternalFormatANDROID {
                VkStructureType  sType = VK_STRUCTURE_TYPE_EXTERNAL_FORMAT_ANDROID;
                void*            pNext;
                uint64_t         externalFormat;
            }
            
            alias PFN_vkGetAndroidHardwareBufferPropertiesANDROID        = VkResult  function( VkDevice device, const( AHardwareBuffer )* buffer, VkAndroidHardwareBufferPropertiesANDROID* pProperties );
            alias PFN_vkGetMemoryAndroidHardwareBufferANDROID            = VkResult  function( VkDevice device, const( VkMemoryGetAndroidHardwareBufferInfoANDROID )* pInfo, AHardwareBuffer pBuffer );
        }

        __gshared {

            // VK_KHR_xlib_surface : function pointer decelerations
            static if( __traits( isSame, extension, VK_KHR_xlib_surface )) {
                        enum VK_KHR_xlib_surface = 1;

                PFN_vkCreateXlibSurfaceKHR                             vkCreateXlibSurfaceKHR;
                PFN_vkGetPhysicalDeviceXlibPresentationSupportKHR      vkGetPhysicalDeviceXlibPresentationSupportKHR;
            }

            // VK_KHR_xcb_surface : function pointer decelerations
            else static if( __traits( isSame, extension, VK_KHR_xcb_surface )) {
                        enum VK_KHR_xcb_surface = 1;

                PFN_vkCreateXcbSurfaceKHR                              vkCreateXcbSurfaceKHR;
                PFN_vkGetPhysicalDeviceXcbPresentationSupportKHR       vkGetPhysicalDeviceXcbPresentationSupportKHR;
            }

            // VK_KHR_wayland_surface : function pointer decelerations
            else static if( __traits( isSame, extension, VK_KHR_wayland_surface )) {
                        enum VK_KHR_wayland_surface = 1;

                PFN_vkCreateWaylandSurfaceKHR                          vkCreateWaylandSurfaceKHR;
                PFN_vkGetPhysicalDeviceWaylandPresentationSupportKHR   vkGetPhysicalDeviceWaylandPresentationSupportKHR;
            }

            // VK_KHR_mir_surface : function pointer decelerations
            else static if( __traits( isSame, extension, VK_KHR_mir_surface )) {
                        enum VK_KHR_mir_surface = 1;

                PFN_vkCreateMirSurfaceKHR                              vkCreateMirSurfaceKHR;
                PFN_vkGetPhysicalDeviceMirPresentationSupportKHR       vkGetPhysicalDeviceMirPresentationSupportKHR;
            }

            // VK_KHR_android_surface : function pointer decelerations
            else static if( __traits( isSame, extension, VK_KHR_android_surface )) {
                        enum VK_KHR_android_surface = 1;

                PFN_vkCreateAndroidSurfaceKHR                          vkCreateAndroidSurfaceKHR;
            }

            // VK_KHR_win32_surface : function pointer decelerations
            else static if( __traits( isSame, extension, VK_KHR_win32_surface )) {
                        enum VK_KHR_win32_surface = 1;

                PFN_vkCreateWin32SurfaceKHR                            vkCreateWin32SurfaceKHR;
                PFN_vkGetPhysicalDeviceWin32PresentationSupportKHR     vkGetPhysicalDeviceWin32PresentationSupportKHR;
            }

            // VK_KHR_external_memory_win32 : function pointer decelerations
            else static if( __traits( isSame, extension, VK_KHR_external_memory_win32 )) {
                        enum VK_KHR_external_memory_win32 = 1;

                PFN_vkGetMemoryWin32HandleKHR                          vkGetMemoryWin32HandleKHR;
                PFN_vkGetMemoryWin32HandlePropertiesKHR                vkGetMemoryWin32HandlePropertiesKHR;
            }

            // VK_KHR_external_semaphore_win32 : function pointer decelerations
            else static if( __traits( isSame, extension, VK_KHR_external_semaphore_win32 )) {
                        enum VK_KHR_external_semaphore_win32 = 1;

                PFN_vkImportSemaphoreWin32HandleKHR                    vkImportSemaphoreWin32HandleKHR;
                PFN_vkGetSemaphoreWin32HandleKHR                       vkGetSemaphoreWin32HandleKHR;
            }

            // VK_KHR_external_fence_win32 : function pointer decelerations
            else static if( __traits( isSame, extension, VK_KHR_external_fence_win32 )) {
                        enum VK_KHR_external_fence_win32 = 1;

                PFN_vkImportFenceWin32HandleKHR                        vkImportFenceWin32HandleKHR;
                PFN_vkGetFenceWin32HandleKHR                           vkGetFenceWin32HandleKHR;
            }

            // VK_NV_external_memory_win32 : function pointer decelerations
            else static if( __traits( isSame, extension, VK_NV_external_memory_win32 )) {
                        enum VK_NV_external_memory_win32 = 1;

                PFN_vkGetMemoryWin32HandleNV                           vkGetMemoryWin32HandleNV;
            }

            // VK_NN_vi_surface : function pointer decelerations
            else static if( __traits( isSame, extension, VK_NN_vi_surface )) {
                        enum VK_NN_vi_surface = 1;

                PFN_vkCreateViSurfaceNN                                vkCreateViSurfaceNN;
            }

            // VK_EXT_acquire_xlib_display : function pointer decelerations
            else static if( __traits( isSame, extension, VK_EXT_acquire_xlib_display )) {
                        enum VK_EXT_acquire_xlib_display = 1;

                PFN_vkAcquireXlibDisplayEXT                            vkAcquireXlibDisplayEXT;
                PFN_vkGetRandROutputDisplayEXT                         vkGetRandROutputDisplayEXT;
            }

            // VK_MVK_ios_surface : function pointer decelerations
            else static if( __traits( isSame, extension, VK_MVK_ios_surface )) {
                        enum VK_MVK_ios_surface = 1;

                PFN_vkCreateIOSSurfaceMVK                              vkCreateIOSSurfaceMVK;
            }

            // VK_MVK_macos_surface : function pointer decelerations
            else static if( __traits( isSame, extension, VK_MVK_macos_surface )) {
                        enum VK_MVK_macos_surface = 1;

                PFN_vkCreateMacOSSurfaceMVK                            vkCreateMacOSSurfaceMVK;
            }

            // VK_ANDROID_external_memory_android_hardware_buffer : function pointer decelerations
            else static if( __traits( isSame, extension, VK_ANDROID_external_memory_android_hardware_buffer )) {
                        enum VK_ANDROID_external_memory_android_hardware_buffer = 1;

                PFN_vkGetAndroidHardwareBufferPropertiesANDROID        vkGetAndroidHardwareBufferPropertiesANDROID;
                PFN_vkGetMemoryAndroidHardwareBufferANDROID            vkGetMemoryAndroidHardwareBufferANDROID;
            }
        }
    }

    // compose a new loadInstanceLevelFunctions function out of
    // unextended original function and additional function pointers from extensions
    void loadInstanceLevelFunctions( VkInstance instance ) {

        // first load all non platform related function pointers from implementation
        erupted.functions.loadInstanceLevelFunctions( instance );

        // 2. loop through alias sequence and mixin corresponding
        // instance level function pointer definitions
        static foreach( extension; noDuplicateExtensions ) {

            // VK_KHR_xlib_surface : load instance level function definitions
            static if( __traits( isSame, extension, VK_KHR_xlib_surface )) {
                        enum VK_KHR_xlib_surface = 1;

                vkCreateXlibSurfaceKHR                             = cast( PFN_vkCreateXlibSurfaceKHR                             ) vkGetInstanceProcAddr( instance, "vkCreateXlibSurfaceKHR" );
                vkGetPhysicalDeviceXlibPresentationSupportKHR      = cast( PFN_vkGetPhysicalDeviceXlibPresentationSupportKHR      ) vkGetInstanceProcAddr( instance, "vkGetPhysicalDeviceXlibPresentationSupportKHR" );
            }

            // VK_KHR_xcb_surface : load instance level function definitions
            else static if( __traits( isSame, extension, VK_KHR_xcb_surface )) {
                        enum VK_KHR_xcb_surface = 1;

                vkCreateXcbSurfaceKHR                              = cast( PFN_vkCreateXcbSurfaceKHR                              ) vkGetInstanceProcAddr( instance, "vkCreateXcbSurfaceKHR" );
                vkGetPhysicalDeviceXcbPresentationSupportKHR       = cast( PFN_vkGetPhysicalDeviceXcbPresentationSupportKHR       ) vkGetInstanceProcAddr( instance, "vkGetPhysicalDeviceXcbPresentationSupportKHR" );
            }

            // VK_KHR_wayland_surface : load instance level function definitions
            else static if( __traits( isSame, extension, VK_KHR_wayland_surface )) {
                        enum VK_KHR_wayland_surface = 1;

                vkCreateWaylandSurfaceKHR                          = cast( PFN_vkCreateWaylandSurfaceKHR                          ) vkGetInstanceProcAddr( instance, "vkCreateWaylandSurfaceKHR" );
                vkGetPhysicalDeviceWaylandPresentationSupportKHR   = cast( PFN_vkGetPhysicalDeviceWaylandPresentationSupportKHR   ) vkGetInstanceProcAddr( instance, "vkGetPhysicalDeviceWaylandPresentationSupportKHR" );
            }

            // VK_KHR_mir_surface : load instance level function definitions
            else static if( __traits( isSame, extension, VK_KHR_mir_surface )) {
                        enum VK_KHR_mir_surface = 1;

                vkCreateMirSurfaceKHR                              = cast( PFN_vkCreateMirSurfaceKHR                              ) vkGetInstanceProcAddr( instance, "vkCreateMirSurfaceKHR" );
                vkGetPhysicalDeviceMirPresentationSupportKHR       = cast( PFN_vkGetPhysicalDeviceMirPresentationSupportKHR       ) vkGetInstanceProcAddr( instance, "vkGetPhysicalDeviceMirPresentationSupportKHR" );
            }

            // VK_KHR_android_surface : load instance level function definitions
            else static if( __traits( isSame, extension, VK_KHR_android_surface )) {
                        enum VK_KHR_android_surface = 1;

                vkCreateAndroidSurfaceKHR                          = cast( PFN_vkCreateAndroidSurfaceKHR                          ) vkGetInstanceProcAddr( instance, "vkCreateAndroidSurfaceKHR" );
            }

            // VK_KHR_win32_surface : load instance level function definitions
            else static if( __traits( isSame, extension, VK_KHR_win32_surface )) {
                        enum VK_KHR_win32_surface = 1;

                vkCreateWin32SurfaceKHR                            = cast( PFN_vkCreateWin32SurfaceKHR                            ) vkGetInstanceProcAddr( instance, "vkCreateWin32SurfaceKHR" );
                vkGetPhysicalDeviceWin32PresentationSupportKHR     = cast( PFN_vkGetPhysicalDeviceWin32PresentationSupportKHR     ) vkGetInstanceProcAddr( instance, "vkGetPhysicalDeviceWin32PresentationSupportKHR" );
            }

            // VK_NN_vi_surface : load instance level function definitions
            else static if( __traits( isSame, extension, VK_NN_vi_surface )) {
                        enum VK_NN_vi_surface = 1;

                vkCreateViSurfaceNN                                = cast( PFN_vkCreateViSurfaceNN                                ) vkGetInstanceProcAddr( instance, "vkCreateViSurfaceNN" );
            }

            // VK_EXT_acquire_xlib_display : load instance level function definitions
            else static if( __traits( isSame, extension, VK_EXT_acquire_xlib_display )) {
                        enum VK_EXT_acquire_xlib_display = 1;

                vkAcquireXlibDisplayEXT                            = cast( PFN_vkAcquireXlibDisplayEXT                            ) vkGetInstanceProcAddr( instance, "vkAcquireXlibDisplayEXT" );
                vkGetRandROutputDisplayEXT                         = cast( PFN_vkGetRandROutputDisplayEXT                         ) vkGetInstanceProcAddr( instance, "vkGetRandROutputDisplayEXT" );
            }

            // VK_MVK_ios_surface : load instance level function definitions
            else static if( __traits( isSame, extension, VK_MVK_ios_surface )) {
                        enum VK_MVK_ios_surface = 1;

                vkCreateIOSSurfaceMVK                              = cast( PFN_vkCreateIOSSurfaceMVK                              ) vkGetInstanceProcAddr( instance, "vkCreateIOSSurfaceMVK" );
            }

            // VK_MVK_macos_surface : load instance level function definitions
            else static if( __traits( isSame, extension, VK_MVK_macos_surface )) {
                        enum VK_MVK_macos_surface = 1;

                vkCreateMacOSSurfaceMVK                            = cast( PFN_vkCreateMacOSSurfaceMVK                            ) vkGetInstanceProcAddr( instance, "vkCreateMacOSSurfaceMVK" );
            }
        }
    }

    // compose a new loadDeviceLevelFunctions function out of
    // unextended original function and additional function pointers from extensions
    void loadDeviceLevelFunctions( VkInstance instance ) {

        // first load all non platform related function pointers from implementation
        erupted.functions.loadDeviceLevelFunctions( instance );

        // 3. loop through alias sequence and mixin corresponding
        // instance based device level function pointer definitions
        static foreach( extension; noDuplicateExtensions ) {

            // VK_KHR_external_memory_win32 : load instance based device level function definitions
            static if( __traits( isSame, extension, VK_KHR_external_memory_win32 )) {
                        enum VK_KHR_external_memory_win32 = 1;

                vkGetMemoryWin32HandleKHR                   = cast( PFN_vkGetMemoryWin32HandleKHR                   ) vkGetInstanceProcAddr( instance, "vkGetMemoryWin32HandleKHR" );
                vkGetMemoryWin32HandlePropertiesKHR         = cast( PFN_vkGetMemoryWin32HandlePropertiesKHR         ) vkGetInstanceProcAddr( instance, "vkGetMemoryWin32HandlePropertiesKHR" );
            }

            // VK_KHR_external_semaphore_win32 : load instance based device level function definitions
            else static if( __traits( isSame, extension, VK_KHR_external_semaphore_win32 )) {
                        enum VK_KHR_external_semaphore_win32 = 1;

                vkImportSemaphoreWin32HandleKHR             = cast( PFN_vkImportSemaphoreWin32HandleKHR             ) vkGetInstanceProcAddr( instance, "vkImportSemaphoreWin32HandleKHR" );
                vkGetSemaphoreWin32HandleKHR                = cast( PFN_vkGetSemaphoreWin32HandleKHR                ) vkGetInstanceProcAddr( instance, "vkGetSemaphoreWin32HandleKHR" );
            }

            // VK_KHR_external_fence_win32 : load instance based device level function definitions
            else static if( __traits( isSame, extension, VK_KHR_external_fence_win32 )) {
                        enum VK_KHR_external_fence_win32 = 1;

                vkImportFenceWin32HandleKHR                 = cast( PFN_vkImportFenceWin32HandleKHR                 ) vkGetInstanceProcAddr( instance, "vkImportFenceWin32HandleKHR" );
                vkGetFenceWin32HandleKHR                    = cast( PFN_vkGetFenceWin32HandleKHR                    ) vkGetInstanceProcAddr( instance, "vkGetFenceWin32HandleKHR" );
            }

            // VK_NV_external_memory_win32 : load instance based device level function definitions
            else static if( __traits( isSame, extension, VK_NV_external_memory_win32 )) {
                        enum VK_NV_external_memory_win32 = 1;

                vkGetMemoryWin32HandleNV                    = cast( PFN_vkGetMemoryWin32HandleNV                    ) vkGetInstanceProcAddr( instance, "vkGetMemoryWin32HandleNV" );
            }

            // VK_ANDROID_external_memory_android_hardware_buffer : load instance based device level function definitions
            else static if( __traits( isSame, extension, VK_ANDROID_external_memory_android_hardware_buffer )) {
                        enum VK_ANDROID_external_memory_android_hardware_buffer = 1;

                vkGetAndroidHardwareBufferPropertiesANDROID = cast( PFN_vkGetAndroidHardwareBufferPropertiesANDROID ) vkGetInstanceProcAddr( instance, "vkGetAndroidHardwareBufferPropertiesANDROID" );
                vkGetMemoryAndroidHardwareBufferANDROID     = cast( PFN_vkGetMemoryAndroidHardwareBufferANDROID     ) vkGetInstanceProcAddr( instance, "vkGetMemoryAndroidHardwareBufferANDROID" );
            }
        }
    }

    // compose a new device based loadDeviceLevelFunctions function
    // out of unextended original and additional function pointers from extensions
    void loadDeviceLevelFunctions( VkDevice device ) {

        // first load all non platform related function pointers from implementation
        erupted.functions.loadDeviceLevelFunctions( device );

        // 4. loop through alias sequence and mixin corresponding
        // device based device level function pointer definitions
        static foreach( extension; noDuplicateExtensions ) {

            // VK_KHR_external_memory_win32 : load device based device level function definitions
            static if( __traits( isSame, extension, VK_KHR_external_memory_win32 )) {
                        enum VK_KHR_external_memory_win32 = 1;

                vkGetMemoryWin32HandleKHR                   = cast( PFN_vkGetMemoryWin32HandleKHR                   ) vkGetDeviceProcAddr( device, "vkGetMemoryWin32HandleKHR" );
                vkGetMemoryWin32HandlePropertiesKHR         = cast( PFN_vkGetMemoryWin32HandlePropertiesKHR         ) vkGetDeviceProcAddr( device, "vkGetMemoryWin32HandlePropertiesKHR" );
            }

            // VK_KHR_external_semaphore_win32 : load device based device level function definitions
            else static if( __traits( isSame, extension, VK_KHR_external_semaphore_win32 )) {
                        enum VK_KHR_external_semaphore_win32 = 1;

                vkImportSemaphoreWin32HandleKHR             = cast( PFN_vkImportSemaphoreWin32HandleKHR             ) vkGetDeviceProcAddr( device, "vkImportSemaphoreWin32HandleKHR" );
                vkGetSemaphoreWin32HandleKHR                = cast( PFN_vkGetSemaphoreWin32HandleKHR                ) vkGetDeviceProcAddr( device, "vkGetSemaphoreWin32HandleKHR" );
            }

            // VK_KHR_external_fence_win32 : load device based device level function definitions
            else static if( __traits( isSame, extension, VK_KHR_external_fence_win32 )) {
                        enum VK_KHR_external_fence_win32 = 1;

                vkImportFenceWin32HandleKHR                 = cast( PFN_vkImportFenceWin32HandleKHR                 ) vkGetDeviceProcAddr( device, "vkImportFenceWin32HandleKHR" );
                vkGetFenceWin32HandleKHR                    = cast( PFN_vkGetFenceWin32HandleKHR                    ) vkGetDeviceProcAddr( device, "vkGetFenceWin32HandleKHR" );
            }

            // VK_NV_external_memory_win32 : load device based device level function definitions
            else static if( __traits( isSame, extension, VK_NV_external_memory_win32 )) {
                        enum VK_NV_external_memory_win32 = 1;

                vkGetMemoryWin32HandleNV                    = cast( PFN_vkGetMemoryWin32HandleNV                    ) vkGetDeviceProcAddr( device, "vkGetMemoryWin32HandleNV" );
            }

            // VK_ANDROID_external_memory_android_hardware_buffer : load device based device level function definitions
            else static if( __traits( isSame, extension, VK_ANDROID_external_memory_android_hardware_buffer )) {
                        enum VK_ANDROID_external_memory_android_hardware_buffer = 1;

                vkGetAndroidHardwareBufferPropertiesANDROID = cast( PFN_vkGetAndroidHardwareBufferPropertiesANDROID ) vkGetDeviceProcAddr( device, "vkGetAndroidHardwareBufferPropertiesANDROID" );
                vkGetMemoryAndroidHardwareBufferANDROID     = cast( PFN_vkGetMemoryAndroidHardwareBufferANDROID     ) vkGetDeviceProcAddr( device, "vkGetMemoryAndroidHardwareBufferANDROID" );
            }
        }
    }

    // compose a new dispatch device out of unextended original dispatch device with
    // extended device based loadDeviceLevelFunctions member function,
    // device and command buffer based function pointer decelerations
    struct DispatchDevice {

        // use unextended dispatch device from module erupted.functions as member and alias this
        erupted.dispatch_device.DispatchDevice commonDispatchDevice;
        alias commonDispatchDevice this;

        // Constructor forwards parameter 'device' to 'this.loadDeviceLevelFunctions'
        this( VkDevice device ) {
            this.loadDeviceLevelFunctions( device );
        }

        // compose a new device based loadDeviceLevelFunctions member function
        // out of unextended original and additional member function pointers from extensions
        void loadDeviceLevelFunctions( VkDevice device ) {

            // first load all non platform related member function pointers of wrapped commonDispatchDevice
            commonDispatchDevice.loadDeviceLevelFunctions( device );

            // 5. loop through alias sequence and mixin corresponding
            // device level member function pointer definitions of this wrapping DispatchDevice
            static foreach( extension; noDuplicateExtensions ) {

                // VK_KHR_external_memory_win32 : load dispatch device member function definitions
                static if( __traits( isSame, extension, VK_KHR_external_memory_win32 )) {
                                enum VK_KHR_external_memory_win32 = 1;

                    vkGetMemoryWin32HandleKHR                   = cast( PFN_vkGetMemoryWin32HandleKHR                   ) vkGetDeviceProcAddr( device, "vkGetMemoryWin32HandleKHR" );
                    vkGetMemoryWin32HandlePropertiesKHR         = cast( PFN_vkGetMemoryWin32HandlePropertiesKHR         ) vkGetDeviceProcAddr( device, "vkGetMemoryWin32HandlePropertiesKHR" );
                }

                // VK_KHR_external_semaphore_win32 : load dispatch device member function definitions
                else static if( __traits( isSame, extension, VK_KHR_external_semaphore_win32 )) {
                                enum VK_KHR_external_semaphore_win32 = 1;

                    vkImportSemaphoreWin32HandleKHR             = cast( PFN_vkImportSemaphoreWin32HandleKHR             ) vkGetDeviceProcAddr( device, "vkImportSemaphoreWin32HandleKHR" );
                    vkGetSemaphoreWin32HandleKHR                = cast( PFN_vkGetSemaphoreWin32HandleKHR                ) vkGetDeviceProcAddr( device, "vkGetSemaphoreWin32HandleKHR" );
                }

                // VK_KHR_external_fence_win32 : load dispatch device member function definitions
                else static if( __traits( isSame, extension, VK_KHR_external_fence_win32 )) {
                                enum VK_KHR_external_fence_win32 = 1;

                    vkImportFenceWin32HandleKHR                 = cast( PFN_vkImportFenceWin32HandleKHR                 ) vkGetDeviceProcAddr( device, "vkImportFenceWin32HandleKHR" );
                    vkGetFenceWin32HandleKHR                    = cast( PFN_vkGetFenceWin32HandleKHR                    ) vkGetDeviceProcAddr( device, "vkGetFenceWin32HandleKHR" );
                }

                // VK_NV_external_memory_win32 : load dispatch device member function definitions
                else static if( __traits( isSame, extension, VK_NV_external_memory_win32 )) {
                                enum VK_NV_external_memory_win32 = 1;

                    vkGetMemoryWin32HandleNV                    = cast( PFN_vkGetMemoryWin32HandleNV                    ) vkGetDeviceProcAddr( device, "vkGetMemoryWin32HandleNV" );
                }

                // VK_ANDROID_external_memory_android_hardware_buffer : load dispatch device member function definitions
                else static if( __traits( isSame, extension, VK_ANDROID_external_memory_android_hardware_buffer )) {
                                enum VK_ANDROID_external_memory_android_hardware_buffer = 1;

                    vkGetAndroidHardwareBufferPropertiesANDROID = cast( PFN_vkGetAndroidHardwareBufferPropertiesANDROID ) vkGetDeviceProcAddr( device, "vkGetAndroidHardwareBufferPropertiesANDROID" );
                    vkGetMemoryAndroidHardwareBufferANDROID     = cast( PFN_vkGetMemoryAndroidHardwareBufferANDROID     ) vkGetDeviceProcAddr( device, "vkGetMemoryAndroidHardwareBufferANDROID" );
                }
            }
        }

        // 6. loop through alias sequence and mixin corresponding convenience member functions
        // omitting device parameter of this wrapping DispatchDevice. Member vkDevice of commonDispatchDevice is used instead
        static foreach( extension; noDuplicateExtensions ) {

            // VK_KHR_external_memory_win32 : dispatch device convenience member functions
            static if( __traits( isSame, extension, VK_KHR_external_memory_win32 )) {
                        enum VK_KHR_external_memory_win32 = 1;

                VkResult  GetMemoryWin32HandleKHR( const( VkMemoryGetWin32HandleInfoKHR )* pGetWin32HandleInfo, HANDLE* pHandle ) { return vkGetMemoryWin32HandleKHR( vkDevice, pGetWin32HandleInfo, pHandle ); }
                VkResult  GetMemoryWin32HandlePropertiesKHR( VkExternalMemoryHandleTypeFlagBits handleType, HANDLE handle, VkMemoryWin32HandlePropertiesKHR* pMemoryWin32HandleProperties ) { return vkGetMemoryWin32HandlePropertiesKHR( vkDevice, handleType, handle, pMemoryWin32HandleProperties ); }
            }

            // VK_KHR_external_semaphore_win32 : dispatch device convenience member functions
            else static if( __traits( isSame, extension, VK_KHR_external_semaphore_win32 )) {
                        enum VK_KHR_external_semaphore_win32 = 1;

                VkResult  ImportSemaphoreWin32HandleKHR( const( VkImportSemaphoreWin32HandleInfoKHR )* pImportSemaphoreWin32HandleInfo ) { return vkImportSemaphoreWin32HandleKHR( vkDevice, pImportSemaphoreWin32HandleInfo ); }
                VkResult  GetSemaphoreWin32HandleKHR( const( VkSemaphoreGetWin32HandleInfoKHR )* pGetWin32HandleInfo, HANDLE* pHandle ) { return vkGetSemaphoreWin32HandleKHR( vkDevice, pGetWin32HandleInfo, pHandle ); }
            }

            // VK_KHR_external_fence_win32 : dispatch device convenience member functions
            else static if( __traits( isSame, extension, VK_KHR_external_fence_win32 )) {
                        enum VK_KHR_external_fence_win32 = 1;

                VkResult  ImportFenceWin32HandleKHR( const( VkImportFenceWin32HandleInfoKHR )* pImportFenceWin32HandleInfo ) { return vkImportFenceWin32HandleKHR( vkDevice, pImportFenceWin32HandleInfo ); }
                VkResult  GetFenceWin32HandleKHR( const( VkFenceGetWin32HandleInfoKHR )* pGetWin32HandleInfo, HANDLE* pHandle ) { return vkGetFenceWin32HandleKHR( vkDevice, pGetWin32HandleInfo, pHandle ); }
            }

            // VK_NV_external_memory_win32 : dispatch device convenience member functions
            else static if( __traits( isSame, extension, VK_NV_external_memory_win32 )) {
                        enum VK_NV_external_memory_win32 = 1;

                VkResult  GetMemoryWin32HandleNV( VkDeviceMemory memory, VkExternalMemoryHandleTypeFlagsNV handleType, HANDLE* pHandle ) { return vkGetMemoryWin32HandleNV( vkDevice, memory, handleType, pHandle ); }
            }

            // VK_ANDROID_external_memory_android_hardware_buffer : dispatch device convenience member functions
            else static if( __traits( isSame, extension, VK_ANDROID_external_memory_android_hardware_buffer )) {
                        enum VK_ANDROID_external_memory_android_hardware_buffer = 1;

                VkResult  GetAndroidHardwareBufferPropertiesANDROID( const( AHardwareBuffer )* buffer, VkAndroidHardwareBufferPropertiesANDROID* pProperties ) { return vkGetAndroidHardwareBufferPropertiesANDROID( vkDevice, buffer, pProperties ); }
                VkResult  GetMemoryAndroidHardwareBufferANDROID( const( VkMemoryGetAndroidHardwareBufferInfoANDROID )* pInfo, AHardwareBuffer pBuffer ) { return vkGetMemoryAndroidHardwareBufferANDROID( vkDevice, pInfo, pBuffer ); }
            }
        }

        // 7. loop last time through alias sequence and mixin corresponding function pointer declarations
        static foreach( extension; noDuplicateExtensions ) {

            // VK_KHR_xlib_surface : dispatch device member function pointer decelerations
            static if( __traits( isSame, extension, VK_KHR_xlib_surface )) {
                        enum VK_KHR_xlib_surface = 1;

                PFN_vkCreateXlibSurfaceKHR                             vkCreateXlibSurfaceKHR;
                PFN_vkGetPhysicalDeviceXlibPresentationSupportKHR      vkGetPhysicalDeviceXlibPresentationSupportKHR;
            }

            // VK_KHR_xcb_surface : dispatch device member function pointer decelerations
            else static if( __traits( isSame, extension, VK_KHR_xcb_surface )) {
                        enum VK_KHR_xcb_surface = 1;

                PFN_vkCreateXcbSurfaceKHR                              vkCreateXcbSurfaceKHR;
                PFN_vkGetPhysicalDeviceXcbPresentationSupportKHR       vkGetPhysicalDeviceXcbPresentationSupportKHR;
            }

            // VK_KHR_wayland_surface : dispatch device member function pointer decelerations
            else static if( __traits( isSame, extension, VK_KHR_wayland_surface )) {
                        enum VK_KHR_wayland_surface = 1;

                PFN_vkCreateWaylandSurfaceKHR                          vkCreateWaylandSurfaceKHR;
                PFN_vkGetPhysicalDeviceWaylandPresentationSupportKHR   vkGetPhysicalDeviceWaylandPresentationSupportKHR;
            }

            // VK_KHR_mir_surface : dispatch device member function pointer decelerations
            else static if( __traits( isSame, extension, VK_KHR_mir_surface )) {
                        enum VK_KHR_mir_surface = 1;

                PFN_vkCreateMirSurfaceKHR                              vkCreateMirSurfaceKHR;
                PFN_vkGetPhysicalDeviceMirPresentationSupportKHR       vkGetPhysicalDeviceMirPresentationSupportKHR;
            }

            // VK_KHR_android_surface : dispatch device member function pointer decelerations
            else static if( __traits( isSame, extension, VK_KHR_android_surface )) {
                        enum VK_KHR_android_surface = 1;

                PFN_vkCreateAndroidSurfaceKHR                          vkCreateAndroidSurfaceKHR;
            }

            // VK_KHR_win32_surface : dispatch device member function pointer decelerations
            else static if( __traits( isSame, extension, VK_KHR_win32_surface )) {
                        enum VK_KHR_win32_surface = 1;

                PFN_vkCreateWin32SurfaceKHR                            vkCreateWin32SurfaceKHR;
                PFN_vkGetPhysicalDeviceWin32PresentationSupportKHR     vkGetPhysicalDeviceWin32PresentationSupportKHR;
            }

            // VK_KHR_external_memory_win32 : dispatch device member function pointer decelerations
            else static if( __traits( isSame, extension, VK_KHR_external_memory_win32 )) {
                        enum VK_KHR_external_memory_win32 = 1;

                PFN_vkGetMemoryWin32HandleKHR                          vkGetMemoryWin32HandleKHR;
                PFN_vkGetMemoryWin32HandlePropertiesKHR                vkGetMemoryWin32HandlePropertiesKHR;
            }

            // VK_KHR_external_semaphore_win32 : dispatch device member function pointer decelerations
            else static if( __traits( isSame, extension, VK_KHR_external_semaphore_win32 )) {
                        enum VK_KHR_external_semaphore_win32 = 1;

                PFN_vkImportSemaphoreWin32HandleKHR                    vkImportSemaphoreWin32HandleKHR;
                PFN_vkGetSemaphoreWin32HandleKHR                       vkGetSemaphoreWin32HandleKHR;
            }

            // VK_KHR_external_fence_win32 : dispatch device member function pointer decelerations
            else static if( __traits( isSame, extension, VK_KHR_external_fence_win32 )) {
                        enum VK_KHR_external_fence_win32 = 1;

                PFN_vkImportFenceWin32HandleKHR                        vkImportFenceWin32HandleKHR;
                PFN_vkGetFenceWin32HandleKHR                           vkGetFenceWin32HandleKHR;
            }

            // VK_NV_external_memory_win32 : dispatch device member function pointer decelerations
            else static if( __traits( isSame, extension, VK_NV_external_memory_win32 )) {
                        enum VK_NV_external_memory_win32 = 1;

                PFN_vkGetMemoryWin32HandleNV                           vkGetMemoryWin32HandleNV;
            }

            // VK_NN_vi_surface : dispatch device member function pointer decelerations
            else static if( __traits( isSame, extension, VK_NN_vi_surface )) {
                        enum VK_NN_vi_surface = 1;

                PFN_vkCreateViSurfaceNN                                vkCreateViSurfaceNN;
            }

            // VK_EXT_acquire_xlib_display : dispatch device member function pointer decelerations
            else static if( __traits( isSame, extension, VK_EXT_acquire_xlib_display )) {
                        enum VK_EXT_acquire_xlib_display = 1;

                PFN_vkAcquireXlibDisplayEXT                            vkAcquireXlibDisplayEXT;
                PFN_vkGetRandROutputDisplayEXT                         vkGetRandROutputDisplayEXT;
            }

            // VK_MVK_ios_surface : dispatch device member function pointer decelerations
            else static if( __traits( isSame, extension, VK_MVK_ios_surface )) {
                        enum VK_MVK_ios_surface = 1;

                PFN_vkCreateIOSSurfaceMVK                              vkCreateIOSSurfaceMVK;
            }

            // VK_MVK_macos_surface : dispatch device member function pointer decelerations
            else static if( __traits( isSame, extension, VK_MVK_macos_surface )) {
                        enum VK_MVK_macos_surface = 1;

                PFN_vkCreateMacOSSurfaceMVK                            vkCreateMacOSSurfaceMVK;
            }

            // VK_ANDROID_external_memory_android_hardware_buffer : dispatch device member function pointer decelerations
            else static if( __traits( isSame, extension, VK_ANDROID_external_memory_android_hardware_buffer )) {
                        enum VK_ANDROID_external_memory_android_hardware_buffer = 1;

                PFN_vkGetAndroidHardwareBufferPropertiesANDROID        vkGetAndroidHardwareBufferPropertiesANDROID;
                PFN_vkGetMemoryAndroidHardwareBufferANDROID            vkGetMemoryAndroidHardwareBufferANDROID;
            }
        }
    }
}
