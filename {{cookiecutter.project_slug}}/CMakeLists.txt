cmake_minimum_required(VERSION 3.14)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_CXX_FLAGS "-Wall -Wextra")
set(CMAKE_CXX_FLAGS_DEBUG "-g")
set(CMAKE_CXX_FLAGS_RELEASE "-O3")

project(
    {{cookiecutter.project_slug}}
    VERSION 0.0.0
    DESCRIPTION "{{cookiecutter.project_description}}"
    LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)

if (NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose the type of build." FORCE)
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()

# ---- Declare library ----

add_library(
    {{cookiecutter.project_slug}}
    src/main.cpp
)
target_include_directories(
  {{cookiecutter.project_slug}} ${warning_guard}
    PUBLIC
    "\$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/src>"
)

# ---- Include cmake libraries here ----
# (Recommended to store in cmake/third_party)

# ---- Examples ----

option(BUILD_EXAMPLES "Build examples tree." ON)
if(BUILD_EXAMPLES)
  add_subdirectory(example)
endif()

# ---- Developer mode ----

if(NOT {{cookiecutter.project_slug.upper()}}_DEVELOPER_MODE)
  return()
endif()

include(cmake/dev-mode.cmake)
