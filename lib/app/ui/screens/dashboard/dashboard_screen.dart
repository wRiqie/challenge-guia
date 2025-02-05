import 'package:challenge_guia/app/data/models/custom_tab_model.dart';
import 'package:challenge_guia/app/ui/screens/dashboard/tabs/motels_list/motels_list.dart';
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
  final _scaffoldKey = GlobalKey();

  late List<CustomTabModel> tabs = [];

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
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.menu,
                    color: colorScheme.onPrimary,
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Material(
                        color: colorScheme.onSurface.withValues(alpha: .3),
                        child: TabBar(
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
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'zona norte',
                  style: TextStyle(color: colorScheme.onPrimary),
                ),
                Icon(
                  Icons.expand_more,
                  color: colorScheme.onPrimary,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14),
                        topRight: Radius.circular(14),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: TabBarView(
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
