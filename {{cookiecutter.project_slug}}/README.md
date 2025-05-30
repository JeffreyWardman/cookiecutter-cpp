# {{cookiecutter.project_name}}

Requires Clang 15+. To install on linux:

```sh
VERSION=19
sudo apt install clang-${VERSION} clangd-${VERSION} clang-tidy-${VERSION} clang-format-${VERSION}
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-${VERSION} ${VERSION}0
sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-${VERSION} ${VERSION}0
sudo update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-${VERSION} ${VERSION}0
sudo update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-${VERSION} ${VERSION}0
```
