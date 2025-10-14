import 'package:hive_flutter/hive_flutter.dart';
import '../data/models/weapon.dart';
import '../data/models/cart_item.dart';
import 'constants.dart';

class HiveSetup {
  static Future<void> init() async {
    await Hive.initFlutter();

    // Register adapters
    Hive.registerAdapter(WeaponAdapter());
    Hive.registerAdapter(WeaponRarityAdapter());
    Hive.registerAdapter(WeaponTypeAdapter());
    Hive.registerAdapter(CartItemAdapter());

    // Open boxes
    await Hive.openBox<Weapon>(AppConstants.weaponsBoxName);
    await Hive.openBox(AppConstants.settingsBoxName);
    await Hive.openBox<CartItem>(AppConstants.cartBoxName);
  }

  static Future<void> dispose() async {
    await Hive.close();
  }
}



