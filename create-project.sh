#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

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

# Error handling
handle_error() {
    print_red "An error occurred. Check the logs for details."
    exit 1
}

trap 'handle_error' ERR

# Setup logging
LOG_FILE="create-project-$(date +%Y%m%d_%H%M%S).log"
exec 1> >(tee -a "$LOG_FILE") 2>&1

print_blue "Logging output to $LOG_FILE"

# Get project name if not provided
if [ -z "$1" ]; then
    read -p "Enter project name: " project_name
else
    project_name=$1
fi

# Use existing Projects directory with capital 'P'
projects_dir="$HOME/Projects"

# Create projects directory if it doesn't exist
mkdir -p "$projects_dir"

# Set project path
project_path="$projects_dir/$project_name"

if [ -d "$project_path" ]; then
    print_red "Directory already exists at $project_path"
    exit 1
fi

print_blue "Creating new project: $project_name at $project_path"

# Create directory and copy all necessary files
mkdir -p "$project_path"

# List of files to copy
files_to_copy=(
    "src"
    "app.json"
    "app.config.ts"
    "babel.config.js"
    "tailwind.config.js"
    "tsconfig.json"
    ".eslintrc.json"
    ".prettierrc.json"
    ".lintstagedrc.json"
    "package.json"
    "projectGuide.md"
    ".env.example"
    ".gitignore"
    ".npmrc"
    "jest.config.js"
)

# Copy each file/directory
for file in "${files_to_copy[@]}"; do
    if [ -e "$file" ]; then
        cp -r "$file" "$project_path/"
        print_blue "Copied $file"
    else
        print_red "Warning: $file not found in boilerplate"
    fi
done

# Navigate to project directory
cd "$project_path" || exit 1

# Copy .env.example to .env if .env does not exist
if [ ! -f ".env" ] && [ -f ".env.example" ]; then
    cp .env.example .env
    print_blue "Created .env from .env.example"
fi

# Check Node.js version
required_node_version_major=18
current_node_version=$(node -v | grep -oP 'v\K\d+')

if [ "$current_node_version" != "$required_node_version_major" ]; then
    print_red "Node.js version 18.x is required. You have version $(node -v)."
    print_blue "Please install Node.js 18.x using nvm."
    exit 1
else
    print_green "Node.js version $(node -v) is compatible."
fi

print_blue "Installing dependencies... This might take a few minutes."

# Install dependencies with better error handling
print_blue "Installing dependencies..."
npm install --progress --loglevel verbose

# Generate package-lock.json if it doesn't exist
if [ ! -f "package-lock.json" ]; then
    print_blue "Generating package-lock.json..."
    npm install --package-lock-only
fi

# Run npm audit only if package-lock.json exists
if [ -f "package-lock.json" ]; then
    print_blue "Fixing vulnerabilities..."
    npm audit fix

    print_blue "Checking for remaining vulnerabilities..."
    npm audit
fi

# Create necessary directories
print_blue "Setting up project structure..."
mkdir -p src/assets/images src/assets/fonts src/i18n/translations src/schemas src/context src/services src/styles src/utils

# Generate types
print_blue "Generating types..."
mkdir -p .expo/types
npx expo-env-info

# Update tsconfig.json with Expo Router types
print_blue "Updating TypeScript configuration..."
npx expo customize

# Run TypeScript check using local installation
print_blue "Running TypeScript check..."
npx tsc --noEmit

# Initialize Git repository
print_blue "Initializing Git repository..."
git init
git add .
git commit -m "Initial commit: Project setup"

print_green "Project created and dependencies installed successfully at $project_path"
print_blue "Next steps:"
echo "1. Update .env with your configuration values"
echo "2. Update app.config.ts with your app details (if not already done)"
echo "3. Run 'npx expo start' to begin development"