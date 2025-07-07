#!/bin/bash

# USE CASE - Copy FILES from SOURCE_DIR to TARGET_DIR (e.g. updating programming notes)

SOURCE_DIR="/c/Users/usopp/Documents/goingmerry/src/"
TARGET_DIR="/c/Users/franky/Documents/thousandsunny/"

FILES=(
    "basics.rs"
    "data_types.rs"
    "flow_control.rs"
    "user_input.rs"
)

# Function to display usage information
usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  -s, --source DIR    Source directory path"
    echo "  -t, --target DIR    Target directory path"
    echo "  -h, --help          Show this help message"
    echo ""
    echo "Example:"
    echo "  $0 -s /c/Users/username/Documents -t /c/Users/username/Backup"
    echo ""
    echo "Note: Edit the FILES array in the script to specify which files to copy"
}

# Function to convert Windows path to Git Bash format if needed
normalize_path() {
    local path="$1"
    # Convert Windows backslashes to forward slashes
    path="${path//\\//}"
    # Convert C: to /c/ format if it's a Windows absolute path
    if [[ "$path" =~ ^[A-Za-z]: ]]; then
        drive="${path:0:1}"
        path="/$(echo "$drive" | tr '[:upper:]' '[:lower:]')${path:2}"
    fi
    echo "$path"
}

# Function to check if directory exists
check_directory() {
    local dir="$1"
    local name="$2"
    
    if [[ ! -d "$dir" ]]; then
        echo "Error: $name directory '$dir' does not exist."
        return 1
    fi
    return 0
}

# Function to copy files
copy_files() {
    local source="$1"
    local target="$2"
    local copied=0
    local failed=0
    local skipped=0
    
    echo "Starting file copy operation..."
    echo "Source: $source"
    echo "Target: $target"
    echo "Files to copy: ${#FILES[@]}"
    echo "----------------------------------------"
    
    for file in "${FILES[@]}"; do
        local source_file="$source/$file"
        local target_file="$target/$file"
        
        if [[ -f "$source_file" ]]; then
            # Check if target file exists
            if [[ -f "$target_file" ]]; then
                echo "Replacing: $file"
            else
                echo "Copying: $file"
            fi
            
            # Copy the file, replacing if it exists
            if cp "$source_file" "$target_file" 2>/dev/null; then
                ((copied++))
            else
                echo "Error: Failed to copy $file"
                ((failed++))
            fi
        else
            echo "Warning: $file not found in source directory"
            ((skipped++))
        fi
    done
    
    echo "----------------------------------------"
    echo "Copy operation completed:"
    echo "  Successfully copied: $copied"
    echo "  Failed: $failed"
    echo "  Skipped (not found): $skipped"
    
    return $failed
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -s|--source)
            SOURCE_DIR="$2"
            shift 2
            ;;
        -t|--target)
            TARGET_DIR="$2"
            shift 2
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done

# Normalize paths for Git Bash
SOURCE_DIR=$(normalize_path "$SOURCE_DIR")
TARGET_DIR=$(normalize_path "$TARGET_DIR")

# Validate directories
if ! check_directory "$SOURCE_DIR" "Source"; then
    exit 1
fi

if ! check_directory "$TARGET_DIR" "Target"; then
    echo "Creating target directory: $TARGET_DIR"
    if ! mkdir -p "$TARGET_DIR"; then
        echo "Error: Failed to create target directory"
        exit 1
    fi
fi

# Perform the copy operation
copy_files "$SOURCE_DIR" "$TARGET_DIR"
exit_code=$?

if [[ $exit_code -eq 0 ]]; then
    echo "All files copied successfully!"
else
    echo "Some files failed to copy. Check output for details."
fi

exit $exit_code