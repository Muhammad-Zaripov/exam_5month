import '../../data/models/food_item.dart';
import '../repositories/order_repository.dart';

class AddItems {
  final OrderRepository repository;

  AddItems(this.repository);

  Future<void> call(String tableId, String userId, List<FoodItem> items) {
    return repository.addItems(tableId, userId, items);
  }
}
