import 'package:challenge_guia/app/business_logic/cubits/motels/motels_cubit.dart';
import 'package:challenge_guia/app/business_logic/cubits/motels/motels_state.dart';
import 'package:challenge_guia/app/core/helpers/transition_helper.dart';
import 'package:challenge_guia/app/data/models/args/suite_images_args.dart';
import 'package:challenge_guia/app/data/models/args/suite_items_args.dart';
import 'package:challenge_guia/app/routes/app_pages.dart';
import 'package:challenge_guia/app/ui/screens/suite_items/suite_items.dart';
import 'package:challenge_guia/app/ui/widgets/motel_card_widget.dart';
import 'package:challenge_guia/app/ui/widgets/skeleton_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MotelsListScreen extends StatefulWidget {
  const MotelsListScreen({super.key});

  @override
  State<MotelsListScreen> createState() => _MotelsListScreenState();
}

class _MotelsListScreenState extends State<MotelsListScreen> {
  @override
  void initState() {
    super.initState();
    _loadMotels();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocBuilder<MotelsCubit, MotelsState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                spacing: 6,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SkeletonCardWidget(
                        radius: BorderRadius.circular(20),
                        width: 40,
                        height: 40,
                      ),
                      Expanded(
                        child: SkeletonCardWidget(
                          radius: BorderRadius.circular(8),
                          height: 80,
                        ),
                      ),
                    ],
                  ),
                  SkeletonCardWidget(
                    radius: BorderRadius.circular(8),
                    height: size.width * .8,
                  ),
                  SkeletonCardWidget(
                    radius: BorderRadius.circular(8),
                    height: 50,
                  ),
                  SkeletonCardWidget(
                    radius: BorderRadius.circular(8),
                    height: 70,
                  ),
                  SkeletonCardWidget(
                    radius: BorderRadius.circular(8),
                    height: 70,
                  ),
                ],
              ),
            ),
          );
        } else if (state.status.isSuccess) {
          return RefreshIndicator(
            onRefresh: () async => _loadMotels(),
            child: SingleChildScrollView(
              child: Column(
                children: (state.motels?.items ?? [])
                    .map(
                      (e) => MotelCardWidget(
                        motel: e,
                        onTapSuiteItems: (suite) {
                          Navigator.push(
                            context,
                            TransitionHelper.showModal(
                              SuiteItems(),
                              SuiteItemsArgs(suite),
                            ),
                          );
                        },
                        onTapImages: (photosUrls) => Navigator.pushNamed(
                          context,
                          AppRoutes.suiteImages,
                          arguments: SuiteImagesArgs(photosUrls),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  void _loadMotels() {
    BlocProvider.of<MotelsCubit>(context).getAllPaginated();
  }
}
