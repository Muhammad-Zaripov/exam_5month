import '../../data/models/food_item.dart';
import '../repositories/order_repository.dart';

class LoadOrders {
  final OrderRepository repository;

  LoadOrders(this.repository);

  Stream<List<FoodItem>> call(String tableId) {
    return repository.getOrders(tableId);
  }
}
