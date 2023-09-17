NUM_WORKERS=24
AppName=App
DockerImage={{cookiecutter.project_slug}}

_build: 
	cmake -B target/build -S . \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=1 \
		-DCMAKE_TOOLCHAIN_FILE="/opt/vcpkg/vcpkg" \
		-Wno-dev && \
	cmake --build target/build -j${NUM_WORKERS}

_debug:
	cmake -B target/debug -S . \
		-DCMAKE_BUILD_TYPE=Debug \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=1 \
		-DCMAKE_TOOLCHAIN_FILE="/opt/vcpkg/scripts/buildsystems/vcpkg.cmake" \
		-DBUILD_DOCS=ON \
		-Wno-dev && \
	cmake --build target/debug -j${NUM_WORKERS}

run_release:
	./target/build/${AppName}

run_debug:
	./target/debug/${AppName}

build_image:
	docker build -f .devcontainer/Dockerfile -t ${DockerImage}:latest --squash --compress .

run_image_interactive:
	docker run -it ${DockerImage}
