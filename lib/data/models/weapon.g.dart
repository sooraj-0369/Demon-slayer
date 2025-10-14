// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weapon.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeaponAdapter extends TypeAdapter<Weapon> {
  @override
  final int typeId = 0;

  @override
  Weapon read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Weapon(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      imageUrl: fields[3] as String,
      rarity: fields[4] as WeaponRarity,
      type: fields[5] as WeaponType,
      powers: (fields[6] as List).cast<String>(),
      stats: (fields[7] as Map).cast<String, int>(),
      createdAt: fields[8] as DateTime,
      isFavorite: fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Weapon obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.rarity)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.powers)
      ..writeByte(7)
      ..write(obj.stats)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeaponAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WeaponRarityAdapter extends TypeAdapter<WeaponRarity> {
  @override
  final int typeId = 1;

  @override
  WeaponRarity read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return WeaponRarity.common;
      case 1:
        return WeaponRarity.uncommon;
      case 2:
        return WeaponRarity.rare;
      case 3:
        return WeaponRarity.epic;
      case 4:
        return WeaponRarity.legendary;
      case 5:
        return WeaponRarity.mythic;
      default:
        return WeaponRarity.common;
    }
  }

  @override
  void write(BinaryWriter writer, WeaponRarity obj) {
    switch (obj) {
      case WeaponRarity.common:
        writer.writeByte(0);
        break;
      case WeaponRarity.uncommon:
        writer.writeByte(1);
        break;
      case WeaponRarity.rare:
        writer.writeByte(2);
        break;
      case WeaponRarity.epic:
        writer.writeByte(3);
        break;
      case WeaponRarity.legendary:
        writer.writeByte(4);
        break;
      case WeaponRarity.mythic:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeaponRarityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WeaponTypeAdapter extends TypeAdapter<WeaponType> {
  @override
  final int typeId = 2;

  @override
  WeaponType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return WeaponType.sword;
      case 1:
        return WeaponType.staff;
      case 2:
        return WeaponType.bow;
      case 3:
        return WeaponType.dagger;
      case 4:
        return WeaponType.axe;
      case 5:
        return WeaponType.gun;
      case 6:
        return WeaponType.shield;
      case 7:
        return WeaponType.gauntlet;
      default:
        return WeaponType.sword;
    }
  }

  @override
  void write(BinaryWriter writer, WeaponType obj) {
    switch (obj) {
      case WeaponType.sword:
        writer.writeByte(0);
        break;
      case WeaponType.staff:
        writer.writeByte(1);
        break;
      case WeaponType.bow:
        writer.writeByte(2);
        break;
      case WeaponType.dagger:
        writer.writeByte(3);
        break;
      case WeaponType.axe:
        writer.writeByte(4);
        break;
      case WeaponType.gun:
        writer.writeByte(5);
        break;
      case WeaponType.shield:
        writer.writeByte(6);
        break;
      case WeaponType.gauntlet:
        writer.writeByte(7);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeaponTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weapon _$WeaponFromJson(Map<String, dynamic> json) => Weapon(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      rarity: $enumDecode(_$WeaponRarityEnumMap, json['rarity']),
      type: $enumDecode(_$WeaponTypeEnumMap, json['type']),
      powers:
          (json['powers'] as List<dynamic>).map((e) => e as String).toList(),
      stats: Map<String, int>.from(json['stats'] as Map),
      createdAt: DateTime.parse(json['createdAt'] as String),
      isFavorite: json['isFavorite'] as bool? ?? false,
    );

Map<String, dynamic> _$WeaponToJson(Weapon instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'rarity': _$WeaponRarityEnumMap[instance.rarity]!,
      'type': _$WeaponTypeEnumMap[instance.type]!,
      'powers': instance.powers,
      'stats': instance.stats,
      'createdAt': instance.createdAt.toIso8601String(),
      'isFavorite': instance.isFavorite,
    };

const _$WeaponRarityEnumMap = {
  WeaponRarity.common: 'common',
  WeaponRarity.uncommon: 'uncommon',
  WeaponRarity.rare: 'rare',
  WeaponRarity.epic: 'epic',
  WeaponRarity.legendary: 'legendary',
  WeaponRarity.mythic: 'mythic',
};

const _$WeaponTypeEnumMap = {
  WeaponType.sword: 'sword',
  WeaponType.staff: 'staff',
  WeaponType.bow: 'bow',
  WeaponType.dagger: 'dagger',
  WeaponType.axe: 'axe',
  WeaponType.gun: 'gun',
  WeaponType.shield: 'shield',
  WeaponType.gauntlet: 'gauntlet',
};
