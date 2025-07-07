import '../../domain/repositories/order_repository.dart';
import '../datasources/order_datasources.dart';
import '../models/food_item.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderDataSource dataSource;

  OrderRepositoryImpl(this.dataSource);

  @override
  Stream<List<FoodItem>> getOrders(String tableId) {
    return dataSource.getOrders(tableId);
  }

  @override
  Future<void> addItems(String tableId, String userId, List<FoodItem> items) {
    return dataSource.addItems(tableId, userId, items);
  }
}
