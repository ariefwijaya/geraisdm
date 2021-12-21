import '../../../../env/env.dart';
import 'package:moor/moor_web.dart';

import '../local_storage_service.dart';

AppDatabase constructDb({bool logStatements = false}) {
  return AppDatabase(WebDatabase(Env.dbName, logStatements: logStatements));
}
