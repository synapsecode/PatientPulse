import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:patientpulse/backend/admin.dart';
import 'package:patientpulse/backend/healthscore.dart';
import 'package:patientpulse/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioExecutor {
  static final Dio dio = Dio();

  static initializeInterceptors() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = gpc.read(currentAdmin)?.accessToken ??
        prefs.getString('admin_accesstoken');
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
    await initializeInterceptors();
    try {
      final response = await dio.get(url);
      return await _exec(url: url, response: response);
    } catch (e) {
      return (null, {'error': 'Exception: $e', 'statuscode': -1});
    }
  }

  static Future<DEResponse> post({
    required String url,
    required Map data,
  }) async {
    await initializeInterceptors();
    try {
      final response = await dio.post(url, data: data);
      return await _exec(url: url, response: response);
    } catch (e) {
      return (null, {'error': 'Exception: $e', 'statuscode': -1});
    }
  }

  static Future<DEResponse> delete({
    required String url,
  }) async {
    await initializeInterceptors();
    try {
      final response = await dio.delete(url);
      return await _exec(url: url, response: response);
    } catch (e) {
      return (null, {'error': 'Exception: $e', 'statuscode': -1});
    }
  }

  static Future<DEResponse> put({
    required String url,
    required Map data,
  }) async {
    await initializeInterceptors();
    try {
      final response = await dio.put(url, data: data);
      return await _exec(url: url, response: response);
    } catch (e) {
      return (null, {'error': 'Exception: $e', 'statuscode': -1});
    }
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
