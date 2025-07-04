import 'package:exam_5month/features/home/presentation/screens/categoriesly.dart';
import 'package:flutter/material.dart';

class Categorybuttons extends StatelessWidget {
  final String name;
  final IconData icones;
  final Widget Function(void Function(List<FoodItem>)) bottonlinkes;
  final void Function(List<FoodItem>) onSelected;

  const Categorybuttons({
    super.key,
    required this.name,
    required this.icones,
    required this.bottonlinkes,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => bottonlinkes((selectedItems) async {
              Navigator.pop(context); 
              onSelected(selectedItems); 
            }),
          );
        },
        child: Column(
          children: [
            Icon(icones, color: const Color(0xFF2E9055), size: 30),
            const SizedBox(height: 4),
            Text(
              name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
