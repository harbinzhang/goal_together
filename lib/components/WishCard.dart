import 'package:flutter/material.dart';
import 'package:goaltogether/res/colors.dart';
import 'package:goaltogether/models/Wish.dart';

Card WishCard(Wish wish) => Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: kShrinePink300,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: makeListTile(wish),
      ),
    );

ListTile makeListTile(Wish wish) => ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    leading: Container(
      padding: EdgeInsets.only(right: 12.0),
      decoration: new BoxDecoration(
          border: new Border(
              right: new BorderSide(width: 1.0, color: Colors.white24))),
      child: Icon(Icons.autorenew, color: Colors.white),
    ),
    title: Text(
      wish.wishName,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

//    subtitle: Row(
//      children: <Widget>[
//        Icon(Icons.linear_scale, color: Colors.yellowAccent),
//        Text(" Intermediate", style: TextStyle(color: Colors.white))
//      ],
//    ),

    trailing: Text(wish.targetValue.toString()));
