import 'package:flutter/material.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:goaltogether/providers/RecordTableHandler.dart';
import 'package:goaltogether/models/Record.dart';

import 'package:goaltogether/pages/UsersHabitPage.dart';
import 'package:goaltogether/pages/UsersWishPage.dart';
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
              UsersHabitPage(title: 'Welcome'),
              UsersWishPage(title: 'W'),
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
            text: "Habit",
            icon: Icon(Icons.av_timer),
          ),
          Tab(
            text: "Wish",
            icon: Icon(Icons.card_giftcard),
          ),
          Tab(
            text: "More",
            icon: Icon(Icons.more_horiz),
          ),
        ],
      )
    );
  }
}
