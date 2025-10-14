#!/bin/bash

echo "🚀 Setting up Weaponverse - AI Weapon Forge"
echo "============================================="

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first."
    echo "Visit: https://flutter.dev/docs/get-started/install"
    exit 1
fi

echo "✅ Flutter found: $(flutter --version | head -n 1)"

# Clean previous build
echo "🧹 Cleaning previous build..."
flutter clean

# Get dependencies with verbose output
echo "📦 Installing dependencies..."
flutter pub get --verbose

if [ $? -ne 0 ]; then
    echo "❌ Failed to install dependencies. Trying with --no-example..."
    flutter pub get --no-example
    if [ $? -ne 0 ]; then
        echo "❌ Still failed. Please check your Flutter installation and internet connection."
        exit 1
    fi
fi

echo "✅ Dependencies installed successfully"

# Generate code
echo "🔧 Generating code..."
flutter packages pub run build_runner build --delete-conflicting-outputs

if [ $? -ne 0 ]; then
    echo "⚠️  Code generation failed, but continuing..."
    echo "You may need to run this manually later:"
    echo "   flutter packages pub run build_runner build --delete-conflicting-outputs"
fi

# Create assets directories if they don't exist
echo "📁 Creating asset directories..."
mkdir -p assets/images
mkdir -p assets/animations
mkdir -p assets/icons
mkdir -p assets/fonts

echo "✅ Asset directories created"

echo ""
echo "🎉 Setup complete! You can now run the app with:"
echo "   flutter run"
echo ""
echo "📱 For specific platforms:"
echo "   flutter run -d chrome          # Web"
echo "   flutter run -d windows         # Windows"
echo "   flutter run -d macos           # macOS"
echo "   flutter run -d linux           # Linux"
echo ""
echo "🔧 Additional commands:"
echo "   flutter test                   # Run tests"
echo "   flutter analyze               # Analyze code"
echo "   flutter build apk             # Build Android APK"
echo "   flutter build web             # Build for web"
echo ""
echo "⚠️  Note: If you encounter any issues, try:"
echo "   flutter pub deps               # Check dependency tree"
echo "   flutter doctor                 # Check Flutter installation"
echo ""
echo "Happy weapon forging! ⚔️✨"


