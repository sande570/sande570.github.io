#!/bin/bash
set -euo pipefail

# Usage: ./convert-images.sh <input_dir> <cache_dir> <output_dir> <widths> [quality] [cleanup:true/false]
# Example: ./convert-images.sh assets/img .image-cache _site/assets/img "480 800 1400" 85 true

INPUT_DIR="${1:?Usage: $0 <input_dir> <cache_dir> <output_dir> <widths> [quality] [cleanup]}"
CACHE_DIR="${2:?}"
OUTPUT_DIR="${3:?}"
WIDTHS="${4:-480 800 1400}"
QUALITY="${5:-85}"
CLEANUP="${6:-false}"

mkdir -p "$CACHE_DIR" "$OUTPUT_DIR"

# Track used cache files for cleanup
USED_FILES=$(mktemp)
trap "rm -f $USED_FILES" EXIT

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

    # Track this file as used
    echo "$cached_file" >> "$USED_FILES"

    # Check cache hit (trust non-empty files since we control the cache)
    if [[ -s "$cached_file" ]]; then
        echo "  [cache hit] ${name}-${width}.webp"
        cp "$cached_file" "$output_file"
        return 0
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

cleanup_unused() {
    echo ""
    echo "Cleaning up unused cache entries..."
    local removed=0

    # Find all webp files in cache
    while IFS= read -r -d '' cached_file; do
        if ! grep -qxF "$cached_file" "$USED_FILES"; then
            echo "  [removing] $cached_file"
            rm -f "$cached_file"
            ((removed++)) || true
        fi
    done < <(find "$CACHE_DIR" -name "*.webp" -print0)

    # Remove empty directories
    find "$CACHE_DIR" -type d -empty -delete 2>/dev/null || true

    echo "Removed $removed unused cache entries"
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

# Cleanup old cache entries if requested (only on main branch)
if [[ "$CLEANUP" == "true" ]]; then
    cleanup_unused
fi

echo "Done!"
