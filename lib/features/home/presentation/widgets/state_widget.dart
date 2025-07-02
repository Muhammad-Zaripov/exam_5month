import 'package:flutter/material.dart';
import '../../data/models/table_model.dart';
import 'state_card.dart';

class RestaurantStats extends StatelessWidget {
  final List<TableModel> tables;

  const RestaurantStats({super.key, required this.tables});
  @override
  Widget build(BuildContext context) {
    final available = tables
        .where((t) => t.status == TableStatus.available)
        .length;
    final occupied = tables
        .where((t) => t.status == TableStatus.occupied)
        .length;
    final reserved = tables
        .where((t) => t.status == TableStatus.reserved)
        .length;
    final cleaning = tables
        .where((t) => t.status == TableStatus.cleaning)
        .length;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: StateCard(
              title: 'Bo‘sh',
              count: available,
              color: Color(0xFF4CAF50),
              icon: Icons.check_circle,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: StateCard(
              title: 'Band',
              count: occupied,
              color: Color(0xFFFF5722),
              icon: Icons.people,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: StateCard(
              title: 'Zaxira',
              count: reserved,
              color: Color(0xFFFF9800),
              icon: Icons.schedule,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: StateCard(
              title: 'Tozalash',
              count: cleaning,
              color: Color(0xFF9E9E9E),
              icon: Icons.cleaning_services,
            ),
          ),
        ],
      ),
    );
  }
}
