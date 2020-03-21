import 'package:goaltogether/providers/DatabaseHelper.dart';
import 'package:goaltogether/models/Record.dart';

class RecordTableHandler{
  final dbHelper = DatabaseHelper.instance;
  final table = 'records';

  Future<int> insert(Goal record) async {
    Map<String, dynamic> row = {
      Goal.columnHabitName : record.habitName,
      Goal.columnValue : record.value,
      Goal.columnUser : record.user,
      Goal.columnTimestamp : DateTime.now().millisecondsSinceEpoch,
    };
    int res = await dbHelper.insert(table, row);
    return res;
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    final res = await dbHelper.queryAllRows(table);
    return res;
  }

  Future<int> queryRowCount() async {
    return await dbHelper.queryRowCount(table);
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
//  Future<int> update(Map<String, dynamic> row) async {
//    return await dbHelper.update(table, row);
//  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    return await dbHelper.delete(table, id);
  }


}