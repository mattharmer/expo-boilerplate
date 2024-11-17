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
    ".env"
    ".env.example"
    ".gitignore"
    ".npmrc"
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

# Initialize Git repository before installing dependencies
print_blue "Initializing Git repository..."
git init

print_blue "Installing dependencies... This might take a few minutes."

# Save terminal output to a log file
log_file="install.log"
exec > >(tee -i "$log_file") 2>&1

# Install dependencies with detailed logging
npm install --progress --loglevel verbose

# Install Expo modules using npx (local CLI)
print_blue "Installing Expo modules..."
npx expo install \
  expo \
  expo-router \
  expo-constants \
  expo-linking \
  expo-splash-screen \
  expo-status-bar \
  expo-system-ui \
  expo-web-browser \
  expo-font \
  expo-image \
  react-native-reanimated \
  react-native-gesture-handler \
  react-native-screens \
  react-native-safe-area-context \
  @react-native-async-storage/async-storage

# Run Husky install
print_blue "Setting up Husky..."
npm run prepare

print_green "Project created and dependencies installed successfully at $project_path"
print_blue "Next steps:"
echo "1. Update .env with your configuration values"
echo "2. Update app.config.ts with your app details"
echo "3. Run 'npx expo start' to begin development" 