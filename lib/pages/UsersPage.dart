import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'package:goaltogether/models/User.dart';
import 'package:goaltogether/providers/UserTableHandler.dart';

import 'package:goaltogether/pages/HabitsPage.dart';

import 'package:goaltogether/res/colors.dart';
import 'package:goaltogether/components/UserCard.dart';

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
  final usersHandler = RecordTableHandler();
  List<User> _users = [];
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _refreshUsersList();
    return Scaffold(
        appBar: AppBar(
          title: Text("Users"),
        ),
        body: _buildUsersList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddUser();
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
        ));
  }

  Widget _buildUsersList() {
    print(_users);
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: _users.length,
      itemBuilder: (BuildContext context, int index) {
        final item = _users[index];
        var name = item.name;
        return Dismissible(
          background: Container(color: kShrinePink50),
          key: UniqueKey(),
          onDismissed: (direction) {
            setState(() {
              _delete(item.id);
              _users.removeAt(index);
            });

            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text("$item dismissed")));
          },
          child: RaisedButton(
            child: userCard(name),
            onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HabitsPage(user: name)),
                );
            }
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  void _refreshUsersList() async {
    var users = await usersHandler.queryAllUsers();

    if (!DeepCollectionEquality().equals(users, _users)) {
      setState(() {
        _users = users;
      });
    }
  }

  void _insert(String username) async {
    // row to insert
    final user = User(name: username);
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

  void _delete(int id) async {
    // Assuming that the number of rows is the id for the last row.
    final rowsDeleted = await usersHandler.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }

  void _showAddUser() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("New User"),
          content: new TextField(
            controller: _usernameController,
            decoration: InputDecoration(
//                filled: true,
              labelText: 'Username',
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                _usernameController.clear();
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Add"),
              onPressed: () {
                _insert(_usernameController.text);
                _refreshUsersList();
                _usernameController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
