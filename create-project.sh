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

# Create projects directory in user's home
projects_dir="$HOME/projects"
mkdir -p "$projects_dir"

# Set project path
project_path="$projects_dir/$project_name"

if [ -d "$project_path" ]; then
    print_red "Directory already exists at $project_path"
    exit 1
fi

print_blue "Creating new project: $project_name"

# Create directory and copy all necessary files
mkdir -p "$project_path"

# List of files to copy (ensures we don't miss any)
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

# Set up the new project
cd "$project_path" || exit 1

# Check and install Node.js based on OS
print_blue "Checking for Node.js installation..."

if ! command -v node &> /dev/null; then
    print_blue "Node.js not found. Installing Node.js..."
    
    # Detect OS
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Ubuntu/Debian
        curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
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

print_blue "Installing dependencies..."

# Install dependencies with detailed logging
npm install --progress --loglevel verbose --legacy-peer-deps

# Install specific Expo packages that might need native module linking
npx expo install \
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
    react-native-safe-area-context

print_green "Project created and dependencies installed successfully at $project_path"
print_blue "Next steps:"
echo "1. Update .env with your configuration values"
echo "2. Update app.config.ts with your app details"
echo "3. Run 'npx expo start' to begin development" 