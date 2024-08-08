# Set path of vcpkg_installed folder
if(CMAKE_BUILD_TYPE STREQUAL "Release")
    set(VCPKG_INSTALLED_PATH "target/release/vcpkg_installed")
else()
    set(VCPKG_INSTALLED_PATH "build/vcpkg_installed")
endif()

if(UNIX AND NOT APPLE)
    set(VCPKG_PATH "/opt/vcpkg")
elseif(APPLE)
    # Apple Silicon-specific
    set(VCPKG_ROOT "${VCPKG_INSTALLED_PATH}/arm64-osx/lib")
    set(VCPKG_PATH "/opt/vcpkg")
elseif(WIN32)
    set(VCPKG_PATH "C:/vcpkg")
elseif(WIN64)
    set(VCPKG_PATH "C:/vcpkg")
endif()

set(CMAKE_TOOLCHAIN_FILE "${VCPKG_PATH}/scripts/buildsystems/vcpkg.cmake")
set(VCPKG_ROOT "${VCPKG_PATH}")
