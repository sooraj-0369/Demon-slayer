class AppConstants {
  // API Configuration
  static const String gptApiBaseUrl = 'https://api.openai.com/v1';
  static const String gptApiKey = 'YOUR_GPT_API_KEY_HERE';
  static const String geminiApiKey = 'AIzaSyCYuxBU7A9mE_iLVkV4n_Kei_Fkyhg31aA';

  // Storage Keys
  static const String weaponsBoxName = 'weapons';
  static const String settingsBoxName = 'settings';
  static const String cartBoxName = 'cart';
  static const String apiKeyKey = 'api_key';
  static const String themeKey = 'theme';

  // UI Constants
  static const double cardBorderRadius = 16.0;
  static const double buttonBorderRadius = 12.0;
  static const double inputBorderRadius = 8.0;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 800);

  // Weapon Generation
  static const List<String> powerTypes = [
    'Lightning Strike',
    'Fire Blast',
    'Ice Shard',
    'Soul Drain',
    'Regen Boost',
    'Shield Bash',
    'Wind Slash',
    'Earth Tremor',
    'Shadow Step',
    'Healing Light',
    'Poison Cloud',
    'Time Freeze',
    'Energy Beam',
    'Gravity Well',
    'Plasma Burst',
  ];

  static const List<String> weaponTypes = [
    'sword',
    'staff',
    'bow',
    'dagger',
    'axe',
    'gun',
    'shield',
    'gauntlet',
  ];

  static const List<String> rarities = [
    'common',
    'uncommon',
    'rare',
    'epic',
    'legendary',
    'mythic',
  ];

  // Sample weapon prompts
  static const List<String> samplePrompts = [
    'A blade forged from moonlight and storm energy',
    'A staff that channels the power of ancient dragons',
    'A bow that shoots arrows of pure light',
    'A dagger that cuts through dimensions',
    'An axe that burns with eternal flames',
    'A gun that fires bolts of lightning',
    'A shield that reflects magic attacks',
    'A gauntlet that enhances physical strength',
  ];
}

class AppStrings {
  static const String appName = 'Weaponverse';
  static const String appTagline = 'AI Weapon Forge';

  // Navigation
  static const String home = 'Home';
  static const String generate = 'Generate';
  static const String arsenal = 'Arsenal';
  static const String settings = 'Settings';

  // Actions
  static const String forgeWeapon = 'Forge Weapon';
  static const String addToArsenal = 'Add to Arsenal';
  static const String regenerateDescription = 'Regenerate Description';
  static const String regenerateImage = 'Regenerate Image';
  static const String save = 'Save';
  static const String delete = 'Delete';
  static const String favorite = 'Favorite';
  static const String share = 'Share';

  // Status Messages
  static const String forgingWeapon = 'Forging your weapon...';
  static const String weaponForged = 'Weapon forged successfully!';
  static const String weaponSaved = 'Weapon saved to arsenal!';
  static const String weaponDeleted = 'Weapon deleted!';
  static const String errorOccurred = 'An error occurred';

  // Placeholders
  static const String describeYourWeapon = 'Describe your weapon...';
  static const String selectPowers = 'Select powers for your weapon';
  static const String noWeaponsFound = 'No weapons found';
  static const String startForging = 'Start forging your first weapon!';

  // Settings
  static const String apiKey = 'AIzaSyCYuxBU7A9mE_iLVkV4n_Kei_Fkyhg31aA';
  static const String theme = 'Theme';
  static const String darkTheme = 'Dark Theme';
  static const String lightTheme = 'Light Theme';
  static const String neonTheme = 'Neon Theme';
}
