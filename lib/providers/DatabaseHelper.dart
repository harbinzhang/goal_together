import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "GoalTogetherDatabase.db";
  static final _databaseVersion = 1;

  static final columnId = '_id';

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE habits (
                _id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                habitName TEXT NOT NULL,
                value INTEGER NOT NULL,
                user TEXT NOT NULL,
                timestamp INTEGER NOT NULL
              )
              ''');

    await db.execute('''
              CREATE TABLE goals (
                _id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                goalName TEXT NOT NULL,
                targetValue INTEGER NOT NULL,
                user TEXT NOT NULL,
                timestamp INTEGER NOT NULL
              )
              ''');

    await db.execute('''
              CREATE TABLE records (
                _id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                habitName TEXT NOT NULL,
                value INTEGER NOT NULL,
                user TEXT NOT NULL,
                timestamp INTEGER NOT NULL
              )
              ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount(String table) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(String table, int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
