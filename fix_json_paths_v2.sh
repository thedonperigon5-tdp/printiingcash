#!/bin/bash

# Fix absolute paths in JSON strings (escaped slashes)
# \/funnels\/ -> funnels\/
# \/themes\/ -> themes\/
# "\/images\/ -> "images\/
# url(\/images\/ -> url(images\/

FILES=$(ls step*.html index.html)

for file in $FILES
do
    echo "Processing $file..."
    
    # 1. Fix Funnels (Global is safe as 'funnels' is a unique root folder name)
    sed -i '' 's|\\/funnels\\/|funnels\\/|g' "$file"
    
    # 2. Fix Themes (Global is safe)
    sed -i '' 's|\\/themes\\/|themes\\/|g' "$file"
    
    # 3. Fix Images (Context Aware)
    # Match start of string
    sed -i '' 's|"\\/images\\/|"images\\/|g' "$file"
    # Match CSS url
    sed -i '' 's|url(\\/images\\/|url(images\\/|g' "$file"

    # Also handle the NON-escaped absolute paths in JSON that might exist?
    # e.g. "image": "/images/..."
    sed -i '' 's|"/images/|"images/|g' "$file"
    sed -i '' 's|url(/images/|url(images/|g' "$file"
    
    # And specifically for standard src attributes (handled by process_pages but good to ensure)
    sed -i '' 's|src="/images/|src="images/|g' "$file"

done
echo "JSON paths fixed."
