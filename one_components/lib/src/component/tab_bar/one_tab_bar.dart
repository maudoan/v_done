/*
 * File: one_tab_bar.dart
 * File Created: Monday, 22nd March 2021 2:58:56 am
 * Author: Hieu Tran
 * -----
 * Last Modified: Monday, 22nd March 2021 2:59:02 am
 * Modified By: Hieu Tran
 */

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:one_assets/one_assets.dart';

const double _kTabHeight = 36.0;
const double _kTextAndIconTabHeight = 62.0;

enum OneTabBarStyle {
  special,
  chip,
}

class OneTab {
  final String text;
  final String? iconUrl;

  const OneTab({
    required this.text,
    this.iconUrl,
  });
}

class OneTabBar extends StatefulWidget {
  const OneTabBar({
    Key? key,
    required this.controller,
    required this.tabs,
    this.onTabChange,
    this.style = OneTabBarStyle.special,
    this.isScrollable = false,
  }) : super(key: key);

  final TabController controller;
  final List<OneTab> tabs;
  final ValueChanged<int>? onTabChange;
  final OneTabBarStyle style;
  final bool isScrollable;

  @override
  _OneTabBarState createState() => _OneTabBarState();
}

class _OneTabBarState extends State<OneTabBar> {
  BoxDecoration? get _decoration {
    return widget.style == OneTabBarStyle.chip
        ? BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: OneColors.bgSegmentedControl,
          )
        : null;
  }

  TextStyle get _labelStyle => widget.style == OneTabBarStyle.chip ? OneTheme.of(context).body2 : OneTheme.of(context).title1;
  Color get _unselectedLabelColor => widget.style == OneTabBarStyle.chip ? OneColors.textGreyDark : OneColors.textGrey1;

  Decoration? get _indicator {
    return widget.style == OneTabBarStyle.chip
        ? BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            color: Colors.white,
          )
        : null;
  }

  double get _height {
    if (widget.tabs.where((e) => e.iconUrl != null).isNotEmpty) return _kTextAndIconTabHeight;
    return _kTabHeight;
  }

  late ValueNotifier<int> _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = ValueNotifier(widget.controller.index);
    widget.controller.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleTabChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: _decoration,
      child: Stack(
        children: [
          if (widget.style == OneTabBarStyle.special)
            Container(
              height: _height,
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: OneColors.textGrey1, width: 2)),
              ),
            ),
          TabBar(
            controller: widget.controller,
            labelStyle: _labelStyle,
            labelColor: OneColors.brandAneed,
            unselectedLabelColor: _unselectedLabelColor,
            indicatorColor: OneColors.brandAneed,
            indicator: _indicator,
            labelPadding: EdgeInsets.zero,
            isScrollable: widget.isScrollable,
            tabs: _widgets,
            // onTap: widget.onTap,
          )
        ],
      ),
    );
  }

  List<Widget> get _widgets {
    final List<Widget> widgets = [];

    for (final tab in widget.tabs) {
      widgets.add(Column(
        children: [
          const SizedBox(height: 6),
          if (tab.iconUrl != null) ...[
            ValueListenableBuilder(
              valueListenable: _currentIndex,
              builder: (_, value, __) {
                final color = widget.tabs.indexOf(tab) == value ? OneColors.brandAneed : OneColors.textGrey1;
                return SvgPicture.asset(tab.iconUrl!, color: color, cacheColorFilter: true);
              },
            ),
            const SizedBox(height: 2),
          ],
          AutoSizeText(tab.text, maxLines: 1, overflow: TextOverflow.fade, softWrap: false),
          const SizedBox(height: 6),
        ],
      ));
    }

    return widgets;
  }

  void _handleTabChange() {
    _currentIndex.value = widget.controller.index;
    if (!widget.controller.indexIsChanging) {
      if (mounted) FocusScope.of(context).unfocus();
      if (widget.onTabChange != null) widget.onTabChange!(_currentIndex.value);
    }
  }
}
