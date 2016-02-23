#!/bin/sh

set -e

if [ ! -f "build/env.sh" ]; then
    echo "$0 must be run from the root of the repository."
    exit 2
fi

# Create fake Go workspace if it doesn't exist yet.
workspace="$PWD/build/_workspace"
root="$PWD"
gntdir="$workspace/src/github.com/ghostnetwrk"
if [ ! -L "$gntdir/ghostnet" ]; then
    mkdir -p "$gntdir"
    cd "$gntdir"
    ln -s ../../../../../. ghostnet
    cd "$root"
fi

# Set up the environment to use the workspace.
# Also add Godeps workspace so we build using canned dependencies.
GOPATH="$gntdir/ghostnet/Godeps/_workspace:$workspace"
GOBIN="$PWD/build/bin"
export GOPATH GOBIN

# Run the command inside the workspace.
cd "$gntdir/ghostnet"
PWD="$gntdir/ghostnet"

# Launch the arguments with the configured environment.
exec "$@"
