import 'package:flutter/foundation.dart';

class Wish {
  final int id;
  final String wishName;
  final int targetValue;
  final String user;
  final int timestamp;

  static final columnId = '_id';
  static final columnWishName = 'wishName';
  static final columnTargetValue = 'targetValue';
  static final columnUser = 'user';
  static final columnTimestamp = 'timestamp';

  const Wish({
    @required this.id,
    @required this.wishName,
    @required this.targetValue,
    @required this.user,
    @required this.timestamp,
  })  : assert(wishName != null),
        assert(targetValue != null),
        assert(user != null);

  @override
  String toString() => "Wish(id:$id, wishName:$wishName, targetValue:$targetValue, user:$user, timestamp:$timestamp)";

  @override
  bool operator ==(other) =>
      other is Wish && other.id == this.id && other.wishName == this.wishName;
}
