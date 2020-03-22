import 'package:goaltogether/providers/DatabaseHelper.dart';
import 'package:goaltogether/models/Habit.dart';

class HabitTableHandler{
  final dbHelper = DatabaseHelper.instance;
  final table = 'habits';

  Future<int> insert(Habit habit) async {
    Map<String, dynamic> row = {
      Habit.columnHabitName : habit.habitName,
      Habit.columnValue : habit.value,
      Habit.columnUser : habit.user,
      Habit.columnTimestamp : DateTime.now().millisecondsSinceEpoch,
    };
    int res = await dbHelper.insert(table, row);
    return res;
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    final res = await dbHelper.queryAllRows(table);
    return res;
  }



  Future<List<Habit>> queryAllHabitsByUser(String username) async {
    final rows = await dbHelper.query(table,
        where: 'user=?',
        whereArgs: [username]
    );

    print(rows);
    final res = rows.map((row) => Habit(
        id:row[Habit.columnId],
        habitName: row[Habit.columnHabitName],
        value: row[Habit.columnValue],
        user: row[Habit.columnUser],
        timestamp: row[Habit.columnTimestamp]
    )).toList();

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