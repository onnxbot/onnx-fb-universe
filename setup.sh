set -ex

die() {
    echo >&2 "$@"
    exit 1
}

OS="$(uname)"

export BUILD_DIR="$HOME/build"
mkdir -p "$BUILD_DIR"

export CACHE_DIR="$HOME/.cache"
mkdir -p "$CACHE_DIR"

export REPOS_DIR="$HOME/repos"
mkdir -p "$REPOS_DIR"

CONFIG_FILE="$top_dir/config.json"
CMD_TOOLS="$top_dir/cmdtools.py"

# setup ccache
export PATH="/usr/lib/ccache:$PATH"
ccache --max-size 5G
