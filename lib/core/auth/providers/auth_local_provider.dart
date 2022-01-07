import '../../../../core/auth/providers/auth_local_provider_interface.dart';
import '../../../../utils/services/local_storage_service/local_storage_service.dart';
import '../../../../utils/services/local_storage_service/tables/sessions_table.dart';
import 'package:injectable/injectable.dart';
import 'package:drift/drift.dart';
part 'auth_local_provider.g.dart';

@Injectable(as: AuthLocalProviderInterface)
@DriftAccessor(tables: [Sessions])
class AuthLocalProvider extends DatabaseAccessor<AppDatabase>
    with _$AuthLocalProviderMixin
    implements AuthLocalProviderInterface {
  final AppDatabase db;
  AuthLocalProvider(this.db) : super(db);

  @override
  Future<int> deleteSession(Insertable<Session> session) =>
      delete(sessions).delete(session);

  @override
  Future<int> insertSession(Insertable<Session> session) =>
      into(sessions).insert(session);

  @override
  Future<bool> updateSession(Insertable<Session> session) =>
      update(sessions).replace(session);

  @override
  Future<Session?> getSessionById(String id) =>
      (select(sessions)..where((t) => t.userId.equals(id))).getSingleOrNull();

  @override
  Future<Session?> getActiveSession() {
    return (select(sessions)
          ..where((t) => t.active.equals(true))
          ..limit(1))
        .getSingleOrNull();
  }

  @override
  Future<void> clearSession() async {
    await delete(sessions).go();
  }
}
