import '../datasources/table_remote_datasource.dart';
import '../models/table_model.dart';

class TableRepository {
  final TableRemoteDataSource remote;

  TableRepository(this.remote);

  Future<List<TableModel>> getTables() async {
    return remote.fetchTables();
  }

  Future<void> addTable(TableModel table) async {
    await remote.addTable(table);
  }

  Future<void> updateTable(TableModel table) async {
    await remote.updateTable(table);
  }
}
