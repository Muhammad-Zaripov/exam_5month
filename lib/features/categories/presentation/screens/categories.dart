import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../widgets/cakesbottomsheet.dart';
import '../widgets/categorybuttons.dart';
import '../widgets/coffeebottomsheet.dart';
import '../widgets/drinkbottomsheet.dart';
import '../widgets/mainfoodsbottomsheet.dart';
import '../widgets/saladbottomsheet.dart';

class FoodItem {
  final String name;
  int quantity;

  FoodItem({required this.name, required this.quantity});
}

class Categoriesly extends StatefulWidget {
  const Categoriesly({super.key});

  @override
  State<Categoriesly> createState() => _CategorieslyState();
}

class _CategorieslyState extends State<Categoriesly> {
  final List<FoodItem> orderedItems = [];

  @override
  void initState() {
    super.initState();

    FirebaseDatabase.instance.ref('orders').onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      if (data != null) {
        final List<FoodItem> loadedItems = [];
        data.forEach((key, value) {
          loadedItems.add(
            FoodItem(name: value['name'], quantity: value['quantity']),
          );
        });
        setState(() {
          orderedItems.clear();
          orderedItems.addAll(loadedItems);
        });
      }
    });
  }

  void handleSelectedItems(List<FoodItem> items) {
    final database = FirebaseDatabase.instance.ref();

    setState(() {
      for (var item in items) {
        final index = orderedItems.indexWhere((e) => e.name == item.name);
        if (index != -1) {
          orderedItems[index].quantity += item.quantity;
        } else {
          orderedItems.add(FoodItem(name: item.name, quantity: item.quantity));
        }

        database.child('orders/${item.name}').set({
          'name': item.name,
          'quantity':
              orderedItems[index != -1 ? index : orderedItems.length - 1]
                  .quantity,
        });
      }
    });
  }

  void addNewItem() {
    final nameController = TextEditingController();
    final quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Yangi mahsulot qo'shish"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Mahsulot nomi'),
            ),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Miqdori'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final name = nameController.text.trim();
              final qty = int.tryParse(quantityController.text.trim()) ?? 0;
              if (name.isNotEmpty && qty > 0) {
                handleSelectedItems([FoodItem(name: name, quantity: qty)]);
              }
              Navigator.pop(context);
            },
            child: const Text("Qo'shish"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Kategoriyalar",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: addNewItem),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Buyurtma berilgan mahsulotlar:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  ...orderedItems
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text("${item.name} - ${item.quantity} ta"),
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            color: Colors.grey.shade100,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Categorybuttons(
                    name: "Qahvalar",
                    icones: Icons.local_cafe,
                    bottonlinkes: (onSelected) =>
                        Coffeebottomsheet(onSelected: onSelected),
                    onSelected: handleSelectedItems,
                  ),
                  const SizedBox(width: 10),
                  Categorybuttons(
                    name: "Salatlar",
                    icones: Icons.local_dining,
                    bottonlinkes: (onSelected) =>
                        Saladbottomsheet(onSelected: onSelected),
                    onSelected: handleSelectedItems,
                  ),
                  const SizedBox(width: 10),
                  Categorybuttons(
                    name: "Shirinliklar",
                    icones: Icons.cake,
                    bottonlinkes: (onSelected) =>
                        Cakesbottomsheet(onSelected: onSelected),
                    onSelected: handleSelectedItems,
                  ),
                  const SizedBox(width: 10),
                  Categorybuttons(
                    name: "Ichimliklar",
                    icones: Icons.local_drink,
                    bottonlinkes: (onSelected) =>
                        Drinkbottomsheet(onSelected: onSelected),
                    onSelected: handleSelectedItems,
                  ),
                  const SizedBox(width: 10),
                  Categorybuttons(
                    name: "Asosiy taomlar",
                    icones: Icons.restaurant_menu,
                    bottonlinkes: (onSelected) =>
                        Mainfoodsbottomsheet(onSelected: onSelected),
                    onSelected: handleSelectedItems,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
