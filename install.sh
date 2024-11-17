#!/bin/bash

# Colors for output (using printf for better compatibility)
print_blue() {
    printf "\e[34m%s\e[0m\n" "$1"
}

print_green() {
    printf "\e[32m%s\e[0m\n" "$1"
}

print_red() {
    printf "\e[31m%s\e[0m\n" "$1"
}

# Check and install Node.js based on OS
print_blue "Checking for Node.js installation..."

if ! command -v node &> /dev/null; then
    print_blue "Node.js not found. Installing Node.js..."
    
    # Detect OS
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Ubuntu/Debian
        curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
        sudo apt-get update
        sudo apt-get install -y nodejs
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if ! command -v brew &> /dev/null; then
            print_red "Homebrew not found. Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        brew install node
    else
        print_red "Unsupported operating system. Please install Node.js manually from https://nodejs.org"
        exit 1
    fi
    
    print_green "Node.js installed successfully!"
else
    print_green "Node.js is already installed!"
fi

print_blue "Installing Expo Boilerplate..."

# Initialize git repository
git init

# Create basic .env file
echo "# Environment Variables
API_URL=
FIREBASE_API_KEY=
FIREBASE_AUTH_DOMAIN=
FIREBASE_PROJECT_ID=
FIREBASE_STORAGE_BUCKET=
FIREBASE_MESSAGING_SENDER_ID=
FIREBASE_APP_ID=
FIREBASE_MEASUREMENT_ID=" > .env

# Install dependencies
print_blue "Installing dependencies..."
npm install --progress --loglevel verbose

# Create basic ESLint configuration
echo '{
  "extends": [
    "universe/native",
    "universe/shared/typescript-analysis"
  ],
  "overrides": [
    {
      "files": [
        "*.ts",
        "*.tsx",
        "*.d.ts"
      ],
      "parserOptions": {
        "project": "./tsconfig.json"
      }
    }
  ]
}' > .eslintrc.json

# Create basic Prettier configuration
echo '{
  "semi": true,
  "singleQuote": true,
  "tabWidth": 2,
  "trailingComma": "es5"
}' > .prettierrc.json

# Initialize basic tailwind.config.js
echo "module.exports = {
  content: [
    './src/**/*.{js,jsx,ts,tsx}',
    './app/**/*.{js,jsx,ts,tsx}'
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}" > tailwind.config.js

# Setup Husky for git hooks
npm pkg set scripts.prepare="husky install"
npm run prepare
npx husky add .husky/pre-commit "npx lint-staged"

# Create basic lint-staged configuration
echo '{
  "*.{js,jsx,ts,tsx}": [
    "eslint --fix",
    "prettier --write"
  ]
}' > .lintstagedrc.json

# Git setup
print_blue "Setting up Git repository..."
git init
git add .
git commit -m "Initial commit: Project setup from boilerplate"

print_blue "To connect to GitHub:"
echo "1. Create a new repository on GitHub"
echo "2. Run: git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git"
echo "3. Run: git push -u origin main"

print_green "Project structure and dependencies installed successfully!"
print_blue "Next steps:"
echo "1. Update .env with your configuration values"
echo "2. Update app.config.ts with your app details"
echo "3. Run 'npx expo start' to begin development"