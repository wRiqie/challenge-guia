import 'package:challenge_guia/app/data/models/custom_tab_model.dart';
import 'package:challenge_guia/app/ui/screens/dashboard/tabs/motels_list/motels_list.dart';
import 'package:challenge_guia/app/ui/widgets/custom_drawer_widget.dart';
import 'package:challenge_guia/app/ui/widgets/tab_item_widget.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<CustomTabModel> tabs = [];

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    tabs = [
      CustomTabModel(Icons.bolt, 'ir agora'),
      CustomTabModel(Icons.calendar_today, 'ir outro dia'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colorScheme.primary,
      drawer: CustomDrawerWidget(),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: colorScheme.onPrimary,
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 35,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Material(
                        color: colorScheme.onSurface.withValues(alpha: .3),
                        child: TabBar(
                          isScrollable: false,
                          controller: _tabController,
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: Colors.transparent,
                          indicator: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          labelColor: colorScheme.onSurface,
                          unselectedLabelColor: colorScheme.onPrimary,
                          onTap: (value) {
                            setState(() {});
                          },
                          tabs: tabs.map(
                            (e) {
                              return TabItemWidget(
                                icon: e.icon,
                                title: e.text,
                                isSelected:
                                    _tabController.index == tabs.indexOf(e),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 250),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(0, 0.5),
                        end: Offset(0, 0),
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: _tabController.index == 0
                    ? Row(
                        key: ValueKey<int>(0),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'zona norte',
                            style: TextStyle(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(
                            Icons.expand_more,
                            color: colorScheme.onPrimary,
                          ),
                        ],
                      )
                    : Row(
                        spacing: 40,
                        key: ValueKey<int>(1),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                'zona norte',
                                style: TextStyle(
                                  color: colorScheme.onPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(
                                Icons.expand_more,
                                color: colorScheme.onPrimary,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.nights_stay,
                                color: colorScheme.onPrimary,
                              ),
                              Text(
                                '09 fev - 10 fev',
                                style: TextStyle(
                                  color: colorScheme.onPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(
                                Icons.expand_more,
                                color: colorScheme.onPrimary,
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14),
                        topRight: Radius.circular(14),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                    ),
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [
                        MotelsList(),
                        Center(child: Text('Listagem "ir outro dia"')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
