// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weapon_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$weaponRepositoryHash() => r'f27c0d5dcd94f7c705286fa7d64d1357d29d01dd';

/// See also [weaponRepository].
@ProviderFor(weaponRepository)
final weaponRepositoryProvider = AutoDisposeProvider<WeaponRepository>.internal(
  weaponRepository,
  name: r'weaponRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$weaponRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WeaponRepositoryRef = AutoDisposeProviderRef<WeaponRepository>;
String _$favoriteWeaponsHash() => r'556dbc73b6100b6fa2cec68d5193d73395e93423';

/// See also [favoriteWeapons].
@ProviderFor(favoriteWeapons)
final favoriteWeaponsProvider =
    AutoDisposeFutureProvider<List<Weapon>>.internal(
  favoriteWeapons,
  name: r'favoriteWeaponsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoriteWeaponsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FavoriteWeaponsRef = AutoDisposeFutureProviderRef<List<Weapon>>;
String _$weaponsByRarityHash() => r'4dedba60febcf8ce6bc7b2fda929a85eec6772ac';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [weaponsByRarity].
@ProviderFor(weaponsByRarity)
const weaponsByRarityProvider = WeaponsByRarityFamily();

/// See also [weaponsByRarity].
class WeaponsByRarityFamily extends Family<AsyncValue<List<Weapon>>> {
  /// See also [weaponsByRarity].
  const WeaponsByRarityFamily();

  /// See also [weaponsByRarity].
  WeaponsByRarityProvider call(
    WeaponRarity rarity,
  ) {
    return WeaponsByRarityProvider(
      rarity,
    );
  }

  @override
  WeaponsByRarityProvider getProviderOverride(
    covariant WeaponsByRarityProvider provider,
  ) {
    return call(
      provider.rarity,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'weaponsByRarityProvider';
}

/// See also [weaponsByRarity].
class WeaponsByRarityProvider extends AutoDisposeFutureProvider<List<Weapon>> {
  /// See also [weaponsByRarity].
  WeaponsByRarityProvider(
    WeaponRarity rarity,
  ) : this._internal(
          (ref) => weaponsByRarity(
            ref as WeaponsByRarityRef,
            rarity,
          ),
          from: weaponsByRarityProvider,
          name: r'weaponsByRarityProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$weaponsByRarityHash,
          dependencies: WeaponsByRarityFamily._dependencies,
          allTransitiveDependencies:
              WeaponsByRarityFamily._allTransitiveDependencies,
          rarity: rarity,
        );

  WeaponsByRarityProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.rarity,
  }) : super.internal();

  final WeaponRarity rarity;

  @override
  Override overrideWith(
    FutureOr<List<Weapon>> Function(WeaponsByRarityRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WeaponsByRarityProvider._internal(
        (ref) => create(ref as WeaponsByRarityRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        rarity: rarity,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Weapon>> createElement() {
    return _WeaponsByRarityProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WeaponsByRarityProvider && other.rarity == rarity;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, rarity.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WeaponsByRarityRef on AutoDisposeFutureProviderRef<List<Weapon>> {
  /// The parameter `rarity` of this provider.
  WeaponRarity get rarity;
}

class _WeaponsByRarityProviderElement
    extends AutoDisposeFutureProviderElement<List<Weapon>>
    with WeaponsByRarityRef {
  _WeaponsByRarityProviderElement(super.provider);

  @override
  WeaponRarity get rarity => (origin as WeaponsByRarityProvider).rarity;
}

String _$weaponsByTypeHash() => r'9d26e656e7410480ef6da5c65b46d7e2f7ea94d0';

/// See also [weaponsByType].
@ProviderFor(weaponsByType)
const weaponsByTypeProvider = WeaponsByTypeFamily();

/// See also [weaponsByType].
class WeaponsByTypeFamily extends Family<AsyncValue<List<Weapon>>> {
  /// See also [weaponsByType].
  const WeaponsByTypeFamily();

  /// See also [weaponsByType].
  WeaponsByTypeProvider call(
    WeaponType type,
  ) {
    return WeaponsByTypeProvider(
      type,
    );
  }

  @override
  WeaponsByTypeProvider getProviderOverride(
    covariant WeaponsByTypeProvider provider,
  ) {
    return call(
      provider.type,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'weaponsByTypeProvider';
}

/// See also [weaponsByType].
class WeaponsByTypeProvider extends AutoDisposeFutureProvider<List<Weapon>> {
  /// See also [weaponsByType].
  WeaponsByTypeProvider(
    WeaponType type,
  ) : this._internal(
          (ref) => weaponsByType(
            ref as WeaponsByTypeRef,
            type,
          ),
          from: weaponsByTypeProvider,
          name: r'weaponsByTypeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$weaponsByTypeHash,
          dependencies: WeaponsByTypeFamily._dependencies,
          allTransitiveDependencies:
              WeaponsByTypeFamily._allTransitiveDependencies,
          type: type,
        );

  WeaponsByTypeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final WeaponType type;

  @override
  Override overrideWith(
    FutureOr<List<Weapon>> Function(WeaponsByTypeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WeaponsByTypeProvider._internal(
        (ref) => create(ref as WeaponsByTypeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Weapon>> createElement() {
    return _WeaponsByTypeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WeaponsByTypeProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WeaponsByTypeRef on AutoDisposeFutureProviderRef<List<Weapon>> {
  /// The parameter `type` of this provider.
  WeaponType get type;
}

class _WeaponsByTypeProviderElement
    extends AutoDisposeFutureProviderElement<List<Weapon>>
    with WeaponsByTypeRef {
  _WeaponsByTypeProviderElement(super.provider);

  @override
  WeaponType get type => (origin as WeaponsByTypeProvider).type;
}

String _$weaponByIdHash() => r'b7ee44ca1ad2272801e32492ebfa0f63a304fbbf';

/// See also [weaponById].
@ProviderFor(weaponById)
const weaponByIdProvider = WeaponByIdFamily();

/// See also [weaponById].
class WeaponByIdFamily extends Family<AsyncValue<Weapon?>> {
  /// See also [weaponById].
  const WeaponByIdFamily();

  /// See also [weaponById].
  WeaponByIdProvider call(
    String id,
  ) {
    return WeaponByIdProvider(
      id,
    );
  }

  @override
  WeaponByIdProvider getProviderOverride(
    covariant WeaponByIdProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'weaponByIdProvider';
}

/// See also [weaponById].
class WeaponByIdProvider extends AutoDisposeFutureProvider<Weapon?> {
  /// See also [weaponById].
  WeaponByIdProvider(
    String id,
  ) : this._internal(
          (ref) => weaponById(
            ref as WeaponByIdRef,
            id,
          ),
          from: weaponByIdProvider,
          name: r'weaponByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$weaponByIdHash,
          dependencies: WeaponByIdFamily._dependencies,
          allTransitiveDependencies:
              WeaponByIdFamily._allTransitiveDependencies,
          id: id,
        );

  WeaponByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<Weapon?> Function(WeaponByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WeaponByIdProvider._internal(
        (ref) => create(ref as WeaponByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Weapon?> createElement() {
    return _WeaponByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WeaponByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WeaponByIdRef on AutoDisposeFutureProviderRef<Weapon?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _WeaponByIdProviderElement
    extends AutoDisposeFutureProviderElement<Weapon?> with WeaponByIdRef {
  _WeaponByIdProviderElement(super.provider);

  @override
  String get id => (origin as WeaponByIdProvider).id;
}

String _$weaponsNotifierHash() => r'f3997d37866e988cacc471d029acae0b6bea1190';

/// See also [WeaponsNotifier].
@ProviderFor(WeaponsNotifier)
final weaponsNotifierProvider =
    AutoDisposeAsyncNotifierProvider<WeaponsNotifier, List<Weapon>>.internal(
  WeaponsNotifier.new,
  name: r'weaponsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$weaponsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WeaponsNotifier = AutoDisposeAsyncNotifier<List<Weapon>>;
String _$weaponGenerationNotifierHash() =>
    r'161807ac9fecbabac15aab23dc3f84d3e672a65f';

/// See also [WeaponGenerationNotifier].
@ProviderFor(WeaponGenerationNotifier)
final weaponGenerationNotifierProvider = AutoDisposeNotifierProvider<
    WeaponGenerationNotifier, AsyncValue<Weapon?>>.internal(
  WeaponGenerationNotifier.new,
  name: r'weaponGenerationNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$weaponGenerationNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WeaponGenerationNotifier = AutoDisposeNotifier<AsyncValue<Weapon?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
