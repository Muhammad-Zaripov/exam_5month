import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/data/models/table_model.dart';
import '../../data/models/food_item.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import 'foodsbuttons.dart';

class UniversalBottomSheet extends StatefulWidget {
  final String title;
  final String firebasePath;
  final List<String> initialItems;
  final TableModel selectedTable;
  final void Function(List<FoodItem>) onSelected;

  const UniversalBottomSheet({
    super.key,
    required this.title,
    required this.firebasePath,
    required this.initialItems,
    required this.onSelected,
    required this.selectedTable,
  });

  @override
  State<UniversalBottomSheet> createState() => _UniversalBottomSheetState();
}

class _UniversalBottomSheetState extends State<UniversalBottomSheet> {
  late List<FoodItem> selected;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    selected = widget.initialItems
        .map((e) => FoodItem(name: e, quantity: 0))
        .toList();
  }

  void updateItem(String name, int qty) {
    final index = selected.indexWhere((e) => e.name == name);
    setState(() {
      if (index != -1) {
        selected[index].quantity = qty;
      } else {
        selected.add(FoodItem(name: name, quantity: qty));
      }
    });
  }

  void addNewItem() {
    final name = controller.text.trim();
    if (name.isNotEmpty) {
      setState(() {
        selected.add(FoodItem(name: name, quantity: 1));
      });
      controller.clear();
    }
  }


  void submitOrder() {
  final filtered = selected.where((e) => e.quantity > 0).toList();
  if (filtered.isEmpty) return;
  context.read<OrderBloc>().add(AddItem(filtered, context));

  Navigator.pop(context);
}


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: selected
                  .map(
                    (item) => FoodsButtons(
                      names: item.name,
                      initialNumber: item.quantity,
                      onChanged: updateItem,
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Yangi nom qo'shish",
                    ),
                  ),
                ),
                IconButton(onPressed: addNewItem, icon: const Icon(Icons.add)),
              ],
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: submitOrder,
                child: const Text("Buyurtmani yuborish"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
