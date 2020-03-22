import 'package:flutter/foundation.dart';

class User {
  final int id;
  final String name;
  final int timestamp;

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnTimestamp = 'timestamp';

  const User({
    @required this.id,
    @required this.name,
    @required this.timestamp,
  }) : assert(name != null);

  @override
  String toString() => "User (id:$id, name:$name timestamp:$timestamp)";

  // TODO: check only name
  @override
  bool operator ==(other) =>
      other is User && other.id == this.id && other.name == this.name;
}
