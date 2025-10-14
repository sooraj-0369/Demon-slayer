import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants.dart';
import '../../presentation/providers/theme_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _apiKeyController = TextEditingController();
  bool _isDarkMode = true;
  bool _isNeonMode = true;

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeProvider);
    _isDarkMode = themeState.isDarkMode;
    _isNeonMode = themeState.isNeonMode;
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.settings)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Theme Settings
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Appearance',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),

                  // Dark Mode Toggle
                  SwitchListTile(
                    title: const Text(AppStrings.darkTheme),
                    subtitle: const Text(
                      'Use dark theme for better visibility',
                    ),
                    value: _isDarkMode,
                    onChanged: (value) {
                      ref.read(themeProvider.notifier).setDarkMode(value);
                    },
                    secondary: const Icon(Icons.dark_mode),
                  ),

                  // Neon Mode Toggle
                  SwitchListTile(
                    title: const Text(AppStrings.neonTheme),
                    subtitle: const Text('Enable neon glow effects'),
                    value: _isNeonMode,
                    onChanged: (value) {
                      ref.read(themeProvider.notifier).setNeonMode(value);
                    },
                    secondary: const Icon(Icons.auto_awesome),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // API Settings
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'API Configuration',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    controller: _apiKeyController,
                    decoration: const InputDecoration(
                      labelText: AppStrings.apiKey,
                      hintText: 'Enter your OpenAI API key',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.key),
                    ),
                    obscureText: true,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Your API key is stored locally and never shared.',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Save API key
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('API key saved successfully!'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Save API Key'),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // App Info
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'App Information',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),

                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('Version'),
                    subtitle: const Text('1.0.0'),
                  ),

                  ListTile(
                    leading: const Icon(Icons.description),
                    title: const Text('About'),
                    subtitle: const Text(
                      'AI Weapon Forge - Generate futuristic weapons with AI',
                    ),
                  ),

                  ListTile(
                    leading: const Icon(Icons.code),
                    title: const Text('Made with'),
                    subtitle: const Text('Flutter & OpenAI GPT'),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Actions
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Actions',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),

                  ListTile(
                    leading: const Icon(Icons.refresh),
                    title: const Text('Reset All Data'),
                    subtitle: const Text('Clear all weapons and settings'),
                    onTap: () {
                      _showResetDialog(context);
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.folder_open),
                    title: const Text('Export Data'),
                    subtitle: const Text('Export your weapons collection'),
                    onTap: () {
                      // TODO: Implement export functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Export functionality coming soon!'),
                        ),
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.download),
                    title: const Text('Import Data'),
                    subtitle: const Text('Import weapons from file'),
                    onTap: () {
                      // TODO: Implement import functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Import functionality coming soon!'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset All Data'),
        content: const Text(
          'This will permanently delete all your weapons and reset all settings. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement reset functionality
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All data has been reset')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}




