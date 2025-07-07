import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../categories/data/models/food_item.dart';
import '../model/history_model.dart';

class HistoryRepository {
  final _collection = FirebaseFirestore.instance.collection('history');

  Future<List<HistoryModel>> getHistory() async {
    final snapshot = await _collection.get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return HistoryModel(
        food: FoodItem(name: data['name'], quantity: data['quantity']),
      );
    }).toList();
  }

  Future<void> saveHistory(FoodItem item) async {
    final history = HistoryModel(food: item);
    await FirebaseFirestore.instance
        .collection('history')
        .add(history.toJson());
  }

  Future<void> addToHistory(FoodItem food) async {
    await _collection.add({'name': food.name, 'quantity': food.quantity});
  }
}
