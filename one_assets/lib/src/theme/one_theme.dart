/*
 * File: one_theme.dart
 * File Created: Friday, 8th January 2021 12:50:44 pm
 * Author: Hieu Tran
 * -----
 * Last Modified: Friday, 8th January 2021 12:52:32 pm
 * Modified By: Hieu Tran
 */

import 'package:flutter/material.dart';

import 'one_theme_data.dart';

class OneTheme extends StatelessWidget {
  const OneTheme({
    Key? key,
    this.data,
    required this.child,
  }) : super(key: key);

  final OneThemeData? data;
  final Widget child;

  static OneThemeData of(BuildContext context) {
    final _InheritedTheme? inheritedTheme = context.dependOnInheritedWidgetOfExactType<_InheritedTheme>();
    return inheritedTheme?.theme.data ?? OneThemeData.fromContext(context);
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedTheme(
      theme: this,
      child: child,
    );
  }
}

class _InheritedTheme extends InheritedTheme {
  const _InheritedTheme({
    Key? key,
    required this.theme,
    required Widget child,
  }) : super(key: key, child: child);

  final OneTheme theme;

  @override
  Widget wrap(BuildContext context, Widget child) {
    final _InheritedTheme? ancestorTheme = context.findAncestorWidgetOfExactType<_InheritedTheme>();
    return identical(this, ancestorTheme) ? child : OneTheme(data: theme.data, child: child);
  }

  @override
  bool updateShouldNotify(_InheritedTheme old) => theme.data != old.theme.data;
}
