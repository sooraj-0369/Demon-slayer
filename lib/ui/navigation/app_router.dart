import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/splash_screen.dart';
import '../screens/home_screen.dart';
import '../screens/generator_screen.dart';
import '../screens/weapon_detail_screen.dart';
import '../screens/arsenal_screen.dart';
import '../screens/settings_screen.dart';
import '../widgets/main_navigation.dart';
import '../screens/cart_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String home = '/home';
  static const String generator = '/generator';
  static const String weaponDetail = '/weapon/:id';
  static const String arsenal = '/arsenal';
  static const String settings = '/settings';
  static const String cart = '/cart';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainNavigation(child: child),
        routes: [
          GoRoute(
            path: home,
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: generator,
            name: 'generator',
            builder: (context, state) => const GeneratorScreen(),
          ),
          GoRoute(
            path: weaponDetail,
            name: 'weapon-detail',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return WeaponDetailScreen(weaponId: id);
            },
          ),
          GoRoute(
            path: arsenal,
            name: 'arsenal',
            builder: (context, state) => const ArsenalScreen(),
          ),
          GoRoute(
            path: settings,
            name: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
          GoRoute(
            path: cart,
            name: 'cart',
            builder: (context, state) => const CartScreen(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'The page you are looking for does not exist.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}



