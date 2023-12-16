import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:patientpulse/backend/healthscore.dart';
import 'package:patientpulse/main.dart';

class DioExecutor {
  static final Dio dio = Dio();

  static initializeInterceptors() {
    final accessToken = gpc.read(bearerTokenProvider);
    dio.interceptors.clear(); //Clear Existing Interceptors
    //Logging Interceptor

    // dio.interceptors
    //     .add(LogInterceptor(requestBody: false, responseBody: true));
    // Authentication Interceptor

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          options.headers['Content-Type'] = 'application/json';
          return handler.next(options);
        },
      ),
    );
  }

  static Future<DEResponse> get({
    required String url,
  }) async {
    initializeInterceptors();
    final response = await dio.get(url);
    return await _exec(url: url, response: response);
  }

  static Future<DEResponse> post({
    required String url,
    required Map data,
  }) async {
    initializeInterceptors();
    final response = await dio.post(url, data: data);
    return await _exec(url: url, response: response);
  }

  static Future<DEResponse> delete({
    required String url,
  }) async {
    initializeInterceptors();
    final response = await dio.delete(url);
    return await _exec(url: url, response: response);
  }

  static Future<DEResponse> put({
    required String url,
    required Map data,
  }) async {
    initializeInterceptors();
    final response = await dio.put(url, data: data);
    return await _exec(url: url, response: response);
  }

  static Future<DEResponse> _exec({
    required String url,
    required Response response,
  }) async {
    try {
      if (response.statusCode == 200) {
        final resdata = response.data as Map;
        return (resdata, null);
      }
      return (
        null,
        {
          'error': 'status code was not 200',
          'statuscode': response.statusCode,
        }
      );
    } catch (error) {
      return (
        null,
        {
          'error': error,
          'statuscode': -1,
        }
      );
    }
  }
}

typedef DEResponse = (Map? data, Map? error);
