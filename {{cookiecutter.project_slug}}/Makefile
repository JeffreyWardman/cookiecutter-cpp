MAKE_JOBS ?= $(shell nproc)

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

.PHONY: build_release
build_release:  ## Build release version
	@echo "Building with preset: $(RELEASE_PRESET)"
	@cmake --preset $(RELEASE_PRESET)
	@cmake --build --preset $(RELEASE_PRESET) -j$(MAKE_JOBS)
	@$(MAKE) BUILD_TYPE=release post_build_symlink

.PHONY: build_debug
build_debug:  ## Build debug version
	@echo "Building with preset: $(DEBUG_PRESET)"
	@cmake --preset $(DEBUG_PRESET)
	@cmake --build --preset $(DEBUG_PRESET) -j$(MAKE_JOBS)
	@$(MAKE) BUILD_TYPE=debug post_build_symlink

.PHONY: build_cicd
build_cicd:  ## Build CI/CD version
	@echo "Building with preset: $(CICD_PRESET)"
	@cmake --preset $(CICD_PRESET)
	@cmake --build --preset $(CICD_PRESET) -j$(MAKE_JOBS)
	@$(MAKE) BUILD_TYPE=cicd post_build_symlink

.PHONY: run_tests
run_tests:  ## Run unit tests
	@echo "Running tests with preset: $(DEBUG_PRESET)"
	@ctest --preset $(DEBUG_PRESET) --output-on-failure -j$(MAKE_JOBS) --verbose

.PHONY: run_docs
run_docs:  ## Build and serve documentation
	@echo "Building docs with preset: $(DEBUG_PRESET)"
	@cmake --preset $(DEBUG_PRESET) -D BUILD_DOCS=ON
	@cmake --build --preset $(DEBUG_PRESET) -j$(MAKE_JOBS)
	@$(MAKE) BUILD_TYPE=debug post_build_symlink
	@doxygen target/build/docs/Doxyfile
	@python3 -m http.server 8000 --directory target/build/docs/html

.PHONY: post_build_symlink
post_build_symlink:  ## Add compile_commands.json symlink to root directory
	@ln -sf target/$(PLATFORM)/$(BUILD_TYPE)/compile_commands.json ./compile_commands.json

.PHONY: lint_clang_tidy
lint_clang_tidy:  ## Run clang-tidy static analysis
	@find src -type f \( -name '*.cpp' -o -name '*.cc' -o -name '*.cxx' -o -name '*.h' -o -name '*.hpp' \) -print0 | xargs -0 -n 1 clang-tidy --warnings-as-errors --config-file=.clang-tidy

.PHONY: lint_clang_format
lint_clang_format:  ## Check code style with clang-format
	@find src -name '*.cpp' -o -name '*.h' | xargs clang-format --dry-run --Werror

.PHONY: lint
lint:  ## Run all linters
	@echo "🚀 ---------- Running clang-tidy ----------\n"
	@$(MAKE) lint_clang_tidy
	@echo "\n\n🚀 ---------- Running clang-format ----------\n"
	@$(MAKE) lint_clang_format

.PHONY: image
image:  ## Build docker image
	@docker compose build

.PHONY: help
help:
	@python3 -c "import re; \
	[[print(f'\033[36m{m[0]:<20}\033[0m {m[1]}') for m in re.findall(r'^([a-zA-Z_-]+):.*?## (.*)$$', open(makefile).read(), re.M)] for makefile in ('$(MAKEFILE_LIST)').strip().split()]"

.DEFAULT_GOAL := help
