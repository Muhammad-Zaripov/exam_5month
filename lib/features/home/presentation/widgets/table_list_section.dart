import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/table_bloc.dart';
import '../bloc/table_state.dart';
import 'state_widget.dart';
import 'table_grid.dart';

class TableListSection extends StatelessWidget {
  const TableListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TableBloc, TableState>(
      builder: (context, state) {
        if (state is TableLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is TableError) {
          return const Center(child: Text('Xatolik yuz berdi'));
        } else if (state is TableLoaded) {
          return Column(
            children: [
              RestaurantStats(tables: state.tables),
              const SizedBox(height: 20),
              Expanded(child: TablesGrid(tables: state.filteredTables)),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
