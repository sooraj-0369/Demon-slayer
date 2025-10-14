import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../core/constants.dart';
import '../../data/models/cart_item.dart';

class CartState {
  final List<CartItem> items;
  const CartState(this.items);

  int get totalQuantity => items.fold(0, (sum, item) => sum + item.quantity);
}

class CartNotifier extends StateNotifier<CartState> {
  final Box<CartItem> _box;

  CartNotifier(this._box) : super(CartState(_box.values.toList()));

  void _sync() {
    state = CartState(_box.values.toList());
  }

  void add(String weaponId, {int quantity = 1}) {
    final existingKey = _box.keys.firstWhere(
      (key) => _box.get(key)!.weaponId == weaponId,
      orElse: () => null,
    );

    if (existingKey != null) {
      final existing = _box.get(existingKey)!;
      _box.put(existingKey, existing.copyWith(quantity: existing.quantity + quantity));
    } else {
      _box.add(CartItem(weaponId: weaponId, quantity: quantity));
    }
    _sync();
  }

  void removeOne(String weaponId) {
    final key = _box.keys.firstWhere(
      (k) => _box.get(k)!.weaponId == weaponId,
      orElse: () => null,
    );
    if (key == null) return;
    final existing = _box.get(key)!;
    if (existing.quantity <= 1) {
      _box.delete(key);
    } else {
      _box.put(key, existing.copyWith(quantity: existing.quantity - 1));
    }
    _sync();
  }

  void removeAllOf(String weaponId) {
    final key = _box.keys.firstWhere(
      (k) => _box.get(k)!.weaponId == weaponId,
      orElse: () => null,
    );
    if (key == null) return;
    _box.delete(key);
    _sync();
  }

  void clear() {
    _box.clear();
    _sync();
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  final box = Hive.box<CartItem>(AppConstants.cartBoxName);
  return CartNotifier(box);
});


