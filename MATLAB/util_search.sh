#!/bin/bash

# helper script for verifying that all utils files are used in at least one
# other part of the project, any files that don't pass this test should likely
# be moved to the tests/helpers directory

# Directories
UTIL_DIR="utils"
FIG_DIR="../figures"

# Step 0: sanity check
if [ ! -d "$UTIL_DIR" ]; then
    echo "Utils directory $UTIL_DIR does not exist!"
    exit 1
fi

if [ ! -d "$FIG_DIR" ]; then
    echo "Figures directory $FIG_DIR does not exist!"
    exit 1
fi

# Step 1: mark directly referenced utils
declare -A used
for util_file in "$UTIL_DIR"/*.m; do
    filename=$(basename "$util_file")        # e.g., benchmarkDesign.m
    funcname="${filename%.*}"               # remove .m -> benchmarkDesign

    # Recursive search in figures dir for function name (case-insensitive optional)
    if grep -rqi "$funcname" "$FIG_DIR"; then
        used["$filename"]=1
    fi
done

# Step 2: iteratively mark utils referenced by other used utils
changed=1
while [ $changed -eq 1 ]; do
    changed=0
    for util_file in "$UTIL_DIR"/*.m; do
        filename=$(basename "$util_file")
        [ "${used[$filename]}" == "1" ] && continue
        funcname="${filename%.*}"

        for caller_file in "${!used[@]}"; do
            callername="${caller_file%.*}"
            if grep -qi "$funcname" "$UTIL_DIR/$caller_file"; then
                used["$filename"]=1
                changed=1
                break
            fi
        done
    done
done

# Step 3: report results
echo "==== Utils usage report ===="
for util_file in "$UTIL_DIR"/*.m; do
    filename=$(basename "$util_file")
    if [ "${used[$filename]}" == "1" ]; then
        echo "[USED]   $filename"
    else
        echo "[UNUSED] $filename"
    fi
done

