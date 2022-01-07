import '../../../../utils/services/local_storage_service/local_storage_service.dart';
import 'package:drift/drift.dart';

abstract class AuthLocalProviderInterface {
  /// Insert session to local storage
  Future insertSession(Insertable<Session> data);

  /// Update session in local storage
  Future updateSession(Insertable<Session> data);

  /// Delete session in local storage
  Future deleteSession(Insertable<Session> data);

  /// Get user session by user id in local storage
  Future getSessionById(String id);

  /// Get single active session or logged in in local storage
  Future<Session?> getActiveSession();

  /// Clear all session
  Future<void> clearSession();
}
