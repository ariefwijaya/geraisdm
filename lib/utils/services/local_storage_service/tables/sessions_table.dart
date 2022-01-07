import 'package:drift/drift.dart';

/// Session table to keep user session and user apps configuration
class Sessions extends Table {
  /// User Id who has created this session and logged in
  TextColumn get userId => text()();
  TextColumn get token => text()();

  /// Push notification token, usually FCM Token
  TextColumn get deviceToken => text()();
  DateTimeColumn get createdDate =>
      dateTime().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get updatedDate => dateTime().nullable()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {userId};
}
