import 'package:flutter/material.dart';
import '../../data/models/table_model.dart';
import '../widgets/header_widget.dart';
import '../widgets/state_widget.dart';
import '../widgets/table_grid.dart';

class RestaurantHomeScreen extends StatefulWidget {
  const RestaurantHomeScreen({super.key});

  @override
  State<RestaurantHomeScreen> createState() => _RestaurantHomeScreenState();
}

class _RestaurantHomeScreenState extends State<RestaurantHomeScreen> {
  List<TableModel> tables = [];
  @override
  void initState() {
    super.initState();
    tables = [
      TableModel(seats: 10, status: TableStatus.available, tableNumber: 1),
      TableModel(seats: 10, status: TableStatus.cleaning, tableNumber: 2),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: Column(
        children: [
          HeaderWidget(),
          SizedBox(height: 20),
          RestaurantStats(tables: tables),
          SizedBox(height: 20),
          Expanded(
            child: TablesGrid(
              tables: tables,
              onTableTap: (table) {
                // showModalBottomSheet(
                //   context: context,
                //   isScrollControlled: true,
                //   backgroundColor: Colors.transparent,
                //   builder: (context) => TableDetailsBottomSheet(
                //     table: table,
                //     onCleaned: () {
                //       setState(() {});
                //     },
                //   ),
                // );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Color(0xFF2E9055),
        icon: Icon(Icons.add, color: Colors.white),
        label: Text(
          'Yangi stol qo\'shish',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
