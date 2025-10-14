import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weapon.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class Weapon {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final String description;
  
  @HiveField(3)
  final String imageUrl;
  
  @HiveField(4)
  final WeaponRarity rarity;
  
  @HiveField(5)
  final WeaponType type;
  
  @HiveField(6)
  final List<String> powers;
  
  @HiveField(7)
  final Map<String, int> stats;
  
  @HiveField(8)
  final DateTime createdAt;
  
  @HiveField(9)
  final bool isFavorite;

  Weapon({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rarity,
    required this.type,
    required this.powers,
    required this.stats,
    required this.createdAt,
    this.isFavorite = false,
  });

  factory Weapon.fromJson(Map<String, dynamic> json) => _$WeaponFromJson(json);
  Map<String, dynamic> toJson() => _$WeaponToJson(this);

  Weapon copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    WeaponRarity? rarity,
    WeaponType? type,
    List<String>? powers,
    Map<String, int>? stats,
    DateTime? createdAt,
    bool? isFavorite,
  }) {
    return Weapon(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      rarity: rarity ?? this.rarity,
      type: type ?? this.type,
      powers: powers ?? this.powers,
      stats: stats ?? this.stats,
      createdAt: createdAt ?? this.createdAt,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

@HiveType(typeId: 1)
enum WeaponRarity {
  @HiveField(0)
  @JsonValue('common')
  common,
  
  @HiveField(1)
  @JsonValue('uncommon')
  uncommon,
  
  @HiveField(2)
  @JsonValue('rare')
  rare,
  
  @HiveField(3)
  @JsonValue('epic')
  epic,
  
  @HiveField(4)
  @JsonValue('legendary')
  legendary,
  
  @HiveField(5)
  @JsonValue('mythic')
  mythic,
}

@HiveType(typeId: 2)
enum WeaponType {
  @HiveField(0)
  @JsonValue('sword')
  sword,
  
  @HiveField(1)
  @JsonValue('staff')
  staff,
  
  @HiveField(2)
  @JsonValue('bow')
  bow,
  
  @HiveField(3)
  @JsonValue('dagger')
  dagger,
  
  @HiveField(4)
  @JsonValue('axe')
  axe,
  
  @HiveField(5)
  @JsonValue('gun')
  gun,
  
  @HiveField(6)
  @JsonValue('shield')
  shield,
  
  @HiveField(7)
  @JsonValue('gauntlet')
  gauntlet,
}

extension WeaponRarityExtension on WeaponRarity {
  String get displayName {
    switch (this) {
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

  int get colorValue {
    switch (this) {
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
}

extension WeaponTypeExtension on WeaponType {
  String get displayName {
    switch (this) {
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