#!/bin/bash
# Inject ButtonAnimationSpeed definition BEFORE default.js loads
# This ensures it is available even if default.js executes immediately.

FILES=$(ls step*.html index.html)

for file in $FILES
do
    # Check if we already injected it in head (avoid duplication if we run multiple times)
    if ! grep -q "<script>window.ButtonAnimationSpeed = 0;</script><script src=\"js/default.js" "$file"; then
         # Replace the default.js script tag with [VariableDef] + [ScriptTag]
         # use | as delimiter for sed because of slashes in script tag
         sed -i '' 's|<script src="js/default.js|<script>window.ButtonAnimationSpeed = 0;</script><script src="js/default.js|g' "$file"
         echo "Fixed $file"
    fi
done
