import 'package:flutter/material.dart';
import '../../data/models/table_model.dart';
import 'table_card.dart';

class TablesGrid extends StatelessWidget {
  final List<TableModel> tables;
  final Function(TableModel) onTableTap;

  const TablesGrid({super.key, required this.tables, required this.onTableTap});

  @override
  Widget build(BuildContext context) {
    final mediaQueryW = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Stollar joylashuvi',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: mediaQueryW >= 700 ? 3 : 2,
                childAspectRatio: 1.0,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: tables.length,
              itemBuilder: (context, index) {
                return TableCard(
                  table: tables[index],
                  onTap: () => onTableTap(tables[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
