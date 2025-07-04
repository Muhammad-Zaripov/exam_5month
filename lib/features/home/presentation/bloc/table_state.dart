import '../../data/models/table_model.dart';

abstract class TableState {}

class TableInitial extends TableState {}

class TableLoading extends TableState {}

class TableLoaded extends TableState {
  final List<TableModel> tables;
  final TableStatus? filter;

  TableLoaded(this.tables, {this.filter});

  List<TableModel> get filteredTables {
    if (filter == null) return tables;
    return tables.where((t) => t.status == filter).toList();
  }

  TableLoaded copyWith({List<TableModel>? tables, TableStatus? filter}) {
    return TableLoaded(tables ?? this.tables, filter: filter);
  }
}

class TableError extends TableState {
  final String message;
  TableError(this.message);
}
