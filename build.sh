#!/bin/sh
# Build script for ROX-Filer
# Mirrors what `ROX-Filer/AppRun --compile` does, but with clearer errors
# and without the interactive "Press Return" pause.

set -e

APP_DIR="$(cd "$(dirname "$0")" && pwd)"
SRC_DIR="$APP_DIR/ROX-Filer/src"
BUILD_DIR="$APP_DIR/ROX-Filer/build"

# --- Prerequisite checks -------------------------------------------------

missing=""

for tool in gcc make pkg-config autoconf; do
	command -v "$tool" >/dev/null 2>&1 || missing="$missing $tool"
done

if [ -n "$missing" ]; then
	echo "ERROR: missing build tools:$missing" >&2
	echo "Install them with your package manager, e.g. on Debian/Ubuntu:" >&2
	echo "  sudo apt install build-essential pkg-config autoconf" >&2
	exit 1
fi

for pkg in gtk+-2.0 libxml-2.0 sm ice; do
	if ! pkg-config --exists "$pkg"; then
		missing="$missing $pkg"
	fi
done

if [ -n "$missing" ]; then
	echo "ERROR: missing libraries:$missing" >&2
	echo "Install the dev packages, e.g. on Debian/Ubuntu:" >&2
	echo "  sudo apt install libgtk2.0-dev libxml2-dev libsm-dev" >&2
	exit 1
fi

# --- Configure & build ---------------------------------------------------

# Generate the configure script if it doesn't exist yet
if [ ! -x "$SRC_DIR/configure" ]; then
	echo "No 'configure' script - running autoconf..."
	(cd "$SRC_DIR" && autoconf)
fi

mkdir -p "$BUILD_DIR"
rm -f "$BUILD_DIR/config.cache"
rm -f "$SRC_DIR/config.h"	# stale config from a previous build

cd "$BUILD_DIR"

echo "Configuring..."
# GCC 14+ turns -Wincompatible-pointer-types into a hard error; this 2009-era
# codebase assigns (gpointer, guint, GtkWidget *) callbacks to GtkItemFactory's
# void (*)(void) field throughout, so restore the old warning-only behaviour.
# Passing it via CFLAGS here bakes it into the Makefile's @CFLAGS@ (keeping
# the -I include paths) instead of clobbering them on the make command line.
CFLAGS="$CFLAGS -Wno-error=incompatible-pointer-types" "$SRC_DIR/configure" "$@"

echo "Building..."
make clean
make

echo
echo "Done: $APP_DIR/ROX-Filer/ROX-Filer"
echo "Run it with: $APP_DIR/ROX-Filer/AppRun"
