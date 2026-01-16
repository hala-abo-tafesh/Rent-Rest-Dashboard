import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'base_url.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: '${BaseUrl.base_url}/api/',
        receiveDataWhenStatusError: true,
        responseType: ResponseType.json,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: const {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
        },
      ),
    );

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }

  static Map<String, dynamic> _headers({
    required String lang,
    String? token,
    bool isFormData = false,
  }) {
    return {
      'Accept': 'application/json',
      'lang': lang,
      if (!isFormData) 'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  /// GET (generic)
  static Future<T> getData<T>({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token, // pass RAW token only
  }) async {
    final response = await dio.get(
      url,
      queryParameters: query,
      options: Options(headers: _headers(lang: lang, token: token)),
    );
    return response.data as T;
  }

  /// POST (generic)
  static Future<T> postData<T>({
    required String url,
    Map<String, dynamic>? query,
    required dynamic data,
    String lang = 'en',
    String? token, // pass RAW token only
  }) async {
    final isForm = data is FormData;

    final response = await dio.post(
      url,
      queryParameters: query,
      data: data,
      options: Options(headers: _headers(lang: lang, token: token, isFormData: isForm)),
    );

    return response.data as T;
  }

  /// DELETE (generic)
  static Future<T> deleteData<T>({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token, // pass RAW token only
  }) async {
    final response = await dio.delete(
      url,
      queryParameters: query,
      options: Options(headers: _headers(lang: lang, token: token)),
    );
    return response.data as T;
  }
}
