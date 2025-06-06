# ---- Developer mode ----

# Developer mode enables targets and code paths in the CMake scripts that are
# only relevant for the developer(s) of {{cookiecutter.project_slug}}
# Targets necessary to build the project must be provided unconditionally, so
# consumers can trivially build and package the project
if(PROJECT_IS_TOP_LEVEL)
  option(DEVELOPER_MODE "Enable developer mode" OFF)
  option(BUILD_SHARED_LIBS "Build shared libs." OFF)
  option(BUILD_EXAMPLES "Build examples" OFF)
  option(BUILD_TESTS "Build unit tests" OFF)
  option(ENABLE_SIMD "Enable SIMD." ON)
endif()

# ---- Warning guard ----

# target_include_directories with the SYSTEM modifier will request the compiler
# to omit warnings from the provided paths, if the compiler supports that
# This is to provide a user experience similar to find_package when
# add_subdirectory or FetchContent is used to consume this project
set(warning_guard "")
if(NOT PROJECT_IS_TOP_LEVEL)
  option(
    {{cookiecutter.project_slug.upper()}}_INCLUDES_WITH_SYSTEM
      "Use SYSTEM modifier for {{cookiecutter.project_slug}}'s includes, disabling warnings"
      ON
  )
  mark_as_advanced({{cookiecutter.project_slug.upper()}}_INCLUDES_WITH_SYSTEM)
  if({{cookiecutter.project_slug.upper()}}_INCLUDES_WITH_SYSTEM)
    set(warning_guard SYSTEM)
  endif()
endif()
