import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'package:goaltogether/models/Habit.dart';
import 'package:goaltogether/providers/HabitTableHandler.dart';


class HabitsPage extends StatefulWidget {
  HabitsPage({Key key, this.user}) : super(key: key);

  final String user;

  @override
  _HabitsPageState createState() => _HabitsPageState(user: this.user);
}


class _HabitsPageState extends State<HabitsPage> {
  _HabitsPageState({this.user});

  final user;
  final habitsHandler = HabitTableHandler();
  List<Habit> _habits = [];
  final _habitController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text("test"),),
        body: _buildHabitsList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddHabit();
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
        )
    );
  }

  Widget _buildHabitsList() {

    print(_habits);
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: _habits.length,
      itemBuilder: (BuildContext context, int index) {
        var habitName = _habits[index].habitName;
        return Container(
          child: Text('$habitName'),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  void _refreshHabitsList() async {
//    var habits = await habitsHandler.queryAllRows();
    var habits = await habitsHandler.queryAllHabitsByUser(this.user);
    print(habits);
    if (!DeepCollectionEquality().equals(habits, _habits)) {
      setState(() {
        _habits = habits;
      });
    }
  }

  void _insert(String habitName) async {
    // row to insert
    final habit = Habit(
      habitName: habitName,
      value: 1,
      user: this.user,
    );
    final id = await habitsHandler.insert(habit);
    print('inserted row id: $id');
  }


  void _showAddHabit() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("New Habit"),
          content: new TextField(
            controller: _habitController,
            decoration: InputDecoration(
//                filled: true,
              labelText: 'habit name',
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                _habitController.clear();
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Add"),
              onPressed: () {
                _insert(_habitController.text);
                _refreshHabitsList();
                _habitController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}