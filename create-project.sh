#!/bin/bash

# Colors for output
print_blue() {
    printf "\e[34m%s\e[0m\n" "$1"
}

print_green() {
    printf "\e[32m%s\e[0m\n" "$1"
}

print_red() {
    printf "\e[31m%s\e[0m\n" "$1"
}

# Get the real user's home directory even when run with sudo
if [ -n "$SUDO_USER" ]; then
    REAL_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)
else
    REAL_HOME="$HOME"
fi

# Get project name
read -p "Enter project name: " project_name

# Create projects directory if it doesn't exist
projects_dir="$REAL_HOME/projects"
mkdir -p "$projects_dir"

# Set project path in projects directory
project_path="$projects_dir/$project_name"

if [ -d "$project_path" ]; then
    print_red "Directory already exists at $project_path"
    exit 1
fi

print_blue "Creating new project: $project_name"

# Create directory and copy files
mkdir -p "$project_path"
cp -r ./{src,install.sh,projectGuide.md,.env,.gitignore} "$project_path"/

# Set up the new project
cd "$project_path" || exit 1
chmod +x install.sh

print_green "Project created at $project_path"
print_blue "Running installation script..."

# Run installation script
./install.sh 