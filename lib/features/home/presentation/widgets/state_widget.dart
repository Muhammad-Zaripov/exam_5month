import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/table_model.dart';
import '../bloc/table_bloc.dart';
import '../bloc/table_event.dart';
import '../bloc/table_state.dart';
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

    final currentFilter = context.select<TableBloc, TableStatus?>((bloc) {
      final state = bloc.state;
      return state is TableLoaded ? state.filter : null;
    });

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
              isSelected: currentFilter == TableStatus.available,
              onTap: () {
                context.read<TableBloc>().add(
                  FilterTablesByStatus(
                    currentFilter == TableStatus.available
                        ? null
                        : TableStatus.available,
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: StateCard(
              title: 'Band',
              count: occupied,
              color: Color(0xFFFF5722),
              icon: Icons.people,
              isSelected: currentFilter == TableStatus.occupied,
              onTap: () {
                context.read<TableBloc>().add(
                  FilterTablesByStatus(
                    currentFilter == TableStatus.occupied
                        ? null
                        : TableStatus.occupied,
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: StateCard(
              title: 'Bron',
              count: reserved,
              color: Color(0xFFFF9800),
              icon: Icons.schedule,
              isSelected: currentFilter == TableStatus.reserved,
              onTap: () {
                context.read<TableBloc>().add(
                  FilterTablesByStatus(
                    currentFilter == TableStatus.reserved
                        ? null
                        : TableStatus.reserved,
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: StateCard(
              title: 'Tozalash',
              count: cleaning,
              color: Color(0xFF9E9E9E),
              icon: Icons.cleaning_services,
              isSelected: currentFilter == TableStatus.cleaning,
              onTap: () {
                context.read<TableBloc>().add(
                  FilterTablesByStatus(
                    currentFilter == TableStatus.cleaning
                        ? null
                        : TableStatus.cleaning,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
