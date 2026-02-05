#!/bin/bash

# Fix absolute paths in JSON strings (escaped slashes)
# \/funnels\/ -> funnels\/
# \/themes\/ -> themes\/
# \/images\/ -> themes\/pe-black\/images\/

FILES=$(ls step*.html index.html)

for file in $FILES
do
    echo "Processing $file..."
    
    # 1. Fix Funnels
    sed -i '' 's|\\/funnels\\/|funnels\\/|g' "$file"
    
    # 2. Fix Themes
    sed -i '' 's|\\/themes\\/|themes\\/|g' "$file"
    
    # 3. Fix Generic Images (mapping to themes/pe-black/images)
    # Be careful not to double replace if already fixed paths exist (unlikely in pure absolute replace)
    sed -i '' 's|\\/images\\/|themes\\/pe-black\\/images\\/|g' "$file"

done
echo "JSON paths fixed."
