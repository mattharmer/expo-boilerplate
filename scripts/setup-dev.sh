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
LOG_FILE="setup-dev-$(date +%Y%m%d_%H%M%S).log"
exec 1> >(tee -a "$LOG_FILE") 2>&1

print_blue "Logging output to $LOG_FILE"

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

# Setup development environment
print_blue "Setting up development environment..."

# Copy .env.example to .env if it doesn't exist
if [ ! -f ".env" ] && [ -f ".env.example" ]; then
    cp .env.example .env
    print_blue "Created .env from .env.example"
fi

# Load environment variables before expo commands
print_blue "Loading environment variables..."
if [ -f ".env" ]; then
    set -a
    source .env
    set +a
fi

# Add default values if not set
export APP_ENV=${APP_ENV:-development}
export API_URL=${API_URL:-http://localhost:3000}

# Clean installation
print_blue "Cleaning previous installation..."
rm -rf node_modules
rm -rf .expo
rm -rf dist
rm -rf web-build
rm -f package-lock.json  # Remove old package-lock.json

# Fresh install to generate new package-lock.json
print_blue "Installing dependencies..."
npm cache clean --force  # Clean npm cache
npm install --progress --loglevel verbose  # This will generate a new package-lock.json

# Generate types
print_blue "Generating types..."
mkdir -p .expo/types
npx expo-env-info

# Copy tsconfig template
print_blue "Updating TypeScript configuration..."
cp scripts/tsconfig.template.json tsconfig.json

# Create and update expo-env.d.ts
print_blue "Generating type definitions..."
cat > expo-env.d.ts << EOL
/// <reference types="expo/types"/>
/// <reference types="nativewind/types"/>

// Add any custom type definitions here
declare module '*.svg' {
  import { SvgProps } from 'react-native-svg';
  const content: React.FC<SvgProps>;
  export default content;
}
EOL

# Check for vulnerabilities in new package-lock.json
print_blue "Checking for vulnerabilities in fresh install..."
npm audit || true  # Show vulnerabilities but continue

print_blue "Attempting to fix vulnerabilities..."
npm audit fix || true  # Continue even if fix fails

print_green "Development environment setup complete!"
print_blue "Run 'npm run ts:check' to verify TypeScript setup" 
print_blue "Run 'npm run start:clear' to start the development server"
