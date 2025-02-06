import 'package:flutter/material.dart';

class SuiteImagesScreen extends StatefulWidget {
  const SuiteImagesScreen({super.key});

  @override
  State<SuiteImagesScreen> createState() => _SuiteImagesScreenState();
}

class _SuiteImagesScreenState extends State<SuiteImagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 16,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
