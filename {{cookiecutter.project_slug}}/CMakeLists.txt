cmake_minimum_required(VERSION 3.18)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} -std=c++23 -lstdc++")
option(BUILD_DOCS "Build and Install Documents (Requires Doxygen)") 

# Initialize
set(REPOSITORY_NAME {{cookiecutter.project_slug}})

# Set project
project(
  $(REPOSITORY_NAME)
  VERSION 0.0.0
  LANGUAGES CXX
)

add_executable(App src/main.cpp)

# Compile the library and application
add_subdirectory(src)
add_subdirectory(app)

# compile the tests
include(CTest)
if(BUILD_TESTING)
  add_subdirectory(tests)
endif()

# Compilation options
set(BUILD_DOCS ON CACHE BOOL "Enable building of documentation")
if(BUILD_DOCS)
  # Add the documentation
  add_subdirectory(docs)
endif()

# This prints a summary of found dependencies
include(FeatureSummary)
feature_summary(WHAT ALL)