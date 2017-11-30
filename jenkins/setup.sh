set -ex

export TOP_DIR=$(dirname $(dirname $(readlink -e "${BASH_SOURCE[0]}")))

export OS="$(uname)"

# setup ccache for OSX
if [[ "$OS" == "Darwin" ]]; then
    export PATH="/usr/local/opt/ccache/libexec:$PATH"
fi

# setup virtualenv
virtualenv "$TOP_DIR/venv"
source "$TOP_DIR/venv/bin/activate"
pip install -U pip setuptools
