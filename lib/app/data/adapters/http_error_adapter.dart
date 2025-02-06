import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/error_model.dart';

class HttpErrorAdapter {
  static ErrorModel convertToErrorModel(HttpException error) {
    if (kDebugMode) {
      print(error);
    }
    return ErrorModel(error.message);
  }
}
