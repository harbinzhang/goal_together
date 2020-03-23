import 'package:goaltogether/providers/DatabaseHelper.dart';
import 'package:goaltogether/models/Wish.dart';

class WishTableHandler{
  final dbHelper = DatabaseHelper.instance;
  final table = 'wishes';

  Future<int> insert(Wish goal) async {
    Map<String, dynamic> row = {
      Wish.columnWishName : goal.wishName,
      Wish.columnTargetValue : goal.targetValue,
      Wish.columnUser : goal.user,
      Wish.columnTimestamp : DateTime.now().millisecondsSinceEpoch,
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

  Future<List<Wish>> queryAllWishesByUser(String username) async {
    final rows = await dbHelper.query(table,
        where: 'user=?',
        whereArgs: [username]
    );

    print(rows);
    final res = rows.map((row) => Wish(
        id:row[Wish.columnId],
        wishName: row[Wish.columnWishName],
        targetValue: row[Wish.columnTargetValue],
        user: row[Wish.columnUser],
        timestamp: row[Wish.columnTimestamp]
    )).toList();

    return res;
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