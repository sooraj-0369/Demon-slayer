import 'package:flutter/material.dart';
import '../../data/models/weapon.dart';
import '../../core/weapon_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/providers/cart_provider.dart';

class WeaponCard extends ConsumerWidget {
  final Weapon weapon;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const WeaponCard({
    super.key,
    required this.weapon,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Weapon Image
            AspectRatio(
              aspectRatio: 16 / 11, // stabilize tile height to avoid pixel shifts
              child: Stack(
                children: [
                  Container(
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
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: ClipRRect(
                      child: weapon.imageUrl.isNotEmpty
                          ? Image.network(
                              weapon.imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 48,
                                    color: Colors.white54,
                                  ),
                                );
                              },
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const Center(child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2)));
                              },
                              cacheWidth: 512,
                              cacheHeight: 352,
                            )
                          : const Center(
                              child: Icon(
                                Icons.auto_awesome,
                                size: 48,
                                color: Colors.white54,
                              ),
                            ),
                    ),
                  ),

                  // Favorite button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: onFavoriteToggle,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          weapon.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: weapon.isFavorite ? Colors.red : Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        ref.read(cartProvider.notifier).add(weapon.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added to cart')),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.add_shopping_cart,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),

                  // Rarity badge
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Color(
                          WeaponColors.getRarityColor(weapon.rarity),
                        ).withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        WeaponColors.getRarityDisplayName(weapon.rarity),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Weapon Info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Weapon Name
                    Text(
                      weapon.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 4),

                    // Weapon Type
                    Text(
                      WeaponColors.getTypeDisplayName(weapon.type),
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                    ),

                    const SizedBox(height: 8),

                    // Stats
                    Row(
                        children: [
                          Expanded(
                            child: _buildStatItem(
                              context,
                              'DMG',
                              weapon.stats['damage'] ?? 0,
                              Colors.red,
                            ),
                          ),
                          Expanded(
                            child: _buildStatItem(
                              context,
                              'SPD',
                              weapon.stats['speed'] ?? 0,
                              Colors.blue,
                            ),
                          ),
                          Expanded(
                            child: _buildStatItem(
                              context,
                              'MGC',
                              weapon.stats['magic'] ?? 0,
                              Colors.purple,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    int value,
    Color color,
  ) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.white54, fontSize: 10),
        ),
        const SizedBox(height: 2),
        Text(
          value.toString(),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
