#!/bin/bash
# build-dist.sh - Build RT extension distribution without RT installed
# Usage: ./tools/build-dist.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FAKE_RT_DIR="$SCRIPT_DIR/fake-rt"

# Verify fake RT environment exists
if [[ ! -d "$FAKE_RT_DIR/lib/RT" ]]; then
    echo "Error: Fake RT environment not found at $FAKE_RT_DIR"
    exit 1
fi

# Change to repo root
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

# Clean up any previous build artifacts
rm -f Makefile MYMETA.* RT-Extension-*.tar.gz

# Generate Makefile using fake RT environment
echo "Generating Makefile with fake RT environment..."
RTHOME="$FAKE_RT_DIR" perl Makefile.PL

# Build the distribution
echo "Building distribution..."
make dist

# Cleanup build artifacts, keep only the tarball
rm -f Makefile MYMETA.*

echo ""
echo "Distribution built successfully!"
ls -lh RT-Extension-*.tar.gz
