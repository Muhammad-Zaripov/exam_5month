import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/table_repository_impl.dart';
import 'table_event.dart';
import 'table_state.dart';

class TableBloc extends Bloc<TableEvent, TableState> {
  final TableRepository repository;

  TableBloc(this.repository) : super(TableInitial()) {
    on<LoadTables>((event, emit) async {
      emit(TableLoading());
      try {
        final tables = await repository.getTables();
        emit(TableLoaded(tables));
      } catch (e) {
        emit(TableError(e.toString()));
      }
    });

    on<AddTable>((event, emit) async {
      try {
        await repository.addTable(event.table);
        final updatedTables = await repository.getTables();
        emit(TableLoaded(updatedTables));
      } catch (e) {
        emit(TableError(e.toString()));
      }
    });

    on<ChangeTableStatusEvent>((event, emit) async {
      try {
        final currentState = state;
        if (currentState is TableLoaded) {
          final updatedTable = event.table.copyWith(status: event.newStatus);
          await repository.updateTable(updatedTable);

          final updatedTables = currentState.tables.map((table) {
            return table.id == updatedTable.id ? updatedTable : table;
          }).toList();

          emit(TableLoaded(updatedTables));
        }
      } catch (e) {
        emit(TableError(e.toString()));
      }
    });
    on<FilterTablesByStatus>((event, emit) {
      final currentState = state;
      if (currentState is TableLoaded) {
        emit(currentState.copyWith(filter: event.status));
      }
    });
  }
}
