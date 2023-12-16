import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patientpulse/main.dart';

final bearerTokenProvider = StateProvider<String?>((ref) => null);

class HealthScoreCredentials {
  static const String _target = 'https://hackathon.hsdevonline.com';
  static const String hsLoginURL = '$_target/HSLogin';
  static const String baseURL = '$_target/HS/mobile/V2';
  static const String hospitalCode = 'CSOFTSUPPORT';
  static const String clientSecret =
      r'$2a$10$iNssdGZSSfsmS9lzireKNelKNKDNQ/octZGZ.qh9nGy1u7St2ChC2';
  static const String clientID = 'hackathon';
}

class HealthScoreAPI {}
