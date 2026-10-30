#!/bin/sh
# System-wide launcher for ROX-Filer (installed as /usr/bin/rox).
# Sets APP_DIR to the installed AppDir and execs AppRun, which handles
# --debug/--valgrind wrappers and runs the binary.

APP_DIR=/usr/share/ROX-Filer
export APP_DIR

exec "$APP_DIR/AppRun" "$@"
