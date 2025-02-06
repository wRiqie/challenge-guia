import 'dart:async';

import 'package:challenge_guia/app/data/models/args/suite_images_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SuiteImagesScreen extends StatefulWidget {
  const SuiteImagesScreen({super.key});

  @override
  State<SuiteImagesScreen> createState() => _SuiteImagesScreenState();
}

class _SuiteImagesScreenState extends State<SuiteImagesScreen> {
  List<String> photosUrls = [];

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(
      () {
        var args =
            ModalRoute.of(context)!.settings.arguments as SuiteImagesArgs;
        setState(() {
          photosUrls = args.photosUrls;
        });
      },
    );
  }

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            StaggeredGrid.count(
              crossAxisCount: 2, // 2 colunas
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: List.generate(photosUrls.length, (index) {
                bool isFullWidth =
                    index % 3 == 0; // Define quais ocupam a linha toda
                return StaggeredGridTile.count(
                  crossAxisCellCount: isFullWidth ? 2 : 1,
                  mainAxisCellCount: 1,
                  child: Image.network(
                    photosUrls[index],
                    fit: BoxFit.cover,
                  ),
                );
              }),
            ),
            SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
