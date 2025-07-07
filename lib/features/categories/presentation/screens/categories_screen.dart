import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/data/models/table_model.dart';
import '../../data/models/food_item.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import '../bloc/order_state.dart';
import '../widgets/category_bottom_row_widget.dart';

class CategorieslyScreen extends StatelessWidget {
  final TableModel selectedTable;
  const CategorieslyScreen({super.key,required this.selectedTable});

  @override
  Widget build(BuildContext context) {
     WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderBloc>().add(LoadedOrders());
    });
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        title: const Text(
          "Kategoriyalar",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                if (state is OrderLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                final items = state is OrderLoaded ? state.items : <FoodItem>[];
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  itemBuilder: (_, i) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text("${items[i].name} - ${items[i].quantity} ta"),
                  ),
                );
              },
            ),
          ),
          CategoryButtonsRow(
            onSelected: (items) {
              context.read<OrderBloc>().add(AddItem(items, context));
            }, selectedTable: selectedTable,
          ),
        ],
      ),
    );
  }
}
