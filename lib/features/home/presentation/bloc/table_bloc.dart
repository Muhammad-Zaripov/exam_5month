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
  }
}
