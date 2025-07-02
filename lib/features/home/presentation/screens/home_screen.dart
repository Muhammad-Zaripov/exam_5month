import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/table_model.dart';
import '../bloc/table_bloc.dart';
import '../bloc/table_state.dart';
import '../widgets/header_widget.dart';
import '../widgets/state_widget.dart';
import '../widgets/table_grid.dart';

class RestaurantHomeScreen extends StatefulWidget {
  const RestaurantHomeScreen({super.key});

  @override
  State<RestaurantHomeScreen> createState() => _RestaurantHomeScreenState();
}

class _RestaurantHomeScreenState extends State<RestaurantHomeScreen> {
  // List<TableModel> tables = [];
  @override
  void initState() {
    super.initState();
    // tables = [
    //   TableModel(seats: 10, status: TableStatus.available, tableNumber: 1),
    //   TableModel(seats: 10, status: TableStatus.cleaning, tableNumber: 2),
    // ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: Column(
        children: [
          HeaderWidget(),
          SizedBox(height: 20),
          // RestaurantStats(tables: tables),
          SizedBox(height: 20),
          BlocBuilder<TableBloc, TableState>(
            builder: (context, state) {
              if (state is TableLoading) {
                return Center(child: CircularProgressIndicator.adaptive());
              } else if (state is TableError) {
                return Text('Xatoli');
              } else if (state is TableLoaded) {
                return Expanded(child: TablesGrid(tables: state.tables));
              }
              return SizedBox.shrink();
            },
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
