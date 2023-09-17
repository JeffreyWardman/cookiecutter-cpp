file(GLOB src_files "*.cpp")
add_library({{cookiecutter.project_slug}} ${src_files})
target_include_directories({{cookiecutter.project_slug}} PUBLIC
  $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include/>
  $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)
