/*
 * File: one_card_expandable.dart
 * File Created: Friday, 16th July 2021 12:19:06 pm
 * Author: Hieu Tran
 * -----
 * Last Modified: Friday, 16th July 2021 12:21:03 pm
 * Modified By: Hieu Tran
 */

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:one_assets/one_assets.dart';

class OneCardExpandable extends StatefulWidget {
  const OneCardExpandable({
    Key? key,
    required this.header,
    required this.body,
    this.headerColor = OneColors.bgHeaderItem,
    this.bodyColor = OneColors.bgChildItem,
    this.boxShadow,
    this.borderRadius,
    this.headerPadding,
    this.bodyPadding,
    this.margin,
  }) : super(key: key);

  final Widget header;
  final Widget body;
  final Color headerColor;
  final Color bodyColor;
  final List<BoxShadow>? boxShadow;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? headerPadding;
  final EdgeInsetsGeometry? bodyPadding;
  final EdgeInsetsGeometry? margin;

  @override
  _OneCardExpandableState createState() => _OneCardExpandableState();
}

class _OneCardExpandableState extends State<OneCardExpandable> {
  final _isExpanded = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? const EdgeInsets.symmetric(vertical: 4),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Positioned.fill(
            top: 10.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: widget.borderRadius ?? BorderRadius.circular(8.0),
                boxShadow: widget.boxShadow,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
              child: Container(
                color: widget.bodyColor,
                child: ValueListenableBuilder<bool>(
                  valueListenable: _isExpanded,
                  builder: (_, value, __) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Material(
                          color: widget.headerColor,
                          child: Ink(
                            width: double.infinity,
                            child: InkWell(
                              onTap: () => _isExpanded.value = !_isExpanded.value,
                              child: Padding(
                                padding: widget.headerPadding ?? const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Expanded(child: widget.header),
                                    Icon(value ? Icons.expand_less : Icons.expand_more),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (value)
                          Padding(
                            padding: widget.bodyPadding ?? const EdgeInsets.all(10.0),
                            child: widget.body,
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
