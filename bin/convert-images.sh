#!/bin/bash
set -euo pipefail

# Usage: ./convert-images.sh <input_dir> <cache_dir> <output_dir> <widths>
# Example: ./convert-images.sh assets/img .image-cache _site/assets/img "480 800 1400"

INPUT_DIR="${1:?Usage: $0 <input_dir> <cache_dir> <output_dir> <widths>}"
CACHE_DIR="${2:?}"
OUTPUT_DIR="${3:?}"
WIDTHS="${4:-480 800 1400}"
QUALITY="${5:-85}"

mkdir -p "$CACHE_DIR" "$OUTPUT_DIR"

convert_image() {
    local src="$1"
    local width="$2"
    local basename=$(basename "$src")
    local name="${basename%.*}"
    local hash=$(md5sum "$src" | cut -d' ' -f1)
    local cache_subdir="$CACHE_DIR/$name"
    local cached_file="$cache_subdir/${hash}_${width}.webp"
    local output_file="$OUTPUT_DIR/${name}-${width}.webp"

    mkdir -p "$cache_subdir"

    # Check cache hit
    if [[ -f "$cached_file" ]]; then
        # Validate it's a real webp
        if file "$cached_file" | grep -q "RIFF.*WEBP"; then
            echo "  [cache hit] ${name}-${width}.webp"
            cp "$cached_file" "$output_file"
            return 0
        else
            echo "  [invalid cache] ${name}-${width}.webp"
            rm -f "$cached_file"
        fi
    fi

    # Cache miss - convert
    echo "  [converting] ${name}-${width}.webp"
    local tmp_file=$(mktemp)
    if convert "$src" -resize "${width}x>" -quality "$QUALITY" "$tmp_file.webp"; then
        mv "$tmp_file.webp" "$cached_file"
        cp "$cached_file" "$output_file"
    else
        echo "  [error] Failed to convert $src"
        rm -f "$tmp_file" "$tmp_file.webp"
        return 1
    fi
    rm -f "$tmp_file"
}

# Find all images
shopt -s nullglob nocaseglob
for src in "$INPUT_DIR"/*.{jpg,jpeg,png,tiff,gif}; do
    [[ -f "$src" ]] || continue
    echo "Processing: $(basename "$src")"
    for width in $WIDTHS; do
        convert_image "$src" "$width"
    done
done

echo "Done!"
