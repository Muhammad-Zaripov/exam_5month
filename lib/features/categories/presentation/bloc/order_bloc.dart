import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../data/models/food_item.dart';
import '../../domain/usecase/add_item.dart';
import '../../domain/usecase/load_orders.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final LoadOrders loadOrders;
  final AddItems addItems;
  final String? tableId;
  final String? userId;

  OrderBloc({
    required this.loadOrders,
    required this.addItems,
    this.tableId,
    this.userId,
  }) : super(OrderInitial()) {
    on<LoadedOrders>((event, emit) async {
      emit(OrderLoading());
      if (tableId != null) {
        await emit.forEach(
          loadOrders(tableId!),
          onData: (items) => OrderLoaded(items),
        );
      } else {
        emit(OrderLoaded([]));
      }
    });

    on<AddItem>((event, emit) async {
      if (state is OrderLoaded && tableId != null && userId != null) {
        final current = List<FoodItem>.from((state as OrderLoaded).items);
        for (var item in event.items) {
          final idx = current.indexWhere((e) => e.name == item.name);
          if (idx != -1) {
            current[idx].quantity += item.quantity;
          } else {
            current.add(item);
          }
        }
        await addItems(tableId!, userId!, event.items);
        emit(OrderLoaded(current));
      }
    });
  }
}
