import 'package:challenge_guia/app/ui/screens/dashboard/dashboard.dart';
import 'package:challenge_guia/app/ui/screens/suite_images/suite_images.dart';
import 'package:flutter/material.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static Map<String, Widget Function(BuildContext context)> pages = {
    AppRoutes.dashboard: (context) => Dashboard(),
    AppRoutes.suiteImages: (context) => SuiteImages(),
  };
}
