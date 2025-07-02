import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/table_model.dart';

class TableRemoteDataSource {
  final String url =
      'https://restaurant-automatical-default-rtdb.asia-southeast1.firebasedatabase.app/table.json';

  Future<List<TableModel>> fetchTables() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final tables = data.values.map((e) => TableModel.fromJson(e)).toList();
      return List<TableModel>.from(tables);
    } else {
      throw Exception('Failed to load tables');
    }
  }
}
