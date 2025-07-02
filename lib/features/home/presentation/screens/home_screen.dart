import 'package:flutter/material.dart';
import '../../data/models/table_model.dart';
import '../widgets/bottom_sheet_widget.dart';
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
      TableModel(number: 1, seats: 4, status: TableStatus.available),
      TableModel(number: 2, seats: 2, status: TableStatus.available, customerName: "John Doe"),
      TableModel(number: 3, seats: 6, status: TableStatus.reserved, customerName: "Alice Smith", reservationTime: DateTime.now().add(Duration(hours: 1))),
      TableModel(number: 4, seats: 4, status: TableStatus.cleaning),
      TableModel(number: 5, seats: 8, status: TableStatus.available),
      TableModel(number: 6, seats: 2, status: TableStatus.occupied, customerName: "Bob Wilson"),
      TableModel(number: 7, seats: 4, status: TableStatus.available),
      TableModel(number: 8, seats: 6, status: TableStatus.reserved, customerName: "Emma Brown", reservationTime: DateTime.now().add(Duration(minutes: 30))),
      TableModel(number: 9, seats: 4, status: TableStatus.available),
      TableModel(number: 10, seats: 2, status: TableStatus.cleaning),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            HeaderWidget(),
            SizedBox(height: 20),
            RestaurantStats(tables: tables),
            SizedBox(height: 20),
            Expanded(
              child: TablesGrid(
                tables: tables,
                onTableTap: (table) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => TableDetailsBottomSheet(
                      table: table,
                      onCleaned: () {
                        setState(() {});
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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
