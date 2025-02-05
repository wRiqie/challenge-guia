import 'package:challenge_guia/app/business_logic/cubits/motels/motels_cubit.dart';
import 'package:challenge_guia/app/business_logic/cubits/motels/motels_state.dart';
import 'package:challenge_guia/app/core/helpers/app_helpers.dart';
import 'package:challenge_guia/app/ui/widgets/expandable_page_view_widget.dart';
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
    BlocProvider.of<MotelsCubit>(context).getAllPaginated();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.sizeOf(context);

    return BlocBuilder<MotelsCubit, MotelsState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status.isSuccess) {
          return SingleChildScrollView(
            child: Column(
              children: (state.motels?.items ?? []).map(
                (e) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 16,
                              children: [
                                CircleAvatar(
                                  backgroundColor: colorScheme.onSurface
                                      .withValues(alpha: .2),
                                  foregroundImage: NetworkImage(e.logoUrl),
                                ),
                                Column(
                                  spacing: 4,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.name,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(e.address),
                                    Row(
                                      spacing: 6,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4, vertical: 2),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.orangeAccent,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Row(
                                            spacing: 4,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 12,
                                                color: Colors.orangeAccent,
                                              ),
                                              Text(
                                                e.favoriteAmount
                                                    .toStringAsFixed(1),
                                                style: TextStyle(fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${e.favoriteAmount} avaliações',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Icon(Icons.expand_more),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Icon(
                              Icons.favorite,
                              color:
                                  colorScheme.onSurface.withValues(alpha: .3),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ExpandablePageViewWidget(
                        controller: PageController(
                          viewportFraction: .9,
                          initialPage: 0,
                        ),
                        scrollDirection: Axis.horizontal,
                        children: e.suites.map((suite) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Column(
                              spacing: 6,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: colorScheme.surface,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    spacing: 8,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Image.network(
                                          suite.photosUrls.first,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return SkeletonCardWidget(
                                              height: size.width * .65,
                                            );
                                          },
                                        ),
                                      ),
                                      Text(
                                        suite.name,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Visibility(
                                        visible: suite.amount <= 2,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          spacing: 4,
                                          children: [
                                            Icon(
                                              Icons.emergency,
                                              size: 12,
                                              color: colorScheme.primary,
                                            ),
                                            Text(
                                              'só mais ${suite.amount} pelo app',
                                              style: TextStyle(
                                                color: colorScheme.primary,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: colorScheme.surface,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    spacing: 8,
                                    children: [
                                      ...suite.categoryItems.take(5).map((e) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black
                                                .withValues(alpha: .05),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Image.network(
                                            e.iconUrl,
                                            width: 40,
                                          ),
                                        );
                                      }),
                                      Row(
                                        spacing: 4,
                                        children: [
                                          Text(
                                            'ver\ntodos',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black38,
                                            ),
                                          ),
                                          Icon(
                                            Icons.expand_more,
                                            size: 10,
                                            color: Colors.black38,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                ...suite.periods.map(
                                  (e) => Container(
                                    padding: EdgeInsets.all(18),
                                    decoration: BoxDecoration(
                                        color: colorScheme.surface,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            spacing: 8,
                                            children: [
                                              Row(
                                                spacing: 8,
                                                children: [
                                                  Text(
                                                    e.formattedTime,
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                  Visibility(
                                                    visible: e.discount != null,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2,
                                                              horizontal: 6),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            width: 1,
                                                            color: Colors.green,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Text(
                                                        '${(e.discount ?? 0).toStringAsFixed(0)}% off',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.green,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Visibility(
                                                    visible: e.baseValue !=
                                                        e.totalValue,
                                                    child: Text(
                                                      AppHelpers.formatCurrency(
                                                          e.baseValue),
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black38,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: e.baseValue !=
                                                        e.totalValue,
                                                    child: SizedBox(
                                                      width: 14,
                                                    ),
                                                  ),
                                                  Text(
                                                    AppHelpers.formatCurrency(
                                                        e.totalValue),
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          Icons.chevron_right,
                                          size: 30,
                                          color: Colors.black38,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  );
                },
              ).toList(),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
