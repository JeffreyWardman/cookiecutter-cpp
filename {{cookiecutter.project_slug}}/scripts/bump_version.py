import json
import subprocess
import sys


# Function to install a Python package using pip
def install_package(package):
    subprocess.check_call([sys.executable, "-m", "pip", "install", package])


try:
    import toml
except ImportError:
    print("toml package not found. Installing...")
    install_package("toml")
    import toml


def update_vcpkg_version():
    with open(".cz.toml", "r") as f:
        toml_data = toml.load(f)

    new_version = toml_data["tool"]["commitizen"]["version"]

    # Update vcpkg.json
    with open("vcpkg.json", "r+") as f:
        vcpkg_data = json.load(f)
        vcpkg_data["version-semver"] = new_version
        f.seek(0)  # Move to the beginning of the file
        json.dump(vcpkg_data, f, indent=2)
        f.truncate()  # Clear any remaining content if the new content is shorter

    print(f"Updated vcpkg.json version-semver to {new_version}")


if __name__ == "__main__":
    update_vcpkg_version()
