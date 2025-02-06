import 'package:flutter/material.dart';

import 'size_reporting_widget.dart';

class ExpandablePageViewWidget extends StatefulWidget {
  final num? viewportFraction;
  final Axis? scrollDirection;
  final List<Widget> children;

  const ExpandablePageViewWidget({
    super.key,
    required this.children,
    this.viewportFraction,
    this.scrollDirection,
  });

  @override
  State<ExpandablePageViewWidget> createState() =>
      _ExpandablePageViewWidgetState();
}

class _ExpandablePageViewWidgetState extends State<ExpandablePageViewWidget>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late List<double> _heights;
  int _currentPage = 0;

  double get _currentHeight => _heights[_currentPage];

  @override
  void initState() {
    _heights = widget.children.map((e) => 0.0).toList();
    super.initState();
    _pageController =
        PageController(viewportFraction: (widget.viewportFraction ?? 1) * 1.0)
          ..addListener(() {
            final newPage = _pageController.page?.round() ?? 0;
            if (_currentPage != newPage) {
              setState(() => _currentPage = newPage);
            }
          });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      curve: Curves.easeInOutCubic,
      duration: const Duration(milliseconds: 100),
      tween: Tween<double>(begin: _heights[0], end: _currentHeight),
      builder: (context, value, child) => SizedBox(height: value, child: child),
      child: PageView(
        scrollDirection: widget.scrollDirection ?? Axis.horizontal,
        controller: _pageController,
        children: _sizeReportingChildren
            .asMap() //
            .map((index, child) => MapEntry(index, child))
            .values
            .toList(),
      ),
    );
  }

  List<Widget> get _sizeReportingChildren => widget.children
      .asMap() //
      .map(
        (index, child) => MapEntry(
          index,
          OverflowBox(
            minHeight: 0,
            maxHeight: double.infinity,
            alignment: Alignment.topCenter,
            child: SizeReportingWidget(
              onSizeChange: (size) =>
                  setState(() => _heights[index] = size.height),
              child: Align(child: child),
            ),
          ),
        ),
      )
      .values
      .toList();
}
