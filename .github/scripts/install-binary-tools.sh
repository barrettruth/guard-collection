#!/usr/bin/env bash
set -euo pipefail

dest="${1:-.}"
manifest="${2:-.github/tools/binary.txt}"

mkdir -p "$dest"

while read -r name type url extra; do
  [[ -z "$name" || "$name" == \#* ]] && continue

  case "$type" in
    bin)
      wget -q "$url" -O "$dest/$name"
      chmod +x "$dest/$name"
      ;;
    zip)
      tmpdir="$(mktemp -d)"
      wget -q "$url" -O "$tmpdir/archive.zip"
      unzip -q "$tmpdir/archive.zip" -d "$tmpdir"
      mv "$tmpdir/${extra:-$name}" "$dest/$name"
      chmod +x "$dest/$name"
      rm -rf "$tmpdir"
      ;;
    tar)
      tmpdir="$(mktemp -d)"
      wget -q "$url" -O "$tmpdir/archive.tar.gz"
      tar xzf "$tmpdir/archive.tar.gz" -C "$tmpdir"
      mv "$tmpdir/$extra" "$dest/$name"
      chmod +x "$dest/$name"
      rm -rf "$tmpdir"
      ;;
    gz)
      wget -q "$url" -O "$dest/$name.gz"
      gunzip "$dest/$name.gz"
      chmod +x "$dest/$name"
      ;;
    jar)
      wget -q "$url" -O "$dest/$name.jar"
      printf '#!/bin/sh\njava -jar %s/%s.jar "$@"\n' "$dest" "$name" > "$dest/$name"
      chmod +x "$dest/$name"
      ;;
  esac
done < "$manifest"
