import 'package:flutter/material.dart';
import '../../../home/data/models/table_model.dart';
import '../../data/models/category_data.dart';
import '../../data/models/food_item.dart';
import 'universal_bottom_sheet_widget.dart';

class CategoryButtonsRow extends StatelessWidget {
  final TableModel selectedTable;
  final void Function(List<FoodItem>) onSelected;

  const CategoryButtonsRow({super.key, required this.onSelected, required this.selectedTable});

  void openCategoryBottomSheet(BuildContext context, CategoryData data) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => UniversalBottomSheet(
        title: "${data.name} tanlang",
        firebasePath: data.firebasePath,
        initialItems: data.initialItems,
        onSelected: onSelected, selectedTable: selectedTable,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<CategoryData> categories = [
      CategoryData(
        name: "Qahvalar",
        icon: Icons.local_cafe,
        firebasePath: "coffees",
        initialItems: ["Espresso", "Cappuccino", "Latte", "Americano"],
      ),
      CategoryData(
        name: "Salatlar",
        icon: Icons.local_dining,
        firebasePath: "salads",
        initialItems: ["Olivye", "Sezar", "Vitamin", "Tovuq salati"],
      ),
      CategoryData(
        name: "Shirinliklar",
        icon: Icons.cake,
        firebasePath: "cakes",
        initialItems: ["Napoleon", "Cheesecake", "Tiramisu", "Honey Cake"],
      ),
      CategoryData(
        name: "Ichimliklar",
        icon: Icons.local_drink,
        firebasePath: "drinks",
        initialItems: ["Pepsi", "Coca-Cola", "Fanta", "Sharbat"],
      ),
      CategoryData(
        name: "Asosiy taomlar",
        icon: Icons.restaurant_menu,
        firebasePath: "mainfoods",
        initialItems: ["Osh", "Lag'mon", "Shashlik", "Somsa"],
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.grey.shade100,
      child: SizedBox(
        height: 60,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (_, index) {
            final category = categories[index];
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ElevatedButton.icon(
                onPressed: () => openCategoryBottomSheet(context, category),
                icon: Icon(category.icon, size: 20),
                label: Text(category.name),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black87,
                  elevation: 2,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
