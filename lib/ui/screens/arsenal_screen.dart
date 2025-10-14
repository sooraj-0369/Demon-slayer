import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../presentation/providers/weapon_provider.dart';
import '../../data/models/weapon.dart';
import '../widgets/weapon_card.dart';
import '../../core/constants.dart';

class ArsenalScreen extends ConsumerStatefulWidget {
  const ArsenalScreen({super.key});

  @override
  ConsumerState<ArsenalScreen> createState() => _ArsenalScreenState();
}

class _ArsenalScreenState extends ConsumerState<ArsenalScreen> {
  String _selectedFilter = 'All';
  String _selectedSort = 'Date';

  @override
  Widget build(BuildContext context) {
    final weaponsAsync = ref.watch(weaponsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.arsenal),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _selectedSort = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'Date', child: Text('Sort by Date')),
              const PopupMenuItem(value: 'Name', child: Text('Sort by Name')),
              const PopupMenuItem(
                value: 'Rarity',
                child: Text('Sort by Rarity'),
              ),
            ],
            child: const Icon(Icons.sort),
          ),
        ],
      ),
      body: weaponsAsync.when(
        data: (weapons) => _buildArsenalContent(weapons),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Error loading arsenal',
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
                  ref.read(weaponsNotifierProvider.notifier).refreshWeapons();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/generator'),
        icon: const Icon(Icons.add),
        label: const Text('Add Weapon'),
      ),
    );
  }

  Widget _buildArsenalContent(List<Weapon> weapons) {
    if (weapons.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined, size: 64, color: Colors.white54),
            const SizedBox(height: 16),
            Text(
              'Your arsenal is empty',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Start forging weapons to build your collection!',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => context.go('/generator'),
              icon: const Icon(Icons.auto_awesome),
              label: const Text(AppStrings.forgeWeapon),
            ),
          ],
        ),
      );
    }

    final filteredWeapons = _filterWeapons(weapons);
    final sortedWeapons = _sortWeapons(filteredWeapons);

    return Column(
      children: [
        // Filter chips
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildFilterChip('All', weapons.length),
              _buildFilterChip(
                'Swords',
                weapons.where((w) => w.type == WeaponType.sword).length,
              ),
              _buildFilterChip(
                'Staffs',
                weapons.where((w) => w.type == WeaponType.staff).length,
              ),
              _buildFilterChip(
                'Bows',
                weapons.where((w) => w.type == WeaponType.bow).length,
              ),
              _buildFilterChip(
                'Daggers',
                weapons.where((w) => w.type == WeaponType.dagger).length,
              ),
              _buildFilterChip(
                'Axes',
                weapons.where((w) => w.type == WeaponType.axe).length,
              ),
              _buildFilterChip(
                'Guns',
                weapons.where((w) => w.type == WeaponType.gun).length,
              ),
              _buildFilterChip(
                'Shields',
                weapons.where((w) => w.type == WeaponType.shield).length,
              ),
              _buildFilterChip(
                'Gauntlets',
                weapons.where((w) => w.type == WeaponType.gauntlet).length,
              ),
            ],
          ),
        ),

        // Weapons grid
        Expanded(
          child: AnimationLimiter(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: sortedWeapons.length,
              itemBuilder: (context, index) {
                final weapon = sortedWeapons[index];
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  columnCount: 2,
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                      child: WeaponCard(
                        weapon: weapon,
                        onTap: () => context.go('/weapon/${weapon.id}'),
                        onFavoriteToggle: () {
                          ref
                              .read(weaponsNotifierProvider.notifier)
                              .toggleFavorite(weapon.id);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, int count) {
    final isSelected = _selectedFilter == label;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text('$label ($count)'),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedFilter = selected ? label : 'All';
          });
        },
        selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        checkmarkColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  List<Weapon> _filterWeapons(List<Weapon> weapons) {
    if (_selectedFilter == 'All') return weapons;

    return weapons.where((weapon) {
      switch (_selectedFilter) {
        case 'Swords':
          return weapon.type == WeaponType.sword;
        case 'Staffs':
          return weapon.type == WeaponType.staff;
        case 'Bows':
          return weapon.type == WeaponType.bow;
        case 'Daggers':
          return weapon.type == WeaponType.dagger;
        case 'Axes':
          return weapon.type == WeaponType.axe;
        case 'Guns':
          return weapon.type == WeaponType.gun;
        case 'Shields':
          return weapon.type == WeaponType.shield;
        case 'Gauntlets':
          return weapon.type == WeaponType.gauntlet;
        default:
          return true;
      }
    }).toList();
  }

  List<Weapon> _sortWeapons(List<Weapon> weapons) {
    switch (_selectedSort) {
      case 'Name':
        weapons.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Rarity':
        weapons.sort((a, b) => b.rarity.index.compareTo(a.rarity.index));
        break;
      case 'Date':
      default:
        weapons.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
    }
    return weapons;
  }
}




