cmake_minimum_required(VERSION 3.25)

project({{cookiecutter.project_slug}}Examples CXX)

set(CMAKE_CXX_STANDARD 23)
if (NOT WIN32 AND NOT WIN64)
  set(CMAKE_CXX_FLAGS "-Wall -Wextra")
else()
  set(CMAKE_CXX_FLAGS_DEBUG "-g")
endif()

include(../cmake/project-is-top-level.cmake)
include(../cmake/folders.cmake)

# ---- Dependencies ----

if(PROJECT_IS_TOP_LEVEL)
  find_package({{cookiecutter.project_slug}} REQUIRED)
endif()

# ---- Examples ----

add_custom_target(run-examples)

function(add_example NAME)
  get_filename_component(TARGET_NAME "${NAME}" NAME_WE)
  get_filename_component(DIR "${NAME}" PATH)
  if (DIR)
    set(OUTPUT_DIR "${CMAKE_BINARY_DIR}/example/example/${DIR}")
  else()
    set(OUTPUT_DIR "${CMAKE_BINARY_DIR}/example/example")
  endif()

  add_executable("${TARGET_NAME}" "${NAME}.cpp")
  set_target_properties("${TARGET_NAME}" PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${OUTPUT_DIR}")
  target_link_libraries("${TARGET_NAME}" PRIVATE {{cookiecutter.project_slug}})
  target_compile_features("${TARGET_NAME}" PRIVATE cxx_std_23)
  # Define compile definitions if developer mode is enabled
  if(DEVELOPER_MODE)
    target_compile_definitions("${TARGET_NAME}" PRIVATE DEVELOPER_MODE)
  endif()
    
  # Also include the private headers
  target_include_directories(${TARGET_NAME} PRIVATE $<TARGET_PROPERTY:{{cookiecutter.project_slug}},INCLUDE_DIRECTORIES>)

  add_custom_target("run_${TARGET_NAME}" COMMAND "${OUTPUT_DIR}/${TARGET_NAME}" VERBATIM)
  add_dependencies("run_${TARGET_NAME}" "${TARGET_NAME}")
  add_dependencies(run-examples "run_${TARGET_NAME}")
endfunction()

add_example(empty_example)
