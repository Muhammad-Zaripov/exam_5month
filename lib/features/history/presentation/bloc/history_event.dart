import '../../../categories/data/models/food_item.dart';

abstract class HistoryEvent {}

class LoadHistoryEvent extends HistoryEvent {}

class AddHistoryEvent extends HistoryEvent {
  final FoodItem foodItem;
  AddHistoryEvent(this.foodItem);
}
