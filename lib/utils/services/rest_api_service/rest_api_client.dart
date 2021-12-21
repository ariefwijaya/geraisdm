import 'dart:developer';

import '../../../../config/injectable/injectable_core.dart';
import '../../../../core/app_setting.dart';
import '../../../../utils/services/rest_api_service/auth_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:dio_firebase_performance/dio_firebase_performance.dart';
import 'package:injectable/injectable.dart';

/// Class to define required instances and configurations
@module
abstract class RestApiClientModule {
  // You can register named preemptive types like follows
  @Named("BaseUrl")
  String get baseUrl => AppSetting.baseUrl;

  // url here will be injected
  @lazySingleton
  Dio dio(@Named('BaseUrl') String url) => Dio(BaseOptions(
      baseUrl: url,
      followRedirects: false,
      // will not throw errors when status is not 200
      validateStatus: (status) => status! < 500 && status != 401,
      connectTimeout: AppSetting.apiConnectTimeout,
      receiveTimeout: AppSetting.apiReceiveTimeout));
}

class RestApiClient {
  Future<void> addRequiredInterceptor(
      {Dio? dioInstance, AuthInterceptor? authInterceptorInstance}) async {
    // Display logs when access Restful API if set to true
    final Dio dio = dioInstance ?? getIt.get<Dio>();
    // final dir = await getApplicationDocumentsDirectory();
    dio.interceptors.addAll([
      cacheInterceptor(),
      firebasePerformanceInterceptor(),
      authInterceptorInstance ?? getIt.get<AuthInterceptor>(),
      if (AppSetting.showLog) logInterceptor(),
    ]);
  }

  DioCacheInterceptor cacheInterceptor() {
    return DioCacheInterceptor(
        options: CacheOptions(
            store: HiveCacheStore(null), // Required.
            // Default. Checks cache freshness, requests otherwise and caches response.
            hitCacheOnErrorExcept: [401, 403],
            // Very optional. Overrides any HTTP directive to delete entry past this duration.
            maxStale: const Duration(days: 7)));
  }

  LogInterceptor logInterceptor() {
    return LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) {
          log(obj.toString());
        });
  }

  DioFirebasePerformanceInterceptor firebasePerformanceInterceptor() {
    return DioFirebasePerformanceInterceptor();
  }
}
