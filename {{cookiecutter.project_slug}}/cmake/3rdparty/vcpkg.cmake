# Add manifest features
if (DEVELOPER_MODE)
  set(VCPKG_MANIFEST_FEATURES "test")
endif()

# Set path of vcpkg_installed folder
if(DEFINED ENV{VCPKG_INSTALLED_DIR} AND NOT "$ENV{VCPKG_INSTALLED_DIR}" STREQUAL "")
    set(VCPKG_INSTALLED_PATH "$ENV{VCPKG_INSTALLED_DIR}")
    message("Overriding VCPKG_INSTALLED_PATH with: ${VCPKG_INSTALLED_PATH}")
else()
    set(VCPKG_INSTALLED_PATH "${CMAKE_BINARY_DIR}/vcpkg_installed")
endif()

if(UNIX)
    set(VCPKG_PATH "/opt/vcpkg")
elseif(WIN32 OR WIN64)
    set(VCPKG_PATH "C:/vcpkg")
endif()

set(CMAKE_TOOLCHAIN_FILE "${VCPKG_PATH}/scripts/buildsystems/vcpkg.cmake")
