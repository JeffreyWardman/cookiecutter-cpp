include(cmake/folders.cmake)

option(BUILD_DOCS "Build documentation using Doxygen and m.css" OFF)
if(BUILD_DOCS)
  include(cmake/docs.cmake)
endif()

option(ENABLE_COVERAGE "Enable coverage support separate from CTest's" ON)
if(ENABLE_COVERAGE)
  include(cmake/coverage.cmake)
endif()

include(cmake/lint-targets.cmake)

add_folders(Project)
