import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../presentation/providers/weapon_provider.dart';
import '../../data/models/weapon.dart';
import '../widgets/weapon_card.dart';
import '../../core/constants.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final weaponsAsync = ref.watch(weaponsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(weaponsNotifierProvider.notifier).refreshWeapons();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab selector
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(
                AppConstants.buttonBorderRadius,
              ),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                _buildTab(0, 'All', Icons.grid_view),
                _buildTab(1, 'Favorites', Icons.favorite),
                _buildTab(2, 'My Arsenal', Icons.inventory_2),
              ],
            ),
          ),

          // Weapons grid
          Expanded(
            child: weaponsAsync.when(
              data: (weapons) => _buildWeaponsGrid(weapons),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error loading weapons',
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
                      onPressed: () {
                        ref
                            .read(weaponsNotifierProvider.notifier)
                            .refreshWeapons();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/generator'),
        icon: const Icon(Icons.auto_awesome),
        label: const Text(AppStrings.forgeWeapon),
      ),
    );
  }

  Widget _buildTab(int index, String label, IconData icon) {
    final isSelected = _selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(
              AppConstants.buttonBorderRadius,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white70,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.white70,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeaponsGrid(List<Weapon> weapons) {
    List<Weapon> filteredWeapons = weapons;

    switch (_selectedTab) {
      case 1:
        filteredWeapons = weapons.where((w) => w.isFavorite).toList();
        break;
      case 2:
        filteredWeapons = weapons.where((w) => weapons.contains(w)).toList();
        break;
    }

    if (filteredWeapons.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _selectedTab == 0
                  ? Icons.auto_awesome_outlined
                  : Icons.inventory_2_outlined,
              size: 64,
              color: Colors.white54,
            ),
            const SizedBox(height: 16),
            Text(
              _selectedTab == 0
                  ? AppStrings.noWeaponsFound
                  : 'No weapons in this category',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              _selectedTab == 0
                  ? AppStrings.startForging
                  : 'Try generating some weapons first!',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (_selectedTab == 0) ...[
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => context.go('/generator'),
                icon: const Icon(Icons.auto_awesome),
                label: const Text(AppStrings.forgeWeapon),
              ),
            ],
          ],
        ),
      );
    }

    return AnimationLimiter(
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: filteredWeapons.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 375),
            columnCount: 2,
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: WeaponCard(
                  weapon: filteredWeapons[index],
                  onTap: () =>
                      context.go('/weapon/${filteredWeapons[index].id}'),
                  onFavoriteToggle: () {
                    ref
                        .read(weaponsNotifierProvider.notifier)
                        .toggleFavorite(filteredWeapons[index].id);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}



