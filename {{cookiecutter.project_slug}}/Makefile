depends:
	vcpkg integrate install
	vcpkg install

build_debug:
	cmake -S . -B build \
		-D CMAKE_BUILD_TYPE=Debug \
		-D BUILD_MCSS_DOCS=OFF \
		-D BUILD_TESTING=ON \
		-D ENABLE_COVERAGE=ON \
		-D {{cookiecutter.project_slug.upper()}}_DEVELOPER_MODE=ON
	cmake --build build --config Debug
	cmake --install build

build_release:
	cmake -S . -B release -D CMAKE_BUILD_TYPE=Release
	cmake --build release --config Release
	cmake --install release

run_example:
	./build/example/example/empty_example

run_tests:
	cd build && ctest --output-on-failure -j16 && cd ..

run_docs:
	cmake -S . -B build \
		-D CMAKE_BUILD_TYPE=Debug \
		-D BUILD_MCSS_DOCS=ON \
		-D BUILD_TESTING=ON \
		-D ENABLE_COVERAGE=ON \
		-D {{cookiecutter.project_slug.upper()}}_DEVELOPER_MODE=ON
	cmake --build build --config Debug
	cmake --install build
	doxygen build/docs/Doxyfile
	python3 -m http.server 8000 --directory build/docs/html