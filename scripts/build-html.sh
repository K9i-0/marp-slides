#!/usr/bin/env bash
set -euo pipefail

base_url="${BASE_URL:-https://k9i-0.github.io/marp-slides}"
base_url="${base_url%/}"

find . -name 'slides.md' -not -path './_template/*' -exec dirname {} \; | sort | while IFS= read -r dir; do
  name="$(basename "$dir")"
  out_dir="docs/$name"
  deck_url="$base_url/$name/"
  og_image_url="${deck_url}og.png"

  mkdir -p "$out_dir"

  npx @marp-team/marp-cli "$dir/slides.md" \
    --theme-set ./shared/theme.css \
    --html \
    --allow-local-files \
    --image png \
    -o "$out_dir/og.png" < /dev/null

  npx @marp-team/marp-cli "$dir/slides.md" \
    --theme-set ./shared/theme.css \
    --html \
    --allow-local-files \
    --url "$deck_url" \
    --og-image "$og_image_url" \
    -o "$out_dir/index.html" < /dev/null

  if [ -d "$dir/images" ]; then
    cp -R "$dir/images" "$out_dir/"
  fi
done
