#!/bin/bash
# R9 Motion installer — animated wallpapers for macOS.
#   curl -fsSL https://raw.githubusercontent.com/XPro-Gamer-Rhine/R9-Motion-app/main/install.sh | bash
set -euo pipefail
REPO="XPro-Gamer-Rhine/R9-Motion-app"
TARBALL_URL="https://github.com/$REPO/releases/latest/download/R9-Motion.tar.gz"
DEST_DIR="/Applications"
if [ ! -w "$DEST_DIR" ]; then DEST_DIR="$HOME/Applications"; mkdir -p "$DEST_DIR"; fi
APP="$DEST_DIR/R9 Motion.app"
TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
echo "==> Downloading R9 Motion (latest release)..."
curl -fL --progress-bar "$TARBALL_URL" -o "$TMP/R9-Motion.tar.gz"
tar -xzf "$TMP/R9-Motion.tar.gz" -C "$TMP"
[ -d "$TMP/R9 Motion.app" ] || { echo "ERROR: archive did not contain R9 Motion.app"; exit 1; }
echo "==> Installing to $DEST_DIR ..."
/usr/bin/pkill -x "R9 Motion" 2>/dev/null || true
rm -rf "$APP"; mv "$TMP/R9 Motion.app" "$APP"
/usr/bin/xattr -dr com.apple.quarantine "$APP" 2>/dev/null || true
echo "==> Launching..."
open "$APP"
echo ""
echo "✅ R9 Motion installed. Look for the wave icon in the menu bar to customize."
