import 'package:challenge_guia/app/core/values/constants.dart';
import 'package:challenge_guia/app/core/values/inject.dart';
import 'package:flutter/material.dart';

import 'app/app_widget.dart';

// Flutter 3.27.3
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Constants.init();
  Inject.init();

  runApp(const AppWidget());
}
