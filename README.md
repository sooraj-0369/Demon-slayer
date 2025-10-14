# Weaponverse - AI Weapon Forge

A cross-platform Flutter application that allows users to generate, view, and save AI-created futuristic weapons using GPT text and image generation APIs.

## Features

- 🤖 **AI Weapon Generation**: Generate futuristic weapons using GPT API
- 🎨 **Futuristic UI**: Neon-themed interface with glowing effects
- 📱 **Cross-Platform**: Runs on Android, iOS, Web, and Desktop
- 💾 **Local Storage**: Save weapons locally using Hive
- 🔥 **Animated UI**: Smooth animations and transitions
- ⚔️ **Weapon Arsenal**: Organize and manage your weapon collection

## Getting Started

### Prerequisites

- Flutter SDK (3.9.0 or higher)
- Dart SDK
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd weaponverse
   ```

2. **Quick Setup (Recommended)**
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```

3. **Manual Setup (Alternative)**
   ```bash
   # Clean previous builds
   flutter clean
   
   # Install dependencies
   flutter pub get
   
   # Generate required code files
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Troubleshooting

If you encounter dependency conflicts:
```bash
# Check Flutter installation
flutter doctor

# Clean and retry
flutter clean
flutter pub get

# Check dependency tree
flutter pub deps
```

## Project Structure

```
lib/
├── core/                 # Core utilities and constants
│   ├── constants.dart
│   └── hive_setup.dart
├── data/                 # Data layer
│   ├── models/          # Data models
│   ├── repositories/    # Repository implementations
│   ├── services/        # API services
│   └── sample_weapons.dart
├── domain/              # Domain layer
│   ├── entities/        # Domain entities
│   └── repositories/    # Repository interfaces
├── presentation/        # Presentation layer
│   └── providers/       # Riverpod providers
└── ui/                  # UI layer
    ├── navigation/      # Navigation setup
    ├── screens/         # App screens
    ├── theme/           # App theme
    └── widgets/         # Reusable widgets
```

## Screens

1. **Splash Screen**: Animated loading screen with weapon forge animation
2. **Home Screen**: Grid view of all weapons with filtering options
3. **Generator Screen**: Create new weapons with AI
4. **Weapon Detail Screen**: View detailed weapon information
5. **Arsenal Screen**: Manage saved weapons
6. **Settings Screen**: App configuration and API settings

## API Integration

The app includes mock GPT integration for demonstration purposes. To use real GPT API:

1. Get an OpenAI API key
2. Add it to the settings screen
3. Update the `GPTService` to use real API calls

## Technologies Used

- **Flutter**: Cross-platform UI framework
- **Riverpod**: State management
- **Hive**: Local database
- **GoRouter**: Navigation
- **HTTP/Dio**: API communication
- **Shimmer**: Loading animations
- **Lottie**: Advanced animations

## Features Overview

### Weapon Generation
- Describe your weapon concept
- Select special powers
- AI generates weapon details and image
- Save to your arsenal

### Weapon Management
- View all generated weapons
- Filter by type, rarity, favorites
- Detailed weapon statistics
- Export/import functionality

### Futuristic UI
- Neon color scheme
- Glowing effects
- Smooth animations
- Responsive design

## Sample Weapons

The app comes with 5 preloaded sample weapons:
- Lunara Blade (Epic Sword)
- Stormforged Axe (Legendary Axe)
- Shadowstrike Dagger (Rare Dagger)
- Phoenix Staff (Mythic Staff)
- Voidreaver Gun (Epic Gun)

## Development

### Adding New Features
1. Create feature branch
2. Implement feature
3. Add tests
4. Submit pull request

### Code Generation
After adding new models or providers, run:
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Inspired by Demon Slayer, Cyberpunk Edgerunners, and Sword Art Online
- Uses OpenAI GPT for weapon generation
- Built with Flutter and modern development practices