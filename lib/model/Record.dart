import 'package:flutter/foundation.dart';

class Record {
  const Record({
    @required this.id,
    @required this.habitName,
    @required this.value,
    @required this.user,
    @required this.timestamp,
  })  : assert(id != null),
        assert(habitName != null),
        assert(value != null),
        assert(user != null),
        assert(timestamp != null);

  final int id;
  final String habitName;
  final int value;
  final String user;
  final int timestamp;

  @override
  String toString() => "$value $habitName (by user:$user) done at $timestamp";
}
