import 'package:flutter/foundation.dart';

class Goal {
  final int id;
  final String habitName;
  final int value;
  final String user;
  final int timestamp;

  static final columnId = '_id';
  static final columnHabitName = 'habitName';
  static final columnValue = 'value';
  static final columnUser = 'user';
  static final columnTimestamp = 'timestamp';

  const Goal({
    @required this.id,
    @required this.habitName,
    @required this.value,
    @required this.user,
    @required this.timestamp,
  })  : assert(habitName != null),
        assert(value != null),
        assert(user != null);

  @override
  String toString() => "Record(id:$id, habitName:$habitName, value:$value, user:$user, timestamp:$timestamp)";
}
