import '../../../../env/env.dart';
import 'package:drift/web.dart';

import '../local_storage_service.dart';

AppDatabase constructDb({bool logStatements = false}) {
  return AppDatabase(WebDatabase(Env.dbName, logStatements: logStatements));
}
