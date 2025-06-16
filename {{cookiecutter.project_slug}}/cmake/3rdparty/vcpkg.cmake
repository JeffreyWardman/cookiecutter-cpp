# Add manifest features
if (DEVELOPER_MODE)
  set(VCPKG_MANIFEST_FEATURES "test")
endif()

# Set path of vcpkg_installed folder
set(VCPKG_INSTALLED_PATH "${CMAKE_BINARY_DIR}/vcpkg_installed")

if(UNIX)
    set(VCPKG_PATH "/opt/vcpkg")
elseif(WIN32 OR WIN64)
    set(VCPKG_PATH "C:/vcpkg")
endif()

set(CMAKE_TOOLCHAIN_FILE "${VCPKG_PATH}/scripts/buildsystems/vcpkg.cmake")
