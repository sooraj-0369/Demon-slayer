import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/providers/weapon_provider.dart';
import '../../core/constants.dart';
import '../../data/models/weapon.dart';
import '../../core/weapon_colors.dart';
import '../../presentation/providers/cart_provider.dart';

class WeaponDetailScreen extends ConsumerWidget {
  final String weaponId;

  const WeaponDetailScreen({super.key, required this.weaponId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weaponAsync = ref.watch(weaponByIdProvider(weaponId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weapon Details'),
        actions: [
          if (weaponAsync.hasValue && weaponAsync.value != null)
            IconButton(
              icon: Icon(
                weaponAsync.value!.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: weaponAsync.value!.isFavorite ? Colors.red : null,
              ),
              onPressed: () {
                ref
                    .read(weaponsNotifierProvider.notifier)
                    .toggleFavorite(weaponAsync.value!.id);
              },
            ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Implement share functionality
            },
          ),
        ],
      ),
      body: weaponAsync.when(
        data: (weapon) {
          if (weapon == null) {
            return const Center(child: Text('Weapon not found'));
          }
          return _buildWeaponDetails(context, ref, weapon);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Error loading weapon',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.pop(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeaponDetails(
    BuildContext context,
    WidgetRef ref,
    Weapon weapon,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Image
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(
                    WeaponColors.getRarityColor(weapon.rarity),
                  ).withOpacity(0.3),
                  Color(
                    WeaponColors.getRarityColor(weapon.rarity),
                  ).withOpacity(0.1),
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children: [
                // Weapon Image
                Center(
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Color(
                          WeaponColors.getRarityColor(weapon.rarity),
                        ).withOpacity(0.5),
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(
                            WeaponColors.getRarityColor(weapon.rarity),
                          ).withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(17),
                      child: weapon.imageUrl.isNotEmpty
                          ? Image.network(
                              weapon.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 64,
                                    color: Colors.white54,
                                  ),
                                );
                              },
                            )
                          : const Center(
                              child: Icon(
                                Icons.auto_awesome,
                                size: 64,
                                color: Colors.white54,
                              ),
                            ),
                    ),
                  ),
                ),

                // Rarity Badge
                Positioned(
                  top: 20,
                  left: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Color(WeaponColors.getRarityColor(weapon.rarity)),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color(
                            WeaponColors.getRarityColor(weapon.rarity),
                          ).withOpacity(0.5),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Text(
                      WeaponColors.getRarityDisplayName(weapon.rarity),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Weapon Info
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and Type
                Text(
                  weapon.name,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: Color(WeaponColors.getRarityColor(weapon.rarity)),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  WeaponColors.getTypeDisplayName(weapon.type),
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: Colors.white70),
                ),

                const SizedBox(height: 16),

                // Description
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          weapon.description,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Powers
                if (weapon.powers.isNotEmpty) ...[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Powers',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: weapon.powers.map((power) {
                              return Chip(
                                label: Text(power),
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.2),
                                labelStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Stats
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Statistics',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        ...weapon.stats.entries.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    entry.key.toUpperCase(),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: LinearProgressIndicator(
                                    value: entry.value / 100,
                                    backgroundColor: Colors.white24,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      _getStatColor(entry.key),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                SizedBox(
                                  width: 40,
                                  child: Text(
                                    entry.value.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: _getStatColor(entry.key),
                                          fontWeight: FontWeight.bold,
                                        ),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ref
                              .read(weaponsNotifierProvider.notifier)
                              .toggleFavorite(weapon.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                weapon.isFavorite
                                    ? 'Removed from favorites'
                                    : 'Added to favorites',
                              ),
                            ),
                          );
                        },
                        icon: Icon(
                          weapon.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: weapon.isFavorite ? Colors.red : null,
                        ),
                        label: Text(
                          weapon.isFavorite
                              ? 'Remove from Favorites'
                              : 'Add to Favorites',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          ref.read(cartProvider.notifier).add(weapon.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Added to cart')),
                          );
                        },
                        icon: const Icon(Icons.add_shopping_cart),
                        label: const Text('Add to Cart'),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatColor(String statName) {
    switch (statName.toLowerCase()) {
      case 'damage':
        return Colors.red;
      case 'speed':
        return Colors.blue;
      case 'magic':
        return Colors.purple;
      case 'durability':
        return Colors.green;
      default:
        return Colors.orange;
    }
  }
}
