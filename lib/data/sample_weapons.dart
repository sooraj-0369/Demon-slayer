import 'package:weaponverse/domain/entities/weapon.dart';

class SampleWeapons {
  static List<Weapon> get weapons => [
    Weapon(
      id: 'sample-1',
      name: 'Lunara Blade',
      description:
          'A luminous blade forged from celestial storms and moonlight essence. This weapon pulses with ethereal energy, capable of cutting through both physical and spiritual barriers.',
      imageUrl:
          'https://via.placeholder.com/400x300/1a1a2e/00d4ff?text=Lunara+Blade',
      rarity: WeaponRarity.epic,
      type: WeaponType.sword,
      powers: ['Lightning Strike', 'Soul Drain', 'Moonlight Slash'],
      stats: {'damage': 95, 'speed': 85, 'magic': 90, 'durability': 80},
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      isFavorite: true,
    ),

    Weapon(
      id: 'sample-2',
      name: 'Stormforged Axe',
      description:
          'Forged in the heart of a thunderstorm, this massive axe crackles with raw electrical energy. Each swing creates shockwaves that can topple mountains.',
      imageUrl:
          'https://via.placeholder.com/400x300/16213e/ff6b6b?text=Stormforged+Axe',
      rarity: WeaponRarity.legendary,
      type: WeaponType.axe,
      powers: ['Thunder Strike', 'Earth Tremor', 'Lightning Storm'],
      stats: {'damage': 100, 'speed': 60, 'magic': 85, 'durability': 95},
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      isFavorite: false,
    ),

    Weapon(
      id: 'sample-3',
      name: 'Shadowstrike Dagger',
      description:
          'A blade that exists between dimensions, this dagger can phase through armor and strike at the very soul of its target.',
      imageUrl:
          'https://via.placeholder.com/400x300/0f3460/00d4ff?text=Shadowstrike+Dagger',
      rarity: WeaponRarity.rare,
      type: WeaponType.dagger,
      powers: ['Shadow Step', 'Soul Drain', 'Phase Strike'],
      stats: {'damage': 75, 'speed': 100, 'magic': 80, 'durability': 65},
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      isFavorite: true,
    ),

    Weapon(
      id: 'sample-4',
      name: 'Phoenix Staff',
      description:
          'A staff crowned with a phoenix feather that burns with eternal flames. It can resurrect fallen allies and incinerate enemies with divine fire.',
      imageUrl:
          'https://via.placeholder.com/400x300/533a7b/ff6b6b?text=Phoenix+Staff',
      rarity: WeaponRarity.mythic,
      type: WeaponType.staff,
      powers: ['Fire Blast', 'Healing Light', 'Phoenix Resurrection'],
      stats: {'damage': 85, 'speed': 70, 'magic': 100, 'durability': 90},
      createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      isFavorite: false,
    ),

    Weapon(
      id: 'sample-5',
      name: 'Voidreaver Gun',
      description:
          'A futuristic weapon that fires bolts of pure void energy. Each shot tears through reality itself, leaving temporary rifts in spacetime.',
      imageUrl:
          'https://via.placeholder.com/400x300/1a1a2e/8000ff?text=Voidreaver+Gun',
      rarity: WeaponRarity.epic,
      type: WeaponType.gun,
      powers: ['Void Blast', 'Time Freeze', 'Reality Rift'],
      stats: {'damage': 90, 'speed': 95, 'magic': 95, 'durability': 75},
      createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
      isFavorite: true,
    ),
  ];
}



