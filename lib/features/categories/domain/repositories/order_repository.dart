import '../../data/models/food_item.dart';

abstract class OrderRepository {
  Stream<List<FoodItem>> getOrders(String tableId);
  Future<void> addItems(String tableId, String userId, List<FoodItem> items);
}
