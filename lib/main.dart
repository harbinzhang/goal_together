import 'package:flutter/material.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:goaltogether/providers/RecordTableHandler.dart';
import 'package:goaltogether/models/Record.dart';

import 'package:goaltogether/pages/UsersPage.dart';
import 'package:goaltogether/pages/HabitsPage.dart';

void main() => runApp(TabBarDemo());

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: menu(),
          body: TabBarView(
            children: [
              UsersPage(title: 'Welcome'),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }

  Widget menu() {
    return Container(
//      color: Color(0xFF3F5AA6),
      child: TabBar(
        labelColor: Colors.blueGrey,
//        unselectedLabelColor: Colors.white70,
        indicatorSize: TabBarIndicatorSize.tab,
//        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Colors.blue,
        tabs: [
          Tab(
            text: "User",
            icon: Icon(Icons.supervised_user_circle),
          ),
          Tab(
            text: "Wish",
            icon: Icon(Icons.poll),
          ),
          Tab(
            text: "More",
            icon: Icon(Icons.settings),
          ),
        ],
      )
    );
  }
}
