#!/bin/bash

# Colors for output
print_blue() {
    printf "\e[34m%s\e[0m\n" "$1"
}

print_green() {
    printf "\e[32m%s\e[0m\n" "$1"
}

# Setup development environment
print_blue "Setting up development environment..."

# Copy .env.example to .env if it doesn't exist
if [ ! -f ".env" ] && [ -f ".env.example" ]; then
    cp .env.example .env
    print_blue "Created .env from .env.example"
fi

# Install dependencies
print_blue "Installing dependencies..."
npm install

# Generate types
print_blue "Generating types..."
mkdir -p .expo/types
npx expo-env-info
npx expo customize tsconfig.json

print_green "Development environment setup complete!" 