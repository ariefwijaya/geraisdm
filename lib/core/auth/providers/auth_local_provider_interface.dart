import '../../../../utils/services/local_storage_service/local_storage_service.dart';
import 'package:moor/moor.dart';

abstract class AuthLocalProviderInterface {
  /// Stream all session data.
  /// Whenever changes happened it will be emitted to this sprint
  Stream<List<Session>> watchAllSession();

  /// Get all session data one time
  Future<List<Session>> getAllSession();

  /// Insert session to local storage
  Future insertSession(Insertable<Session> data);

  /// Update session in local storage
  Future updateSession(Insertable<Session> data);

  /// Delete session in local storage
  Future deleteSession(Insertable<Session> data);

  /// truncate session in local storage
  Future truncateSession();

  /// Get user session by user id in local storage
  Future getSessionById(int id);

  /// Get single active session or logged in in local storage
  Future<Session?> getActiveSession();
}
