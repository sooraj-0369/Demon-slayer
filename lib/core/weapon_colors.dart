import '../data/models/weapon.dart';

class WeaponColors {
  static int getRarityColor(WeaponRarity rarity) {
    switch (rarity) {
      case WeaponRarity.common:
        return 0xFF808080; // Gray
      case WeaponRarity.uncommon:
        return 0xFF00FF00; // Green
      case WeaponRarity.rare:
        return 0xFF0080FF; // Blue
      case WeaponRarity.epic:
        return 0xFF8000FF; // Purple
      case WeaponRarity.legendary:
        return 0xFFFF8000; // Orange
      case WeaponRarity.mythic:
        return 0xFFFF0080; // Pink
    }
  }

  static String getRarityDisplayName(WeaponRarity rarity) {
    switch (rarity) {
      case WeaponRarity.common:
        return 'Common';
      case WeaponRarity.uncommon:
        return 'Uncommon';
      case WeaponRarity.rare:
        return 'Rare';
      case WeaponRarity.epic:
        return 'Epic';
      case WeaponRarity.legendary:
        return 'Legendary';
      case WeaponRarity.mythic:
        return 'Mythic';
    }
  }

  static String getTypeDisplayName(WeaponType type) {
    switch (type) {
      case WeaponType.sword:
        return 'Sword';
      case WeaponType.staff:
        return 'Staff';
      case WeaponType.bow:
        return 'Bow';
      case WeaponType.dagger:
        return 'Dagger';
      case WeaponType.axe:
        return 'Axe';
      case WeaponType.gun:
        return 'Gun';
      case WeaponType.shield:
        return 'Shield';
      case WeaponType.gauntlet:
        return 'Gauntlet';
    }
  }
}
