#include <catch2/catch_test_macros.hpp>

#include <{{cookiecutter.project_slug}}/addition.h>

TEST_CASE("Test addition", "[{{cookiecutter.project_slug}}][addition]") {
    SECTION("Success"){ REQUIRE(addition(0, 2) == 2); }
}
