#!/usr/bin/env bash
set -euo pipefail

zig_version="${ZIG_VERSION:-0.15.1}"
zig_sha256="${ZIG_SHA256:-c61c5da6edeea14ca51ecd5e4520c6f4189ef5250383db33d01848293bfafe05}"
zig_dir="${ZIG_INSTALL_DIR:-${RUNNER_TEMP:-$HOME/.cache}/zig-$zig_version}"

if [ ! -x "$zig_dir/zig" ]; then
  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "$tmp_dir"' EXIT

  mkdir -p "$zig_dir"
  curl -fsSL --retry 5 --retry-all-errors --retry-delay 2 \
    "https://ziglang.org/download/$zig_version/zig-x86_64-linux-$zig_version.tar.xz" \
    -o "$tmp_dir/zig.tar.xz"

  echo "$zig_sha256  $tmp_dir/zig.tar.xz" | sha256sum -c -
  tar -xf "$tmp_dir/zig.tar.xz" --strip-components=1 -C "$zig_dir"
fi

echo "$zig_dir" >> "$GITHUB_PATH"
"$zig_dir/zig" version
