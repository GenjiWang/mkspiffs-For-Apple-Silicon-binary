#!/bin/bash
# build.sh - Build mkspiffs for Apple Silicon (macOS arm64)
# Usage: ./build.sh
#
# This script clones the mkspiffs repository and builds it for Apple Silicon.
# Requirements: git, make, clang (Xcode Command Line Tools)

set -e

echo "=== mkspiffs Build Script for Apple Silicon ==="
echo ""

# Check if we're on macOS
if [[ "$(uname -s)" != "Darwin" ]]; then
    echo "Error: This script is designed to run on macOS."
    exit 1
fi

# Check architecture
ARCH=$(uname -m)
echo "Detected architecture: $ARCH"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Create a temporary build directory
BUILD_DIR="$(mktemp -d)"
echo "Build directory: $BUILD_DIR"

cleanup() {
    echo "Cleaning up..."
    rm -rf "$BUILD_DIR"
}

trap cleanup EXIT

cd "$BUILD_DIR"

# Clone mkspiffs repository
echo ""
echo "Cloning mkspiffs repository..."
git clone --recursive https://github.com/igrr/mkspiffs.git
cd mkspiffs

# Get version
VERSION=$(git describe --always)
echo "Building mkspiffs version: $VERSION"
echo ""

# Build for arm64 (Apple Silicon) with Arduino ESP32 configuration
# IMPORTANT: SPIFFS_OBJ_META_LEN=4 is required for compatibility with ESP32 Arduino
echo "Building for arm64 (Apple Silicon) with Arduino ESP32 configuration..."
make clean 2>/dev/null || true
make dist BUILD_CONFIG_NAME="-arduino-esp32" \
    CPPFLAGS="-DSPIFFS_OBJ_META_LEN=4" \
    TARGET_CFLAGS="-mmacosx-version-min=11.0 -arch arm64" \
    TARGET_CXXFLAGS="-mmacosx-version-min=11.0 -arch arm64 -stdlib=libc++" \
    TARGET_LDFLAGS="-mmacosx-version-min=11.0 -arch arm64 -stdlib=libc++"

# Verify the binary
echo ""
echo "Verifying binary..."
file mkspiffs

if file mkspiffs | grep -q "arm64"; then
    echo -e "${GREEN}✓ Binary is arm64 architecture${NC}"
else
    echo -e "${RED}✗ Binary is NOT arm64 architecture${NC}"
    exit 1
fi

# Test the binary
echo ""
echo "Testing binary..."
./mkspiffs --version

# Copy to output directory
OUTPUT_DIR="$SCRIPT_DIR"
OUTPUT_FILE="$OUTPUT_DIR/mkspiffs_for_Apple_Silicon"

echo ""
echo "Copying binary to: $OUTPUT_FILE"
cp mkspiffs "$OUTPUT_FILE"
chmod +x "$OUTPUT_FILE"

echo ""
echo -e "${GREEN}=== Build complete! ===${NC}"
echo ""
echo "The binary is located at: $OUTPUT_FILE"
echo ""
echo "To install for PlatformIO, run:"
echo "  cp $OUTPUT_FILE ~/.platformio/packages/tool-mkspiffs/mkspiffs_espressif32_arduino"
