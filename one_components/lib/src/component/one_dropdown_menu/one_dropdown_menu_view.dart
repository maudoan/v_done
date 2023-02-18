/*
 * File: one_dropdown_menu.dart
 * File Created: Tuesday, 12th October 2021 10:55:42 am
 * Author: Hieu Tran
 * -----
 * Last Modified: Tuesday, 12th October 2021 11:03:13 am
 * Modified By: Hieu Tran
 */

import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';
import 'package:one_assets/one_assets.dart';

part 'one_dropdown_menu_action.dart';

class OneDropdownMenuView extends StatefulWidget {
  const OneDropdownMenuView({
    Key? key,
    required this.actions,
    this.onSelected,
  }) : super(key: key);

  final List<OneDropdownMenuAction> actions;
  final ValueChanged<OneDropdownMenuAction>? onSelected;

  @override
  OneDropdownMenuViewState createState() => OneDropdownMenuViewState();
}

class OneDropdownMenuViewState extends State<OneDropdownMenuView> {
  final _isExpanded = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isExpanded,
      builder: (context, isExpanded, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildMenu(context, isExpanded),
            AnimatedSizeAndFade(
              fadeDuration: const Duration(milliseconds: 150),
              sizeDuration: const Duration(milliseconds: 150),
              child: !isExpanded
                  ? const SizedBox(height: 1)
                  : Column(
                      children: [
                        const SizedBox(height: 5),
                        child!,
                      ],
                    ),
            ),
          ],
        );
      },
      child: _buildListMenuAction(context),
    );
  }

  Widget _buildMenu(BuildContext context, bool isExpanded) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withOpacity(0.8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: SvgPicture.asset(isExpanded ? OneIcons.ic_cancel : OneIcons.ic_menu, color: Colors.white, cacheColorFilter: true),
          ),
          onTap: () {
            _isExpanded.value = !_isExpanded.value;
          },
        ),
      ),
    );
  }

  Widget _buildListMenuAction(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        color: Colors.black.withOpacity(0.8),
      ),
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.actions
            .map(
              (e) => Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        SvgPicture.asset(e.imageUrl, color: Colors.white, cacheColorFilter: true),
                        const SizedBox(width: 5),
                        Text(e.name, style: OneTheme.of(context).body1.copyWith(color: OneColors.greyLight)),
                      ],
                    ),
                  ),
                  onTap: () {
                    _isExpanded.value = false;
                    if (widget.onSelected != null) widget.onSelected!(e);
                  },
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
