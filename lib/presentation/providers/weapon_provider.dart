import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/weapon.dart';
import '../../domain/repositories/weapon_repository.dart';
import '../../data/repositories/weapon_repository_impl.dart';

part 'weapon_provider.g.dart';

// Repository provider
@riverpod
WeaponRepository weaponRepository(WeaponRepositoryRef ref) {
  return WeaponRepositoryImpl();
}

// Weapons list provider
@riverpod
class WeaponsNotifier extends _$WeaponsNotifier {
  @override
  Future<List<Weapon>> build() async {
    final repository = ref.read(weaponRepositoryProvider);
    return repository.getAllWeapons();
  }

  Future<void> refreshWeapons() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(weaponRepositoryProvider);
      return repository.getAllWeapons();
    });
  }

  Future<void> addWeapon(Weapon weapon) async {
    final repository = ref.read(weaponRepositoryProvider);
    await repository.saveWeapon(weapon);
    await refreshWeapons();
  }

  Future<void> updateWeapon(Weapon weapon) async {
    final repository = ref.read(weaponRepositoryProvider);
    await repository.updateWeapon(weapon);
    await refreshWeapons();
  }

  Future<void> deleteWeapon(String id) async {
    final repository = ref.read(weaponRepositoryProvider);
    await repository.deleteWeapon(id);
    await refreshWeapons();
  }

  Future<void> toggleFavorite(String id) async {
    final repository = ref.read(weaponRepositoryProvider);
    await repository.toggleFavorite(id);
    await refreshWeapons();
  }
}

// Weapon generation provider
@riverpod
class WeaponGenerationNotifier extends _$WeaponGenerationNotifier {
  @override
  AsyncValue<Weapon?> build() {
    return const AsyncValue.data(null);
  }

  Future<void> generateWeapon({
    required String description,
    List<String>? powers,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(weaponRepositoryProvider);
      return repository.generateWeapon(
        description: description,
        powers: powers,
      );
    });
    print(state.value);
  }

  Future<void> regenerateDescription(Weapon weapon) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(weaponRepositoryProvider);
      final newDescription = await repository.regenerateDescription(weapon);

      return weapon.copyWith(description: newDescription);
    });
  }

  Future<void> regenerateImage(Weapon weapon) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(weaponRepositoryProvider);
      final newImageUrl = await repository.regenerateImage(weapon);

      return weapon.copyWith(imageUrl: newImageUrl);
    });
  }

  void clearGeneratedWeapon() {
    state = const AsyncValue.data(null);
  }
}

// Favorite weapons provider
@riverpod
Future<List<Weapon>> favoriteWeapons(FavoriteWeaponsRef ref) async {
  final repository = ref.read(weaponRepositoryProvider);
  return repository.getFavoriteWeapons();
}

// Weapons by rarity provider
@riverpod
Future<List<Weapon>> weaponsByRarity(
  WeaponsByRarityRef ref,
  WeaponRarity rarity,
) async {
  final repository = ref.read(weaponRepositoryProvider);
  return repository.getWeaponsByRarity(rarity);
}

// Weapons by type provider
@riverpod
Future<List<Weapon>> weaponsByType(
  WeaponsByTypeRef ref,
  WeaponType type,
) async {
  final repository = ref.read(weaponRepositoryProvider);
  return repository.getWeaponsByType(type);
}

// Single weapon provider
@riverpod
Future<Weapon?> weaponById(WeaponByIdRef ref, String id) async {
  final repository = ref.read(weaponRepositoryProvider);
  return repository.getWeaponById(id);
}
