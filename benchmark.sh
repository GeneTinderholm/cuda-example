set -e

cd "$(dirname "$0")"
LD_LIBRARY_PATH="$(pwd)/example/build" go test -bench=. ./...
