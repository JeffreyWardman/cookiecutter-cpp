# Add manifest features
if (DEVELOPER_MODE)
  set(VCPKG_MANIFEST_FEATURES "test")
endif()

# Set path of vcpkg_installed folder
if(CMAKE_BUILD_TYPE STREQUAL "Release")
    set(VCPKG_INSTALLED_PATH "target/release/vcpkg_installed")
else()
    set(VCPKG_INSTALLED_PATH "target/build/vcpkg_installed")
endif()

if(UNIX)
    set(VCPKG_PATH "/opt/vcpkg")
elseif(WIN32 OR WIN64)
    set(VCPKG_PATH "C:/vcpkg")
endif()

set(CMAKE_TOOLCHAIN_FILE "${VCPKG_PATH}/scripts/buildsystems/vcpkg.cmake")
