import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'package:goaltogether/models/Wish.dart';
import 'package:goaltogether/providers/WishTableHandler.dart';
import 'package:goaltogether/res/colors.dart';

import 'package:goaltogether/components/HabitCard.dart';

class WishesPage extends StatefulWidget {
  WishesPage({Key key, this.user}) : super(key: key);

  final String user;

  @override
  _WishesPageState createState() => _WishesPageState(user: this.user);
}


class _WishesPageState extends State<WishesPage> {
  _WishesPageState({this.user});

  final user;
  final wishesHandler = WishTableHandler();
  List<Wish> _wishes = [];
  final _wishController = TextEditingController();
  final _wishValueController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text("$user's wish pool"),),
        body: _buildWishesList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddWish();
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
        )
    );
  }

  Widget _buildWishesList() {

    print(_wishes);
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: _wishes.length,
      itemBuilder: (BuildContext context, int index) {
        final item = _wishes[index];
        var habitName = item.wishName;
        return Dismissible(
          background: Container(color: kShrinePink50),
          key: UniqueKey(),
          onDismissed: (direction) {
            setState(() {
              _delete(item.id);
              _wishes.removeAt(index);
            });

            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text("$item dismissed")));
          },
          child: RaisedButton(
              child: habitCard(habitName),
              onPressed: () {

              }
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  void _refreshWishesList() async {
    var habits = await wishesHandler.queryAllWishesByUser(this.user);
    print(habits);
    if (!DeepCollectionEquality().equals(habits, _wishes)) {
      setState(() {
        _wishes = habits;
      });
    }
  }

  void _insert(String habitName, String value) async {
    // row to insert
    final wish = Wish(
      wishName: habitName,
      targetValue: int.parse(value),
      user: this.user,
    );
    final id = await wishesHandler.insert(wish);
  }

  void _delete(int id) async {
    // Assuming that the number of rows is the id for the last row.
    final rowsDeleted = await wishesHandler.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }


  void _showAddWish() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("New Wish"),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new TextField(
                  controller: _wishController,
                  decoration: InputDecoration(
//                filled: true,
                    labelText: 'wish name',
                  ),
                ),
                new TextField(
                  controller: _wishValueController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
//                filled: true,
                    labelText: 'wish value',
                  ),
                ),
              ]
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                _wishController.clear();
                _wishValueController.clear();
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Add"),
              onPressed: () {
                _insert(_wishController.text, _wishValueController.text);
                _refreshWishesList();
                _wishController.clear();
                _wishValueController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}