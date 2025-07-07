import 'package:flutter/material.dart';
import '../../data/models/food_item.dart';

abstract class OrderEvent {
  const OrderEvent();
}

class LoadedOrders extends OrderEvent {}

class AddItem extends OrderEvent {
  final List<FoodItem> items;
  final BuildContext context;

  const AddItem(this.items, this.context);
}
