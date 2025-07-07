import '../../../categories/data/models/food_item.dart';

class HistoryModel {
  final FoodItem food;

  HistoryModel({required this.food});

  Map<String, dynamic> toJson() => {'food': food.toJson()};

  factory HistoryModel.fromJson(Map<String, dynamic> json) =>
      HistoryModel(food: FoodItemFactory.fromJson(json['food']));
}
