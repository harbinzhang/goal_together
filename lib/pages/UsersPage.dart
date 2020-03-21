import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'package:goaltogether/models/User.dart';
import 'package:goaltogether/providers/UserTableHandler.dart';

class UsersPage extends StatefulWidget {
  UsersPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  int _counter = 0;
  final usersHandler = RecordTableHandler();
  List<User> _users = [];

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    _refreshUsersList();
    return Scaffold(
      appBar: AppBar(title: Text("test"),),
      body: _buildUsersList(),
    );
  }

  Widget _buildUsersList() {

    print(_users);
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: _users.length,
      itemBuilder: (BuildContext context, int index) {
        var name = _users[index].name;
        return Container(
          child: Text('$name'),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

//    return Scaffold(
//      appBar: AppBar(
//        title: Text('sqflite'),
//      ),
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            RaisedButton(
//              child: Text('insert', style: TextStyle(fontSize: 20),),
//              onPressed: () {_insert();},
//            ),
//            RaisedButton(
//              child: Text('query', style: TextStyle(fontSize: 20),),
//              onPressed: () {_query();},
//            ),
//            RaisedButton(
//              child: Text('update', style: TextStyle(fontSize: 20),),
//              onPressed: () {_update();},
//            ),
//            RaisedButton(
//              child: Text('delete', style: TextStyle(fontSize: 20),),
//              onPressed: () {_delete();},
//            ),
//          ],
//        ),
//      ),
//    );
//  }

  void _refreshUsersList() async {
    var users = await usersHandler.queryAllUsers();

    if (!DeepCollectionEquality().equals(users, _users)) {
      setState(() {
        _users = users;
      });
    }

  }
  
  void _insert() async {
    // row to insert
    final user = User(name: 'haibin');
    final id = await usersHandler.insert(user);
    print('inserted row id: $id');
  }

  void _query() async {
    final allRows = await usersHandler.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  void _update() async {
    // row to update
//    Map<String, dynamic> row = {
//      DatabaseHelper.columnId   : 1,
//      DatabaseHelper.columnName : 'Mary',
//      DatabaseHelper.columnAge  : 32
//    };
//    final rowsAffected = await usersHandler.update(row);
//    print('updated $rowsAffected row(s)');
  }

  void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await usersHandler.queryRowCount();
    final rowsDeleted = await usersHandler.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }


}