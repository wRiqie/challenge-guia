import 'package:flutter/foundation.dart';

class Constants {
  static late String baseUrl;

  Constants.init() {
    if (kDebugMode) {
      baseUrl = 'https://www.jsonkeeper.com';
    } else {
      // Para api em produção
      baseUrl = 'https://www.jsonkeeper.com';
    }
  }
}
