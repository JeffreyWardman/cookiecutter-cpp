# Detect the platform and set the appropriate debug preset
ifeq ($(shell uname), Darwin)
    PLATFORM=macos
else ifeq ($(shell uname), Linux)
    PLATFORM=linux
else ifeq ($(OS), Windows_NT)
	PLATFORM=windows
else
    $(error Unsupported platform)
endif

# Set debug, release, and cicd presets based on the platform
DEBUG_PRESET=$(PLATFORM)-debug
RELEASE_PRESET=$(PLATFORM)-release
CICD_PRESET=$(PLATFORM)-cicd

build_release:
	echo "Building with preset: $(RELEASE_PRESET)"
	cmake --preset $(RELEASE_PRESET)
	cmake --build --preset $(RELEASE_PRESET) -j16

build_debug:
	echo "Building with preset: $(DEBUG_PRESET)"
	cmake --preset $(DEBUG_PRESET)
	cmake --build --preset $(DEBUG_PRESET) -j16

build_cicd:
	echo "Building with preset: $(CICD_PRESET)"
	cmake --preset $(CICD_PRESET)
	cmake --build --preset $(CICD_PRESET) -j16

run_tests:
	echo "Running tests with preset: $(DEBUG_PRESET)"
	ctest --preset $(DEBUG_PRESET) --output-on-failure -j16 --verbose

run_docs:
	echo "Building docs with preset: $(DEBUG_PRESET)"
	cmake --preset $(DEBUG_PRESET) -D BUILD_DOCS=ON
	cmake --build --preset $(DEBUG_PRESET) -j16
	doxygen target/build/docs/Doxyfile
	python3 -m http.server 8000 --directory target/build/docs/html

image:
	docker compose build
