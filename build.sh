#!/usr/bin/env bash
set -euo pipefail

if [[ "$(uname -m)" != "aarch64" ]]; then
  echo "This build requires aarch64; detected: $(uname -m)" >&2
  exit 1
fi

archive="ArchLinuxARM-aarch64-latest.tar.gz"
checksum="${archive}.md5"
base_url="http://os.archlinuxarm.org/os"

cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

curl -fLO "${base_url}/${archive}"
curl -fLO "${base_url}/${checksum}"

if ! md5sum --check "$checksum"; then
  echo "Checksum validation failed; refusing to build." >&2
  exit 1
fi

podman build -t localhost/alarm-distrobox:latest .
