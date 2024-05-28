cmake_minimum_required(VERSION 3.14)

project({{cookiecutter.project_slug}}Tests LANGUAGES CXX)

include(../cmake/project-is-top-level.cmake)
include(../cmake/folders.cmake)

# ---- Dependencies ----

if(PROJECT_IS_TOP_LEVEL)
  find_package({{cookiecutter.project_slug}} REQUIRED)
  enable_testing()
endif()

# ---- Tests ----

add_executable({{cookiecutter.project_slug}}_test src/{{cookiecutter.project_slug}}_test.cpp)
target_link_libraries({{cookiecutter.project_slug}}_test PRIVATE {{cookiecutter.project_slug}})
target_compile_features({{cookiecutter.project_slug}}_test PRIVATE cxx_std_23)

add_test(NAME {{cookiecutter.project_slug}}_test COMMAND {{cookiecutter.project_slug}}_test)

# ---- End-of-file commands ----

add_folders(Test)
