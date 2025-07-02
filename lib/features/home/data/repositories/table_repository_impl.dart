import '../datasources/table_remote_datasource.dart';
import '../models/table_model.dart';

class TableRepository {
  final TableRemoteDataSource remote;

  TableRepository(this.remote);

  Future<List<TableModel>> getTables() => remote.fetchTables();
}
