import 'dart:io';

import '../../../../constant/error_codes.dart';
import '../../../../core/settings/models/api_error_model.dart';
import '../../../../utils/services/rest_api_service/rest_api_interface.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';

/// Class that handle access and process to Restful API
@LazySingleton(as: RestApiInterface)
class RestApiService implements RestApiInterface {
  // Setup Dio configurations
  final Dio dio;

  const RestApiService({required this.dio});

  @override
  Future<Response> get(String pathUrl,
      {Map<String, String?>? headers, Map<String, dynamic>? body}) async {
    try {
      final response = await dio.get(pathUrl,
          queryParameters: body, options: Options(headers: headers));
      return _handleResponse(response);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Response> post(String pathUrl,
      {Map<String, String?>? headers,
      Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.post(pathUrl,
          data: body,
          queryParameters: queryParameters,
          options: Options(headers: headers));
      return _handleResponse(response);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Response> delete(String pathUrl,
      {Map<String, String?>? headers,
      Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.delete(pathUrl,
          data: body,
          queryParameters: queryParameters,
          options: Options(headers: headers));
      return _handleResponse(response);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Response> put(String pathUrl,
      {Map<String, String?>? headers,
      Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.put(pathUrl,
          data: body,
          queryParameters: queryParameters,
          options: Options(headers: headers));
      return _handleResponse(response);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Response> patch(String pathUrl,
      {Map<String, String?>? headers,
      Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.patch(pathUrl,
          data: body,
          queryParameters: queryParameters,
          options: Options(headers: headers));
      return _handleResponse(response);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Response> uploadFiles(String pathUrl,
      {Map<String, String?>? headers,
      Map<String, dynamic>? queryParameters,
      FormData? body,
      Function(int, int)? onSendProgress}) async {
    return dio
        .post(pathUrl,
            data: body,
            queryParameters: queryParameters,
            onSendProgress: onSendProgress,
            options: Options(headers: headers))
        .then((Response response) {
      return _handleResponse(response);
    }).catchError((onError) => throw _handleError(onError as DioError));
  }

  /// Proces request to get statusCode from Rest API Response
  /// or else throw Error
  Response _handleResponse(Response response) {
    final int statusCode = response.statusCode!;
    if (statusCode == 200 ||
        statusCode == 304 ||
        statusCode == 201 ||
        statusCode == 202) {
      return response;
    } else if (response.data["error_code"] != null) {
      throw ApiErrorModel.fromJson(response.data as Map<String, dynamic>);
    } else if (statusCode == 401) {
      throw BackendErrors.unauthorized;
    } else if (statusCode == 400) {
      throw BackendErrors.badRequest;
    } else if (statusCode == 500) {
      throw BackendErrors.internalServerError;
    } else {
      throw BackendErrors.unknown.copyWith(
          statusCode: statusCode, message: response.data["message"] as String?);
    }
  }

  /// Process output from Expected Expetion in Catch(e,s)
  ApiErrorModel _handleError(DioError e) {
    if (e.type == DioErrorType.connectTimeout ||
        e.type == DioErrorType.receiveTimeout ||
        e.type == DioErrorType.sendTimeout) {
      return FrontendErrors.apiConnectionTimeout;
    }
    return BackendErrors.unknown
        .copyWith(statusCode: e.response?.statusCode, message: e.message);
  }

  @override
  Future<Response> uploadFile(String pathUrl,
      {Map<String, String?>? headers,
      Map<String, dynamic>? body,
      required File file,
      Function(int progress, int length)? onSendProgress}) async {
    final mimeType = lookupMimeType(file.path)!.split("/");

    Map<String, dynamic>? form = {};
    if (body != null) {
      form = body;
    }
    form["file"] = await MultipartFile.fromFile(file.path,
        filename: file.path, contentType: MediaType(mimeType[0], mimeType[1]));

    final formData = FormData.fromMap(form);
    return dio
        .post(pathUrl,
            data: formData,
            onSendProgress: onSendProgress,
            options: Options(headers: headers))
        .then((Response response) {
      return _handleResponse(response);
    }).catchError((onError) => throw _handleError(onError as DioError));
  }
}
