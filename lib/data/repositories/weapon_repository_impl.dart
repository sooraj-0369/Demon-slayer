import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:weaponverse/data/services/gemini_service.dart';
import '../../domain/repositories/weapon_repository.dart';
import '../../domain/entities/weapon.dart';
import '../models/weapon.dart';
import '../services/gpt_service.dart';
import '../../core/constants.dart';

class WeaponRepositoryImpl implements WeaponRepository {
  final GeminiService _gptService = GeminiService();
  final _uuid = const Uuid();

  Future<Box<Weapon>> get _weaponsBox async {
    return await Hive.openBox<Weapon>(AppConstants.weaponsBoxName);
  }

  @override
  Future<List<Weapon>> getAllWeapons() async {
    final box = await _weaponsBox;
    return box.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<List<Weapon>> getWeaponsByRarity(WeaponRarity rarity) async {
    final box = await _weaponsBox;
    return box.values.where((weapon) => weapon.rarity == rarity).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<List<Weapon>> getWeaponsByType(WeaponType type) async {
    final box = await _weaponsBox;
    return box.values.where((weapon) => weapon.type == type).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<List<Weapon>> getFavoriteWeapons() async {
    final box = await _weaponsBox;
    return box.values.where((weapon) => weapon.isFavorite).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<Weapon?> getWeaponById(String id) async {
    final box = await _weaponsBox;
    return box.get(id);
  }

  @override
  Future<void> saveWeapon(Weapon weapon) async {
    final box = await _weaponsBox;
    await box.put(weapon.id, weapon);
  }

  @override
  Future<void> updateWeapon(Weapon weapon) async {
    final box = await _weaponsBox;
    await box.put(weapon.id, weapon);
  }

  @override
  Future<void> deleteWeapon(String id) async {
    final box = await _weaponsBox;
    await box.delete(id);
  }

  @override
  Future<void> toggleFavorite(String id) async {
    final weapon = await getWeaponById(id);
    if (weapon != null) {
      final updatedWeapon = weapon.copyWith(isFavorite: !weapon.isFavorite);
      await updateWeapon(updatedWeapon);
    }
  }

  @override
  Future<Weapon> generateWeapon({
    required String description,
    List<String>? powers,
  }) async {
    try {
      // Generate weapon data using GPT service
      final weaponData = await _gptService.generateWeaponData(
        description: description,
        powers: powers ?? [],
      );

      print(" in generateWeapon, weaponData: ${weaponData.toString()}");

      // Create weapon instance
      final weapon = Weapon(
        id: _uuid.v4(),
        name: weaponData['name'] ?? 'Unknown Weapon',
        description: weaponData['description'] ?? description,
        imageUrl: weaponData['imageUrl']?.toString().trim().isNotEmpty == true
            ? weaponData['imageUrl']
            : await _gptService.generateWeaponImage(
                (weaponData['name'] ?? 'Mystical Weapon').toString(),
                description,
              ),
        rarity: _parseRarity(weaponData['rarity']),
        type: _parseType(weaponData['type']),
        powers: List<String>.from(weaponData['powers'] ?? []),
        stats: Map<String, int>.from(weaponData['stats'] ?? {}),
        createdAt: DateTime.now(),
      );

      return weapon;
    } catch (e) {
      // Return a fallback weapon if generation fails
      print(" in generateWeapon, error: $e");
      return _createFallbackWeapon(description, powers);
    }
  }

  @override
  Future<String> regenerateDescription(Weapon weapon) async {
    try {
      return await _gptService.regenerateDescription(weapon);
    } catch (e) {
      return weapon.description; // Return original if regeneration fails
    }
  }

  @override
  Future<String> regenerateImage(Weapon weapon) async {
    try {
      return await _gptService.regenerateImage(weapon);
    } catch (e) {
      return weapon.imageUrl; // Return original if regeneration fails
    }
  }

  WeaponRarity _parseRarity(dynamic rarity) {
    if (rarity is String) {
      return WeaponRarity.values.firstWhere(
        (r) => r.name == rarity,
        orElse: () => WeaponRarity.common,
      );
    }
    return WeaponRarity.common;
  }

  WeaponType _parseType(dynamic type) {
    if (type is String) {
      return WeaponType.values.firstWhere(
        (t) => t.name == type,
        orElse: () => WeaponType.sword,
      );
    }
    return WeaponType.sword;
  }

  String _getPlaceholderImageUrl() {
    // Return a placeholder image URL
    return 'https://via.placeholder.com/400x300/1a1a2e/00d4ff?text=Weapon+Image';
  }

  Weapon _createFallbackWeapon(String description, List<String>? powers) {
    return Weapon(
      id: _uuid.v4(),
      name: 'Mysterious Weapon',
      description: description,
      imageUrl: _getPlaceholderImageUrl(),
      rarity: WeaponRarity.common,
      type: WeaponType.sword,
      powers: powers ?? ['Unknown Power'],
      stats: {'damage': 50, 'speed': 50, 'magic': 50},
      createdAt: DateTime.now(),
    );
  }
}
