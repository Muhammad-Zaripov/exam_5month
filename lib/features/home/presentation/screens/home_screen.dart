import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/table_bloc.dart';
import '../bloc/table_event.dart';
import '../widgets/draggable_button.dart';
import '../widgets/table_list_section.dart';
import '../widgets/header_widget.dart';

class RestaurantHomeScreen extends StatefulWidget {
  const RestaurantHomeScreen({super.key});

  @override
  State<RestaurantHomeScreen> createState() => _RestaurantHomeScreenState();
}

class _RestaurantHomeScreenState extends State<RestaurantHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TableBloc>().add(LoadTables());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Stack(
        children: [
          Column(
            children: [
              HeaderWidget(),
              const SizedBox(height: 20),
              const Expanded(child: TableListSection()),
            ],
          ),
          DraggableButton(),
        ],
      ),
    );
  }
}
