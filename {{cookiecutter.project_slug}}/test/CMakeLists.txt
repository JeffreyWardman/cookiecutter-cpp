cmake_minimum_required(VERSION 3.25)

project({{cookiecutter.project_slug}}Tests LANGUAGES CXX)

include(../cmake/project-is-top-level.cmake)
include(../cmake/folders.cmake)

# ---- Dependencies ----

if(PROJECT_IS_TOP_LEVEL)
  find_package({{cookiecutter.project_slug}} REQUIRED)
  enable_testing()
endif()

include(../cmake/3rdparty/catch2.cmake)

# ---- Tests ----

# Copy data
set(SOURCE_DATA_DIR ${CMAKE_SOURCE_DIR}/test/data)
set(TARGET_DATA_DIR ${CMAKE_BINARY_DIR}/test/test)
file(COPY ${SOURCE_DATA_DIR} DESTINATION ${TARGET_DATA_DIR})

# Define the function to get filename without path
function(get_filename_without_path filepath result)
    get_filename_component(filename ${filepath} NAME)
    set(${result} ${filename} PARENT_SCOPE)
endfunction()

# Define the function to find and add Catch2 tests
function(add_catch2_tests base_directory)
    # Find all subdirectories in the specified base directory
    file(GLOB_RECURSE test_files RELATIVE ${CMAKE_SOURCE_DIR}/test/ ${base_directory}/*)
    foreach(test_file ${test_files})
        # Get the relative path to use in the test name
        string(REPLACE "/" "_" test_name ${test_file}) # Replace '/' with '_' for test name uniqueness

        # Strip out 'src/{{cookiecutter.project_slug}}' from the executable name if it's part of the path
        string(REPLACE "src_{{cookiecutter.project_slug}}_" "" test_name ${test_name})

        # Remove the .cpp extension from the test name
        get_filename_component(test_name ${test_name} NAME_WE)

        # Create a test executable for each test file
        add_executable(${test_name} ${CMAKE_SOURCE_DIR}/test/${test_file})

        # Set the output directory based on the folder structure of the test file (this is for the executable)
        get_filename_component(test_dir ${test_file} DIRECTORY)
        set_target_properties(${test_name} PROPERTIES
            RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/test/${test_dir}")  # This places only the executable

        # Link {{cookiecutter.project_slug}} and Catch2 to the test executable
        target_link_libraries(${test_name} PRIVATE {{cookiecutter.project_slug}} Catch2::Catch2WithMain)

        # Include the private headers
        target_include_directories(${test_name} PRIVATE ${CMAKE_SOURCE_DIR}/src)

        # Define compile features
        target_compile_features(${test_name} PRIVATE cxx_std_23)
        target_compile_options(${test_name} PRIVATE -fsanitize=address)
        target_link_options(${test_name} PRIVATE -fsanitize=address)

        # Add the test to CTest
        add_test(NAME ${test_name} COMMAND ${test_name})
    endforeach()
endfunction()

# Add all tests from test/src
add_catch2_tests(src)

# ---- End-of-file commands ----

add_folders(Test)
