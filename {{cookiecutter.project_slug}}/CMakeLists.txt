cmake_minimum_required(VERSION 3.25)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# ---- Declare CMake Environments ----
include (cmake/environment.cmake)

# ---- Declare VCPKG Environment ----
include(cmake/3rdparty/vcpkg.cmake)

# ---- Declare project ----
project(
    {{cookiecutter.project_slug}}
    VERSION 0.0.0
    DESCRIPTION "{{cookiecutter.project_description}}"
    LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)

# ---- Enable SIMD (if available) ----
include(cmake/simd.cmake)

# ---- Declare library ----
set(SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src/{{cookiecutter.project_slug}})
set(THIRD_PARTY_DIR ${CMAKE_CURRENT_SOURCE_DIR}/3rdparty)

set(SOURCE_FILES
  ${SOURCE_DIR}/addition.cpp
)

# Conditionally append developer mode sources
if(DEVELOPER_MODE)
    list(APPEND SOURCE_FILES
    )
endif()

add_library(
    {{cookiecutter.project_slug}}
    STATIC
    ${SOURCE_FILES}
)

target_include_directories(
  {{cookiecutter.project_slug}} ${warning_guard}
  PUBLIC
  "\$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
  PRIVATE
  "\$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/src>"
)

# ---- Include cmake libraries here ----
include(cmake/3rdparty/fmt.cmake)

# ---- Tests ----
if (BUILD_TESTS)
  include(CTest)
  add_subdirectory(test)
endif()

# ---- Examples ----
if(BUILD_EXAMPLES)
  add_subdirectory(example)
endif()

# ---- Developer mode ----

if(DEVELOPER_MODE)
  include(cmake/dev-mode.cmake)
endif()
