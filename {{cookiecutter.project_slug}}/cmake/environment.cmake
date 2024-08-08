if(UNIX AND NOT APPLE)
    set(TRIPLET "x64-linux")
    set(CMAKE_OSX_ARCHITECTURES "x64")
    set(CMAKE_CXX_FLAGS "-Wall -Wextra")  # -Wpedantic")
    set(CMAKE_BUILD_TOOL "Ninja")
elseif(APPLE)
    # Apple Silicon-specific
    set(CMAKE_OSX_ARCHITECTURES "arm64")
    set(TRIPLET "arm64-osx")     
    set(CMAKE_BUILD_TOOL "Ninja")
    set(CMAKE_CXX_FLAGS "-Wall -Wextra")  # -Wpedantic")
elseif(WIN32)
    set(TRIPLET "x64-windows")
    set(CMAKE_BUILD_TOOL "Ninja")
    set(CMAKE_OSX_ARCHITECTURES "x86_64")
    # Prevent a "command line is too long" failure in Windows.
    set(CMAKE_NINJA_FORCE_RESPONSE_FILE "ON" CACHE BOOL "Force Ninja to use response files.")
elseif(WIN64)
    set(TRIPLET "x64-windows")
    set(CMAKE_BUILD_TOOL "Ninja")
    set(CMAKE_OSX_ARCHITECTURES "x64")
    # Prevent a "command line is too long" failure in Windows.
    set(CMAKE_NINJA_FORCE_RESPONSE_FILE "ON" CACHE BOOL "Force Ninja to use response files.")
else()
    # Handle other/unknown platforms if necessary
    message("Unknown platform detected")
endif()
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -g")
set(CMAKE_CXX_FLAGS_Release "${CMAKE_CXX_FLAGS_Release} -O3") # -G '${CMAKE_BUILD_TOOL}'")

if (NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose the type of build." FORCE)
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()