import 'package:challenge_guia/app/business_logic/cubits/motels/motels_cubit.dart';
import 'package:challenge_guia/app/business_logic/cubits/motels/motels_state.dart';
import 'package:challenge_guia/app/core/helpers/transition_helper.dart';
import 'package:challenge_guia/app/data/models/args/suite_images_args.dart';
import 'package:challenge_guia/app/data/models/args/suite_items_args.dart';
import 'package:challenge_guia/app/routes/app_pages.dart';
import 'package:challenge_guia/app/ui/screens/dashboard/tabs/motels_list/delegates/filters_delegate.dart';
import 'package:challenge_guia/app/ui/screens/suite_items/suite_items.dart';
import 'package:challenge_guia/app/ui/widgets/category_chip_widget.dart';
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
  List<String> categories = [
    'com desconto',
    'disponíveis',
    'hidro',
    'piscina',
    'sauna',
    'ofurô',
    'decoração erótica',
    'decoração temática',
    'cadeira erótica',
    'pista de dança',
    'garagem privativa',
    'frigobar',
    'internet wi-fi',
    'suíte para festas',
    'suíte com acessibilidade',
  ];

  List<String> selectedCategories = [];

  @override
  void initState() {
    super.initState();
    _loadMotels();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.sizeOf(context);

    return BlocBuilder<MotelsCubit, MotelsState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async => _loadMotels(),
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: FiltersDelegate(
                  ColoredBox(
                    color: colorScheme.surfaceContainer,
                    child: Column(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              spacing: 6,
                              children: [
                                CategoryChipWidget(
                                  icon: Icons.tune,
                                  label: 'filtros',
                                  badgeCount: selectedCategories.length,
                                ),
                                ...categories.map((e) {
                                  final isSelected =
                                      selectedCategories.contains(e);

                                  return CategoryChipWidget(
                                    label: e,
                                    isSelected: isSelected,
                                    onTap: () {
                                      _toggleCategory(e);
                                    },
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          thickness: .8,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (state.status.isLoading)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
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
                ),
              if (state.status.isSuccess)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 14),
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
                ),
            ],
          ),
        );
      },
    );
  }

  void _loadMotels() {
    BlocProvider.of<MotelsCubit>(context).getAllPaginated();
  }

  void _toggleCategory(String category) {
    final isSelected = selectedCategories.contains(category);

    if (isSelected) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
    setState(() {});
  }
}
