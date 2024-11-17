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

# Install all dependencies from package.json
print_blue "Installing dependencies..."
npm install --progress --loglevel verbose

# Generate package-lock.json if it doesn't exist
if [ ! -f "package-lock.json" ]; then
    print_blue "Generating package-lock.json..."
    npm install --package-lock-only
fi

# Run npm audit fix with force to address all issues
if [ -f "package-lock.json" ]; then
    print_blue "Fixing vulnerabilities..."
    npm audit fix

    print_blue "Checking for remaining vulnerabilities..."
    npm audit || true  # Continue even if vulnerabilities remain
    
    if [ $? -ne 0 ]; then
        print_red "Warning: Some vulnerabilities could not be fixed automatically."
        print_blue "Please review npm audit output and fix manually if needed."
    fi
fi

# Generate types
print_blue "Generating types..."
mkdir -p .expo/types
npx expo-env-info

# Update tsconfig.json with Expo Router types
print_blue "Updating TypeScript configuration..."
npx expo customize --force tsconfig.json

# Run TypeScript check using local installation
print_blue "Running TypeScript check..."
npx tsc --noEmit

print_green "Development environment setup complete!" 