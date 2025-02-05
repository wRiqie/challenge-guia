import 'package:challenge_guia/app/core/theme/app_theme.dart';
import 'package:challenge_guia/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute: AppRoutes.dashboard,
      routes: AppPages.pages,
    );
  }
}
