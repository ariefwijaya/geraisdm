import 'dart:io';

import '../../../../env/env.dart';
import 'package:encrypted_moor/encrypted_moor.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart' as paths;

import '../local_storage_service.dart';

AppDatabase constructDb({bool logStatements = false}) {
  if (Platform.isIOS || Platform.isAndroid) {
    final executor = LazyDatabase(() async {
      final dataDir = await paths.getApplicationDocumentsDirectory();
      final dbFile = File(p.join(dataDir.path, Env.dbName));
      return EncryptedExecutor(
          path: dbFile.path,
          password: Env.dbPasskey,
          logStatements: logStatements);
    });
    return AppDatabase(executor);
  }
  if (Platform.isMacOS || Platform.isLinux) {
    final file = File(Env.dbName);
    return AppDatabase(EncryptedExecutor(
        path: file.path,
        password: Env.dbPasskey,
        logStatements: logStatements));
  }
  // if (Platform.isWindows) {
  //   final file = File('db.sqlite');
  //   return Database(VMDatabase(file, logStatements: logStatements));
  // }
  return AppDatabase(VmDatabase.memory(logStatements: logStatements));
}
