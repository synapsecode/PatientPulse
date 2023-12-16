import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patientpulse/main.dart';

final bearerTokenProvider = StateProvider<String?>((ref) => null);

class HealthScoreAPI {}
