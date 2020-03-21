import 'package:flutter/foundation.dart';

class Goal {
  const Goal({
    @required this.id,
    @required this.goalName,
    @required this.targetValue,
    @required this.user,
    @required this.timestamp,
  })  : assert(id != null),
        assert(goalName != null),
        assert(targetValue != null),
        assert(user != null),
        assert(timestamp != null);

  final int id;
  final String goalName;
  final int targetValue;
  final String user;
  final int timestamp;

  @override
  String toString() => "$goalName(by user:$user) with targetValue=$targetValue";
}
