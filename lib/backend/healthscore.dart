import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patientpulse/main.dart';

class HSCreds {
  static const String _target = 'https://hackathon.hsdevonline.com';
  static const String hsLoginURL = '$_target/HSLogin';
  static const String baseURL = '$_target/HS/mobile/V2';
  static const String clientSecret =
      r'$2a$10$iNssdGZSSfsmS9lzireKNelKNKDNQ/octZGZ.qh9nGy1u7St2ChC2';
  static const String clientID = 'hackathon';
  static const String hospCode = 'CSOFTSUPPORT';

  static String getLoginURL({
    required String username,
    required String password,
  }) {
    final z =
        '$hsLoginURL/oauth/token?grant_type=password&username=$username&password=$password&hospCode=$hospCode&client_secret=$clientSecret&client_id=$clientID';
    return z;
  }
}

class HealthScoreAPI {}
