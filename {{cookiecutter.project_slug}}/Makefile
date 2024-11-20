depends:
	vcpkg integrate install
	vcpkg install

build_release:
	cmake -S . -B target/release -D CMAKE_BUILD_TYPE=Release
	cmake --build target/release --config Release
	cmake --install target/release

build_debug:
	cmake -S . -B target/build \
		-D CMAKE_BUILD_TYPE=Debug \
		-D BUILD_DOCS=OFF \
		-D BUILD_TESTS=ON \
		-D ENABLE_COVERAGE=ON \
		-D DEVELOPER_MODE=ON \
		-D ENABLE_SIMD=ON

	cmake --build target/build --config Debug -j 16
	cmake --install target/build

build_debug_cicd:
	cmake -S . -B target/build \
		-D CMAKE_BUILD_TYPE=Debug \
		-D BUILD_DOCS=OFF \
		-D BUILD_TESTS=ON \
		-D ENABLE_COVERAGE=ON \
		-D DEVELOPER_MODE=ON \
		-D ENABLE_SIMD=OFF

	cmake --build target/build --config Debug -j 16
	cmake --install target/build

run_tests:
	cd target/build && ctest --output-on-failure -j16 && cd ..

run_docs:
	cmake -S . -B build \
		-D CMAKE_BUILD_TYPE=Debug \
		-D BUILD_DOCS=ON \
		-D BUILD_TESTS=OFF \
		-D ENABLE_COVERAGE=OFF \
		-D DEVELOPER_MODE=ON \
        -D ENABLE_SIMD=OFF
	cmake --build target/build --config Debug
	cmake --install target/build
	doxygen target/build/docs/Doxyfile
	python3 -m http.server 8000 --directory target/build/docs/html
