import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/providers/weapon_provider.dart';
import '../../core/constants.dart';
import '../../core/weapon_colors.dart';

class GeneratorScreen extends ConsumerStatefulWidget {
  const GeneratorScreen({super.key});

  @override
  ConsumerState<GeneratorScreen> createState() => _GeneratorScreenState();
}

class _GeneratorScreenState extends ConsumerState<GeneratorScreen> {
  final _descriptionController = TextEditingController();
  final _selectedPowers = <String>{};

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final generationState = ref.watch(weaponGenerationNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.generate)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Description input
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Describe your weapon',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _descriptionController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: AppStrings.describeYourWeapon,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Powers selection
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.selectPowers,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: AppConstants.powerTypes.map((power) {
                        final isSelected = _selectedPowers.contains(power);
                        return FilterChip(
                          label: Text(power),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedPowers.add(power);
                              } else {
                                _selectedPowers.remove(power);
                              }
                            });
                          },
                          selectedColor: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.3),
                          checkmarkColor: Theme.of(context).colorScheme.primary,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Sample prompts
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sample Prompts',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Try these examples to get started:',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 12),
                    ...AppConstants.samplePrompts.take(3).map((prompt) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: InkWell(
                          onTap: () {
                            _descriptionController.text = prompt;
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              prompt,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Generate button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: _canGenerate() ? _generateWeapon : null,
                icon: const Icon(Icons.auto_awesome),
                label: const Text(AppStrings.forgeWeapon),
                style: ElevatedButton.styleFrom(fixedSize: Size(18, 18)),
              ),
            ),

            const SizedBox(height: 24),

            // Generation result
            if (generationState.hasValue && generationState.value != null) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Generated Weapon',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      _buildGeneratedWeaponPreview(
                        context,
                        generationState.value!,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                ref
                                    .read(
                                      weaponGenerationNotifierProvider.notifier,
                                    )
                                    .regenerateDescription(
                                      generationState.value!,
                                    );
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text('Regenerate Description'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                ref
                                    .read(
                                      weaponGenerationNotifierProvider.notifier,
                                    )
                                    .regenerateImage(generationState.value!);
                              },
                              icon: const Icon(Icons.image),
                              label: const Text('Regenerate Image'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            ref
                                .read(weaponsNotifierProvider.notifier)
                                .addWeapon(generationState.value!);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(AppStrings.weaponSaved),
                              ),
                            );
                          },
                          icon: const Icon(Icons.save),
                          label: const Text(AppStrings.addToArsenal),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  bool _canGenerate() {
    return _descriptionController.text.trim().isNotEmpty;
  }

  void _generateWeapon() {
    ref
        .read(weaponGenerationNotifierProvider.notifier)
        .generateWeapon(
          description: _descriptionController.text.trim(),
          powers: _selectedPowers.toList(),
        );
  }

  Widget _buildGeneratedWeaponPreview(BuildContext context, weapon) {
    return Column(
      children: [
        // Weapon image
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Color(
                WeaponColors.getRarityColor(weapon.rarity),
              ).withOpacity(0.5),
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: weapon.imageUrl.isNotEmpty
                ? Image.network(
                    weapon.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          size: 48,
                          color: Colors.white54,
                        ),
                      );
                    },
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

        const SizedBox(height: 12),

        // Weapon details
        Text(
          weapon.name,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Color(WeaponColors.getRarityColor(weapon.rarity)),
          ),
        ),

        const SizedBox(height: 4),

        Text(
          '${WeaponColors.getRarityDisplayName(weapon.rarity)} • ${WeaponColors.getTypeDisplayName(weapon.type)}',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
        ),

        const SizedBox(height: 8),

        Text(weapon.description, style: Theme.of(context).textTheme.bodyMedium),

        const SizedBox(height: 12),

        // Powers
      //   if (weapon.powers.isNotEmpty) ...[
      //     Wrap(
      //       spacing: 8,
      //       runSpacing: 4,
      //       children: weapon.powers.map((power) {
      //         return Chip(
      //           label: Text(power, style: const TextStyle(fontSize: 12)),
      //           backgroundColor: Theme.of(
      //             context,
      //           ).colorScheme.primary.withOpacity(0.2),
      //           labelStyle: TextStyle(
      //             color: Theme.of(context).colorScheme.primary,
      //           ),
      //         );
      //       }).toList(),
      //     ),
      //   ],
      ],
    );
  }
}
