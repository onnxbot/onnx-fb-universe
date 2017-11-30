set -ex

top_dir=$(dirname $(dirname $(readlink -e "${BASH_SOURCE[0]}")))

OS="$(uname)"

# setup ccache for OSX
if [[ "$OS" == "Darwin" ]]; then
    export PATH="/usr/local/opt/ccache/libexec:$PATH"
fi

# setup virtualenv
virtualenv "$top_dir/venv"
source "$top_dir/venv/bin/activate"
pip install -U pip setuptools
