import 'dart:convert';
import 'dart:math';
import '../../domain/entities/weapon.dart';
import '../../core/constants.dart';

class GPTService {
  final Random _random = Random();

  Future<Map<String, dynamic>> generateWeaponData({
    required String description,
    required List<String> powers,
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock response - in real implementation, this would call GPT API
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

    final selectedPowers = powers.isNotEmpty
        ? powers
        : AppConstants.powerTypes.take(3).toList();

    final stats = _generateStats();

    return {
      'name': weaponNames[_random.nextInt(weaponNames.length)],
      'description': _generateDescription(description, selectedPowers),
      'imageUrl': _generateImageUrl(),
      'rarity': rarities[_random.nextInt(rarities.length)].name,
      'type': weaponTypes[_random.nextInt(weaponTypes.length)].name,
      'powers': selectedPowers,
      'stats': stats,
    };
  }

  Future<String> regenerateDescription(Weapon weapon) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    final descriptions = [
      'A weapon of legend, forged in the fires of destiny.',
      'This mystical weapon pulses with ancient power.',
      'Forged from the essence of fallen stars.',
      'A weapon that channels the fury of the elements.',
      'This blade holds the memories of countless battles.',
      'A weapon that seems to sing with otherworldly energy.',
      'Forged by master craftsmen in the depths of time.',
      'This weapon radiates an aura of pure power.',
    ];

    return descriptions[_random.nextInt(descriptions.length)];
  }

  Future<String> regenerateImage(Weapon weapon) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Return a different placeholder image
    final imageIds = [
      '400x300/1a1a2e/00d4ff',
      '400x300/16213e/ff6b6b',
      '400x300/0f3460/00d4ff',
    ];
    return 'https://via.placeholder.com/${imageIds[_random.nextInt(imageIds.length)]}?text=${Uri.encodeComponent(weapon.name)}';
  }

  String _generateDescription(String userDescription, List<String> powers) {
    final powerDescriptions = {
      'Lightning Strike': 'crackling with electric energy',
      'Fire Blast': 'engulfed in eternal flames',
      'Ice Shard': 'encased in crystalline frost',
      'Soul Drain': 'pulsing with dark energy',
      'Regen Boost': 'glowing with healing light',
      'Shield Bash': 'radiating protective energy',
      'Wind Slash': 'humming with air currents',
      'Earth Tremor': 'vibrating with seismic power',
    };

    final powerText = powers
        .map((power) => powerDescriptions[power] ?? power.toLowerCase())
        .join(', ');

    return '$userDescription. This weapon is $powerText, making it a formidable instrument of battle.';
  }

  String _generateImageUrl() {
    final colors = [
      '1a1a2e/00d4ff', // Dark blue with cyan
      '16213e/ff6b6b', // Dark blue with red
      '0f3460/00d4ff', // Darker blue with cyan
      '533a7b/ff6b6b', // Purple with red
    ];

    final color = colors[_random.nextInt(colors.length)];
    return 'https://via.placeholder.com/400x300/$color?text=Weapon+Image';
  }

  Map<String, int> _generateStats() {
    final baseStats = {
      'damage': 40 + _random.nextInt(40), // 40-79
      'speed': 40 + _random.nextInt(40), // 40-79
      'magic': 40 + _random.nextInt(40), // 40-79
      'durability': 40 + _random.nextInt(40), // 40-79
    };

    return baseStats;
  }

  // Real GPT API integration methods (commented out for now)
  /*
  Future<Map<String, dynamic>> _callGPTApi(String prompt) async {
    final response = await http.post(
      Uri.parse('${AppConstants.gptApiBaseUrl}/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppConstants.gptApiKey}',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {
            'role': 'system',
            'content': 'You are a futuristic weapon designer. Generate a fictional anime-style weapon based on user input. Return only valid JSON.',
          },
          {
            'role': 'user',
            'content': prompt,
          }
        ],
        'max_tokens': 500,
        'temperature': 0.8,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final content = data['choices'][0]['message']['content'];
      return jsonDecode(content);
    } else {
      throw Exception('Failed to generate weapon: ${response.statusCode}');
    }
  }

  Future<String> _callGPTImageApi(String prompt) async {
    final response = await http.post(
      Uri.parse('${AppConstants.gptApiBaseUrl}/images/generations'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppConstants.gptApiKey}',
      },
      body: jsonEncode({
        'prompt': 'Create a detailed anime-style futuristic weapon image. $prompt Style: Futuristic anime, glowing edges, inspired by Demon Slayer, neon colors.',
        'n': 1,
        'size': '512x512',
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'][0]['url'];
    } else {
      throw Exception('Failed to generate image: ${response.statusCode}');
    }
  }
  */
}
