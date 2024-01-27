set -e
cd "$(dirname "$0")/example"
rm -rf build
mkdir build
cd build
cmake ..
make