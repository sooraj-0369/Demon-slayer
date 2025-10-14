import '../entities/weapon.dart';

abstract class WeaponRepository {
  // Get all weapons
  Future<List<Weapon>> getAllWeapons();
  
  // Get weapons by filter
  Future<List<Weapon>> getWeaponsByRarity(WeaponRarity rarity);
  Future<List<Weapon>> getWeaponsByType(WeaponType type);
  Future<List<Weapon>> getFavoriteWeapons();
  
  // Get single weapon
  Future<Weapon?> getWeaponById(String id);
  
  // Save weapon
  Future<void> saveWeapon(Weapon weapon);
  
  // Update weapon
  Future<void> updateWeapon(Weapon weapon);
  
  // Delete weapon
  Future<void> deleteWeapon(String id);
  
  // Toggle favorite
  Future<void> toggleFavorite(String id);
  
  // Generate new weapon
  Future<Weapon> generateWeapon({
    required String description,
    List<String>? powers,
  });
  
  // Regenerate weapon description
  Future<String> regenerateDescription(Weapon weapon);
  
  // Regenerate weapon image
  Future<String> regenerateImage(Weapon weapon);
}