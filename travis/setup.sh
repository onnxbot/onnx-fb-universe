set -ex

top_dir=$(dirname $(dirname $(readlink -e "${BASH_SOURCE[0]}")))

# setup ccache
export PATH="/usr/lib/ccache:$PATH"
ccache --max-size 1G

# Update all existing python packages
pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
