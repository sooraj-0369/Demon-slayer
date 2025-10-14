import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/providers/cart_provider.dart';
import '../../presentation/providers/weapon_provider.dart';
import '../../data/models/weapon.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          if (cart.items.isNotEmpty)
            TextButton(
              onPressed: () => ref.read(cartProvider.notifier).clear(),
              child: const Text('Clear', style: TextStyle(color: Colors.red)),
            ),
        ],
      ),
      body: cart.items.isEmpty
          ? const _EmptyCart()
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: cart.items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = cart.items[index];
                final weaponAsync = ref.watch(weaponByIdProvider(item.weaponId));
                return weaponAsync.when(
                  data: (weapon) => weapon == null
                      ? const SizedBox.shrink()
                      : _CartRow(weapon: weapon, quantity: item.quantity),
                  loading: () => const ListTile(title: Text('Loading...')),
                  error: (e, _) => ListTile(title: Text('Error: $e')),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton.icon(
          onPressed: cart.items.isEmpty
              ? null
              : () {
                  ref.read(cartProvider.notifier).clear();
                  context.go('/order-success');
                },
          icon: const Icon(Icons.shopping_bag),
          label: Text('Checkout (${cart.totalQuantity})'),
        ),
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shopping_cart_outlined, size: 72, color: Colors.white54),
          const SizedBox(height: 12),
          Text('Your cart is empty', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => context.pop(),
            child: const Text('Continue browsing'),
          ),
        ],
      ),
    );
  }
}

class _CartRow extends ConsumerWidget {
  final Weapon weapon;
  final int quantity;
  const _CartRow({required this.weapon, required this.quantity});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 64,
                height: 64,
                child: weapon.imageUrl.isNotEmpty
                    ? Image.network(weapon.imageUrl, fit: BoxFit.cover)
                    : const Icon(Icons.auto_awesome, size: 32),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(weapon.name, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(weapon.description, maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70)),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () => ref.read(cartProvider.notifier).removeOne(weapon.id),
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text(quantity.toString()),
                IconButton(
                  onPressed: () => ref.read(cartProvider.notifier).add(weapon.id),
                  icon: const Icon(Icons.add_circle_outline),
                ),
                IconButton(
                  onPressed: () => ref.read(cartProvider.notifier).removeAllOf(weapon.id),
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


