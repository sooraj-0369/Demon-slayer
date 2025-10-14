import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/hive_setup.dart';
import 'ui/navigation/app_router.dart';
import 'ui/theme/app_theme.dart';
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

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Weaponverse',
      theme: AppTheme.darkTheme,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
