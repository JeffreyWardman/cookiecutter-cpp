if(UNIX AND NOT APPLE)
    set(TRIPLET "x64-linux")
    set(CMAKE_CXX_FLAGS "-Wall -Wextra")
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -g")
elseif(APPLE)
    # Apple Silicon-specific
    set(TRIPLET "arm64-osx")     
    set(CMAKE_CXX_FLAGS "-Wall -Wextra")
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -g")
elseif(WIN64)
    set(TRIPLET "x64-windows")
    # Prevent a "command line is too long" failure in Windows.
    set(CMAKE_NINJA_FORCE_RESPONSE_FILE "ON" CACHE BOOL "Force Ninja to use response files.")
else()
    # Handle other/unknown platforms if necessary
    message("Unknown platform detected")
endif()

set(CMAKE_CXX_FLAGS_Release "${CMAKE_CXX_FLAGS_Release} -O3")

if (NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose the type of build." FORCE)
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()

# Enable experimental C++ modules (if needed for your compiler)
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    add_compile_options(-fmodules-ts)
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    add_compile_options(-fmodules)
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    add_compile_options(/experimental:module)
endif()
