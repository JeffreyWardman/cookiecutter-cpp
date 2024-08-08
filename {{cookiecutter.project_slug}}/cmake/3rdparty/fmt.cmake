find_package(fmt CONFIG REQUIRED)
target_link_libraries({{cookiecutter.project_slug}} PRIVATE fmt::fmt)
