import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

class ApiConfig {
  ApiConfig._();

  static const String _productionBaseUrl =
      'https://angelic-liberation-production-e981.up.railway.app';

  static String get baseUrl {
    if (!kDebugMode) return _productionBaseUrl;

    if (kIsWeb) return 'http://127.0.0.1:8080';

    // Real Android device → use your machine's LAN IP (run `ipconfig` to find it).
    // Change to 'http://10.0.2.2:8080' if using the Android emulator instead.
    if (Platform.isAndroid) return 'http://192.168.1.9:8080';

    return 'http://127.0.0.1:8080';
  }

  static const Duration requestTimeout = Duration(seconds: 10);

  static const String recommendEndpoint = '/recommend';
  static const String healthEndpoint = '/health';
}
