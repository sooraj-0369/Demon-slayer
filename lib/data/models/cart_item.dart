import 'package:hive/hive.dart';

class CartItem {
  final String weaponId;
  final int quantity;

  const CartItem({
    required this.weaponId,
    this.quantity = 1,
  });

  CartItem copyWith({String? weaponId, int? quantity}) {
    return CartItem(
      weaponId: weaponId ?? this.weaponId,
      quantity: quantity ?? this.quantity,
    );
  }
}

class CartItemAdapter extends TypeAdapter<CartItem> {
  @override
  final int typeId = 10;

  @override
  CartItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    String weaponId = '';
    int quantity = 1;
    for (int i = 0; i < numOfFields; i++) {
      final field = reader.readByte();
      switch (field) {
        case 0:
          weaponId = reader.readString();
          break;
        case 1:
          quantity = reader.readInt();
          break;
      }
    }
    return CartItem(weaponId: weaponId, quantity: quantity);
  }

  @override
  void write(BinaryWriter writer, CartItem obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..writeString(obj.weaponId)
      ..writeByte(1)
      ..writeInt(obj.quantity);
  }
}


