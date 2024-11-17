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

# At the start of the script, after the color functions
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
    ".env"
    ".env.example"
    ".gitignore"
    ".npmrc"
    "src/navigation"
    "src/hooks"
    "src/components"
    "src/sw.js"
    "src/context"
    "src/services"
    "src/styles"
    "src/utils"
    "src/assets"
    "src/assets/images"
    "src/assets/fonts"
    "src/i18n"
    "src/i18n/translations"
    "src/schemas"
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

# Save terminal output to a log file
log_file="install.log"
exec > >(tee -i "$log_file") 2>&1

# Install dependencies with verbose logging
npm install --progress --loglevel verbose

# Install expo-env-info globally to ensure it's available for type generation
print_blue "Installing expo-env-info..."
npm install -g expo-env-info

# Install additional dependencies
print_blue "Installing additional dependencies..."
npm install --save \
  date-fns \
  date-fns-tz \
  @react-navigation/bottom-tabs \
  @react-navigation/native-stack \
  react-native-svg \
  babel-plugin-module-resolver \
  zod \
  @testing-library/react-native \
  sharp

npm install --save-dev \
  @types/date-fns \
  postcss-loader \
  @types/testing-library__react-native \
  @types/sharp \
  @testing-library/jest-native \
  @types/expo \
  @types/expo-router \
  @types/react-native-firebase \
  @types/firebase \
  @types/react-navigation \
  @types/expo-constants \
  @types/expo-linking \
  @types/expo-localization \
  @types/expo-secure-store \
  @types/expo-splash-screen \
  @types/expo-status-bar \
  @types/expo-web-browser \
  @types/react-native-purchases \
  @types/react-native-svg

# Create necessary directories and generate types
print_blue "Setting up TypeScript types..."
mkdir -p .expo/types
expo-env-info

# Run npm audit fix to address vulnerabilities without breaking changes
npm audit fix

# Run npm audit to display any remaining vulnerabilities
npm audit

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

# Create necessary directories
print_blue "Setting up project structure..."
mkdir -p .expo/types
mkdir -p src/types

# Create expo-env.d.ts file
print_blue "Creating type declaration files..."
cat > src/types/expo-env.d.ts << 'EOF'
/// <reference types="expo/types"/>
/// <reference types="@react-native-async-storage/async-storage"/>
/// <reference types="expo-constants"/>

declare module "*.png";
declare module "*.jpg";
declare module "*.jpeg";
declare module "*.gif";
declare module "*.bmp";
declare module "*.tiff";
EOF

# Generate Expo types
print_blue "Setting up TypeScript types..."
mkdir -p .expo/types
npx expo-env-info

# Generate Expo Router types
print_blue "Generating Expo Router types..."
npx expo customize tsconfig.json

# Install additional type definitions
print_blue "Installing additional type definitions..."
npm install --save-dev \
  @types/react \
  @types/react-native \
  @types/node \
  @types/jest \
  @types/date-fns \
  @types/expo \
  @types/expo-router \
  @types/i18next \
  @types/react-i18next

# Run TypeScript check
print_blue "Running TypeScript check..."
npm run ts:check

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