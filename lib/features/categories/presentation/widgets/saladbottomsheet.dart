import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../history/data/repositories/history_repository.dart';
import '../../data/models/food_item.dart';
import 'foodsbuttons.dart';

class Saladbottomsheet extends StatefulWidget {
  final void Function(List<FoodItem>) onSelected;
  const Saladbottomsheet({super.key, required this.onSelected});

  @override
  State<Saladbottomsheet> createState() => _SaladbottomsheetState();
}

class _SaladbottomsheetState extends State<Saladbottomsheet> {
  final List<FoodItem> selected = [
    FoodItem(name: "Olivye", quantity: 0),
    FoodItem(name: "Sezar", quantity: 0),
    FoodItem(name: "Vitamin", quantity: 0),
    FoodItem(name: "Tovuq salati", quantity: 0),
  ];

  final HistoryRepository historyRepository = HistoryRepository();
  final TextEditingController controller = TextEditingController();
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

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

  Future<void> saveToFirebase(List<FoodItem> items) async {
    final filtered = items.where((e) => e.quantity > 0).toList();
    for (var item in filtered) {
      await _dbRef.child("orders/salads/${item.name}").set({
        'name': item.name,
        'quantity': item.quantity,
      });
    }
  }

  void submitOrder() async {
    final filtered = selected.where((e) => e.quantity > 0).toList();
    widget.onSelected(filtered);
    await saveToFirebase(filtered);
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
            const Text(
              "Salat tanlang",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: selected
                  .map(
                    (item) => Foodsbuttons(
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
                      hintText: "Yangi salat nomi",
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
