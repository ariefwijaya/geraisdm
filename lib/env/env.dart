import 'package:envify/envify.dart';
part 'env.g.dart';

///Required Environment
///Available env params:
/// - `prod` for production
/// - `dev` for development
/// - `testing` for testing
const currentEnv = "prod";

@Envify(
    path: currentEnv == "prod"
        ? '.env.prod'
        : currentEnv == "dev"
            ? '.env.dev'
            : '.env.testing')
abstract class Env {
  static const String appName = _Env.appName;
  static const bool showLog = _Env.showLog;
  static const String baseUrl = _Env.baseUrl;
  static const String serverHostLookup = _Env.serverHostLookup;
  static const int apiConnectTimeout = _Env.apiConnectTimeout;
  static const int apiReceiveTimeout = _Env.apiReceiveTimeout;
  static const int defaultPaginationLimit = _Env.defaultPaginationLimit;
  static const String dbPasskey = _Env.dbPasskey;
  static const String dbName = _Env.dbName;
  static const String localizationUrl = _Env.localizationUrl;
}
