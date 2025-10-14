import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../core/constants.dart';
import '../../domain/entities/weapon.dart';
import '../../core/weapon_colors.dart';

class GeminiService {
  late GenerativeModel _model;
  bool _initialized = false;

  /// Initialize the Gemini service with API key
  Future<void> initialize() async {
    if (_initialized) return;

    try {
      // Initialize text model for weapon generation
      _model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: AppConstants.geminiApiKey,
        generationConfig: GenerationConfig(
          temperature: 0.8,
          topK: 40,
          topP: 0.95,
          maxOutputTokens: 1024,
        ),
      );

      _initialized = true;
    } catch (e) {
      throw Exception('Failed to initialize Gemini service: $e');
    }
  }

  /// Generate weapon data using Gemini AI
  Future<Map<String, dynamic>> generateWeaponData({
    required String description,
    required List<String> powers,
  }) async {
    if (!_initialized) await initialize();

    try {
      final prompt = _buildWeaponGenerationPrompt(description, powers);

      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);

      if (response.text == null) {
        throw Exception('No response from Gemini API');
      }

      // Parse the JSON response (strip code fences if present)
      final rawText = response.text!.trim();
      final jsonText = _extractJson(rawText);
      final weaponData = jsonDecode(jsonText);

      // Generate image URL using Gemini
      final imageUrl = await generateWeaponImage(
        weaponData['name'] ?? 'Mystical Weapon',
        description,
      );

      return {...weaponData, 'imageUrl': imageUrl};
    } catch (e) {
      // Fallback to mock data if API fails
      return _generateFallbackWeaponData(description, powers);
    }
  }

  /// Generate weapon image using Gemini AI
  Future<String> generateWeaponImage(
    String weaponName,
    String description,
  ) async {
    if (!_initialized) await initialize();

    try {
      // First attempt: Pollinations prompt-based image
      final prompt = '$weaponName, futuristic anime-style weapon, detailed, glowing, mystical, high quality, concept art';
      final encoded = Uri.encodeComponent(prompt);
      final ts = DateTime.now().millisecondsSinceEpoch;
      final pollinationsUrl = 'https://image.pollinations.ai/prompt/$encoded?width=768&height=512&seed=${ts % 100000}';

      // Return Pollinations URL; UI will fetch directly. If it fails to load, client shows error icon.
      // To improve success rate across platforms, also provide a deterministic fallback URL that always returns an image (Picsum).
      return pollinationsUrl;
    } catch (e) {
      // Deterministic fallback image that always loads
      return _picsumFallback(weaponName, description);
    }
  }

  /// Regenerate weapon description using Gemini
  Future<String> regenerateDescription(Weapon weapon) async {
    if (!_initialized) await initialize();

    try {
      final prompt = _buildDescriptionRegenerationPrompt(weapon);

      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);

      if (response.text == null) {
        throw Exception('No response from Gemini API');
      }

      return response.text!.trim();
    } catch (e) {
      // Fallback to mock description
      return _generateFallbackDescription();
    }
  }

  /// Regenerate weapon image using Gemini
  Future<String> regenerateImage(Weapon weapon) async {
    if (!_initialized) await initialize();

    try {
      return await generateWeaponImage(weapon.name, weapon.description);
    } catch (e) {
      // Fallback to basic placeholder
      return _generateFallbackImageUrl(weapon.name);
    }
  }

  /// Build prompt for weapon generation
  String _buildWeaponGenerationPrompt(String description, List<String> powers) {
    final powerText = powers.isNotEmpty
        ? powers.join(', ')
        : 'mystical abilities';

    return '''
Generate a detailed futuristic anime-style weapon based on this description: "$description"

The weapon should have these powers: $powerText

Please return ONLY a valid JSON object with the following structure (no backticks, no code fences, no explanation):
{
  "name": "A creative weapon name",
  "description": "A detailed description of the weapon's appearance, abilities, and lore",
  "rarity": "one of: common, uncommon, rare, epic, legendary, mythic",
  "type": "one of: sword, staff, bow, dagger, axe, gun, shield, gauntlet",
  "stats": {
    "damage": "number between 40-100",
    "speed": "number between 40-100", 
    "magic": "number between 40-100",
    "durability": "number between 40-100"
  }
}

Make the weapon sound epic and anime-inspired, with glowing effects, mystical properties, and futuristic design elements.
''';
  }

  /// Extract a JSON object from a Gemini response that may include code fences
  String _extractJson(String raw) {
    // If wrapped in ```json ... ``` or ``` ... ```, strip fences
    final fenceRegex = RegExp(r'^```(?:json)?\s*([\s\S]*?)\s*```\s*\$?', multiLine: true);
    final match = fenceRegex.firstMatch(raw);
    if (match != null && match.groupCount >= 1) {
      return match.group(1)!.trim();
    }
    // Some responses may include trailing text; try to find first { ... } block
    final start = raw.indexOf('{');
    final end = raw.lastIndexOf('}');
    if (start != -1 && end != -1 && end > start) {
      return raw.substring(start, end + 1);
    }
    return raw; // fallback
  }

  String _picsumFallback(String weaponName, String description) {
    final seed = Uri.encodeComponent('${weaponName}_${description}'.toLowerCase());
    return 'https://picsum.photos/seed/$seed/768/512';
  }

  /// Build prompt for description regeneration
  String _buildDescriptionRegenerationPrompt(Weapon weapon) {
    return '''
Regenerate a more detailed and epic description for this weapon:

Name: ${weapon.name}
Current Description: ${weapon.description}
Rarity: ${WeaponColors.getRarityDisplayName(weapon.rarity)}
Type: ${WeaponColors.getTypeDisplayName(weapon.type)}
Powers: ${weapon.powers.join(', ')}

Make the new description more detailed, epic, and anime-inspired. Include:
- Detailed visual appearance
- Mystical properties and lore
- How the weapon feels to wield
- Special abilities and effects
- Backstory or origin

Keep it under 200 words but make it engaging and immersive.
''';
  }

  /// Generate enhanced placeholder image
  String _generateEnhancedPlaceholderImage(
    String weaponName,
    String description,
  ) {
    // Create a more sophisticated placeholder based on weapon characteristics
    final colors = [
      '1a1a2e/00d4ff', // Dark blue with cyan
      '16213e/ff6b6b', // Dark blue with red
      '0f3460/00d4ff', // Darker blue with cyan
      '533a7b/ff6b6b', // Purple with red
      '2d1b69/ffd700', // Purple with gold
      '0c4a6e/00ffff', // Dark blue with aqua
    ];

    final colorIndex = weaponName.hashCode.abs() % colors.length;
    final color = colors[colorIndex];
    final encodedName = Uri.encodeComponent(weaponName);

    return 'https://via.placeholder.com/512x512/$color?text=$encodedName';
  }

  /// Generate fallback weapon data
  Map<String, dynamic> _generateFallbackWeaponData(
    String description,
    List<String> powers,
  ) {
    final weaponNames = [
      'Lunara Blade',
      'Stormforged Axe',
      'Shadowstrike Dagger',
      'Phoenix Staff',
      'Voidreaver Gun',
      'Frostbite Bow',
      'Thunderfist Gauntlet',
      'Aegis Shield',
      'Soulrend Sword',
      'Inferno Cannon',
    ];

    final weaponTypes = WeaponType.values;
    final rarities = WeaponRarity.values;
    final random = DateTime.now().millisecondsSinceEpoch;

    final selectedPowers = powers.isNotEmpty
        ? powers
        : AppConstants.powerTypes.take(3).toList();

    final stats = _generateFallbackStats();

    return {
      'name': weaponNames[random % weaponNames.length],
      'description':
          '$description. This mystical weapon pulses with ancient power and channels the fury of the elements.',
      'imageUrl': _generateEnhancedPlaceholderImage(
        weaponNames[random % weaponNames.length],
        description,
      ),
      'rarity': rarities[random % rarities.length].name,
      'type': weaponTypes[random % weaponTypes.length].name,
      'powers': selectedPowers,
      'stats': stats,
    };
  }

  /// Generate fallback stats
  Map<String, int> _generateFallbackStats() {
    final random = DateTime.now().millisecondsSinceEpoch;
    return {
      'damage': 40 + (random % 40),
      'speed': 40 + (random % 40),
      'magic': 40 + (random % 40),
      'durability': 40 + (random % 40),
    };
  }

  /// Generate fallback description
  String _generateFallbackDescription() {
    final descriptions = [
      'A weapon of legend, forged in the fires of destiny and tempered by starlight.',
      'This mystical weapon pulses with ancient power, its surface shimmering with otherworldly energy.',
      'Forged from the essence of fallen stars and blessed by celestial beings.',
      'A weapon that channels the fury of the elements, crackling with raw magical energy.',
      'This blade holds the memories of countless battles, each scar telling a story of triumph.',
      'A weapon that seems to sing with otherworldly energy, its melody both beautiful and deadly.',
      'Forged by master craftsmen in the depths of time, this weapon transcends mortal understanding.',
      'This weapon radiates an aura of pure power, its very presence commanding respect and fear.',
    ];

    final random = DateTime.now().millisecondsSinceEpoch;
    return descriptions[random % descriptions.length];
  }

  /// Generate fallback image URL
  String _generateFallbackImageUrl(String weaponName) {
    final colors = [
      '1a1a2e/00d4ff',
      '16213e/ff6b6b',
      '0f3460/00d4ff',
      '533a7b/ff6b6b',
    ];

    final random = DateTime.now().millisecondsSinceEpoch;
    final color = colors[random % colors.length];
    final encodedName = Uri.encodeComponent(weaponName);

    return 'https://via.placeholder.com/400x300/$color?text=$encodedName';
  }
}
