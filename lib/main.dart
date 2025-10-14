import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/hive_setup.dart';
import 'ui/navigation/app_router.dart';
import 'ui/theme/app_theme.dart';
import 'presentation/providers/theme_provider.dart';
import 'data/sample_weapons.dart';
import 'data/repositories/weapon_repository_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await HiveSetup.init();

  // Add sample weapons if none exist
  final repository = WeaponRepositoryImpl();
  final existingWeapons = await repository.getAllWeapons();
  if (existingWeapons.isEmpty) {
    for (final weapon in SampleWeapons.weapons) {
      await repository.saveWeapon(weapon);
    }
  }

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final theme = AppTheme.theme(isDark: themeState.isDarkMode, neon: themeState.isNeonMode);
    final lightTheme = AppTheme.theme(isDark: false, neon: themeState.isNeonMode);

    return MaterialApp.router(
      title: 'Weaponverse',
      theme: lightTheme,
      darkTheme: theme,
      themeMode: themeState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
