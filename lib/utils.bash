#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/ByteNess/aws-vault"
TOOL_NAME="aws-vault"
# shellcheck disable=SC2034
TOOL_TEST="aws-vault --version"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//'
}

list_all_versions() {
	list_github_tags
}

get_arch() {
	local os
	os="$(uname | tr '[:upper:]' '[:lower:]')"
	case "$os" in
	'msys'* | 'cygwin'* | 'mingw'*) echo "windows" ;;
	*) echo "$os" ;;
	esac
}

get_cpu() {
	local machine_hardware_name
	local cpu_type
	machine_hardware_name="$(uname -m)"

	case "$machine_hardware_name" in
	'x86_64') cpu_type="amd64" ;;
	'powerpc64le' | 'ppc64le') cpu_type="ppc64le" ;;
	'aarch64') cpu_type="arm64" ;;
	'armv7l') cpu_type="arm" ;;
	*) cpu_type="$machine_hardware_name" ;;
	esac

	echo "$cpu_type"
}

get_download_url() {
	local version="$1"
	local platform
	local cpu
	local filename
	platform="$(get_arch)"
	cpu="$(get_cpu)"
	filename="aws-vault-${platform}-${cpu}"

	# Add .exe extension for Windows
	if [ "$platform" = "windows" ]; then
		filename="${filename}.exe"
	fi

	echo "https://github.com/ByteNess/aws-vault/releases/download/v${version}/${filename}"
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"

	url="$(get_download_url "$version")"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"

		# Copy the downloaded binary to the install path
		local binary_name="aws-vault"
		if [ "$(get_arch)" = "windows" ]; then
			binary_name="aws-vault.exe"
		fi

		cp "$ASDF_DOWNLOAD_PATH/$binary_name" "$install_path/aws-vault"
		chmod +x "$install_path/aws-vault"

		# Test that the executable works
		test -x "$install_path/aws-vault" || fail "Expected $install_path/aws-vault to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
