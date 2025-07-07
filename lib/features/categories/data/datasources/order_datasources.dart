import 'package:firebase_database/firebase_database.dart';

import '../models/food_item.dart';

class OrderDataSource {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  Stream<List<FoodItem>> getOrders(String tableId) {
    return _database.child('table/$tableId/orders').onValue.map((snapshot) {
      final data = snapshot.snapshot.value as Map?;
      final items = <FoodItem>[];
      if (data != null) {
        final totals = <String, int>{};
        data.forEach((_, order) {
          final menuItems = order['menuItems'] as Map?;
          menuItems?.forEach((_, m) {
            final name = m['menu'];
            final qty = (m['quantity'] as num).toInt();
            totals[name] = (totals[name] ?? 0) + qty;
          });
        });
        totals.forEach(
          (name, qty) => items.add(FoodItem(name: name, quantity: qty)),
        );
      }
      return items;
    });
  }

  Future<void> addItems(
    String tableId,
    String userId,
    List<FoodItem> items,
  ) async {
    final orderId = DateTime.now().millisecondsSinceEpoch.toString();
    for (var item in items) {
      await _database.child('orders/${item.name}').set({
        'name': item.name,
        'quantity': item.quantity,
        'tableId': tableId,
        'user': userId,
      });
      if (tableId.isNotEmpty) {
        await _database.child('table/$tableId/orders/$orderId').set({
          'menuItems': {
            'item1': {'menu': item.name, 'quantity': item.quantity},
          },
          'time': DateTime.now().toIso8601String(),
          'totalPrice': 0,
          'user': userId,
        });
      }
    }
  }
}
