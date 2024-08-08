cmake_minimum_required(VERSION 3.14)

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


# Define the function to get filename without path
function(get_filename_without_path filepath result)
    get_filename_component(filename ${filepath} NAME)
    set(${result} ${filename} PARENT_SCOPE)
endfunction()

# Define the function to find and add Catch2 tests
function(add_catch2_tests base_directory)
    # Find all subdirectories in the specified base directory
    file(GLOB subdirectories RELATIVE ${CMAKE_SOURCE_DIR}/test/${base_directory} ${base_directory}/*)

    foreach(subdirectory ${subdirectories})
        if(IS_DIRECTORY ${CMAKE_SOURCE_DIR}/test/${base_directory}/${subdirectory})
            # Process each subdirectory separately
            file(GLOB test_files "${CMAKE_SOURCE_DIR}/test/${base_directory}/${subdirectory}/*.cpp")

            foreach(test_file ${test_files})
                # Get the filename without path for the test executable name
                get_filename_component(test_name ${test_file} NAME_WE)

                # Create a test executable for each test file
                add_executable(${subdirectory}_${test_name} ${test_file})

                # Set the output directory to match the source directory structure
                set_target_properties(${subdirectory}_${test_name} PROPERTIES
                    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/test/${base_directory}/${subdirectory}")

                # Link {{cookiecutter.project_slug}} and Catch2 to the test executable
                target_link_libraries(${subdirectory}_${test_name} PRIVATE {{cookiecutter.project_slug}} Catch2::Catch2WithMain)
                
                # Also include the private headers
                target_include_directories(${subdirectory}_${test_name} PRIVATE $<TARGET_PROPERTY:{{cookiecutter.project_slug}},INCLUDE_DIRECTORIES>)

                # Define compile features
                target_compile_features(${subdirectory}_${test_name} PRIVATE cxx_std_23)

                # Add the test to CTest
                add_test(NAME ${subdirectory}_${test_name} COMMAND ${subdirectory}_${test_name})
            endforeach()
        else()
            # Handle files directly in the base directory
            if("${subdirectory}" MATCHES ".*\\.cpp$")
                get_filename_component(test_name ${subdirectory} NAME_WE)
                add_executable(${test_name} ${CMAKE_SOURCE_DIR}/test/${base_directory}/${subdirectory})

                # Set the output directory to match the source directory structure
                set_target_properties(${test_name} PROPERTIES
                    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/test/${base_directory}")

                target_link_libraries(${test_name} PRIVATE {{cookiecutter.project_slug}} Catch2::Catch2WithMain)

                # Define compile features
                target_compile_features(${test_name} PRIVATE cxx_std_23)

                add_test(NAME ${test_name} COMMAND ${test_name})
            endif()
        endif()
    endforeach()
endfunction()

# Example usage: Add all tests from the test/src directory
add_catch2_tests(src)

# ---- End-of-file commands ----

add_folders(Test)
