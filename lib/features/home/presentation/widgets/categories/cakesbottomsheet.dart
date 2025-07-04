import 'package:flutter/material.dart';
import 'package:exam_5month/features/home/presentation/screens/categoriesly.dart';
import 'package:exam_5month/features/home/presentation/widgets/foodsbuttons.dart';
import 'package:firebase_database/firebase_database.dart';

class Cakesbottomsheet extends StatefulWidget {
  final void Function(List<FoodItem>) onSelected;
  const Cakesbottomsheet({super.key, required this.onSelected});

  @override
  State<Cakesbottomsheet> createState() => _CakesbottomsheetState();
}

class _CakesbottomsheetState extends State<Cakesbottomsheet> {
  final List<FoodItem> selected = [
    FoodItem(name: "Napoleon", quantity: 0),
    FoodItem(name: "Cheesecake", quantity: 0),
    FoodItem(name: "Tiramisu", quantity: 0),
    FoodItem(name: "Honey Cake", quantity: 0),
  ];

  final TextEditingController nameController = TextEditingController();
  final _dbRef = FirebaseDatabase.instance.ref(); 

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

  void addNewProduct() {
    final newName = nameController.text.trim();
    if (newName.isNotEmpty) {
      setState(() {
        selected.add(FoodItem(name: newName, quantity: 1));
      });
      nameController.clear();
    }
  }

  Future<void> submitToFirebase(List<FoodItem> items) async {
    final filtered = items.where((e) => e.quantity > 0).toList();
    for (var item in filtered) {
      await _dbRef.child("orders/cakes/${item.name}").set({
        'name': item.name,
        'quantity': item.quantity,
      });
    }
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
              "Shirinliklardan tanlang",
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
                    controller: nameController,
                    decoration: const InputDecoration(hintText: "Yangi shirinlik nomi"),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: addNewProduct,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () async {
                  final filtered = selected.where((e) => e.quantity > 0).toList();
                  widget.onSelected(filtered);
                  await submitToFirebase(filtered);
                  Navigator.pop(context);
                },
                child: const Text("Buyurtmani yuborish"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
