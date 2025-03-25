import 'package:dio/dio.dart';
import 'package:musify_app/core/exceptions/app_exception.dart';
import 'package:musify_app/services/api/api_service.dart';
import 'package:musify_app/services/api/constants.dart';

class ApiServiceImpl implements ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    connectTimeout: ApiConstants.connectionTimeout,
    receiveTimeout: ApiConstants.receiveTimeout,
    responseType: ResponseType.json,
  ));

  @override
  Future<Map<String, dynamic>> get(String endpoint,
      {Map<String, String>? queryParams}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParams);
      return response.data;
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AppException.unexpected();
    }
  }

  @override
  Future<Map<String, dynamic>> post(String endpoint,
      {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    try {
      final response = await _dio.post(endpoint,
          data: body, options: Options(headers: headers));
      return response.data;
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AppException.unexpected();
    }
  }

  /// Handles Dio exceptions and converts them to AppException
  AppException _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return AppException.timeout();
      case DioExceptionType.badResponse:
        return AppException.notFound();
      case DioExceptionType.cancel:
        return AppException.unexpected();
      case DioExceptionType.connectionError:
        return AppException.networkError();
      default:
        return AppException.unexpected();
    }
  }
}
