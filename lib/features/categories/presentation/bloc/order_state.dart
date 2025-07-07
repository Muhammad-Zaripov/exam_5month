import '../../data/models/food_item.dart';

abstract class OrderState {
  const OrderState();
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<FoodItem> items;
  const OrderLoaded(this.items);
}
