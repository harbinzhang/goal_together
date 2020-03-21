import 'package:flutter/foundation.dart';

class Goal {
  final int id;
  final String goalName;
  final int targetValue;
  final String user;
  final int timestamp;

  static final columnId = '_id';
  static final columnGoalName = 'goalName';
  static final columnTargetValue = 'targetValue';
  static final columnUser = 'user';
  static final columnTimestamp = 'timestamp';

  const Goal({
    @required this.id,
    @required this.goalName,
    @required this.targetValue,
    @required this.user,
    @required this.timestamp,
  })  : assert(goalName != null),
        assert(targetValue != null),
        assert(user != null);

  @override
  String toString() => "$goalName(by user:$user) with targetValue=$targetValue";
}
