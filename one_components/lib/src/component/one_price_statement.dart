/*
 * File: one_price_statement.dart
 * File Created: Thursday, 16th September 2021 9:38:40 am
 * Author: Hieu Tran
 * -----
 * Last Modified: Hà Thanh Tân
 * Modified By: Hà Thanh Tân
 */

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:one_assets/one_assets.dart';
import 'package:tuple/tuple.dart';

class OnePriceStatement extends StatelessWidget {
  const OnePriceStatement({
    Key? key,
    required this.numberOfColumn,
    required this.flexs,
    required this.textAligns,
    required this.headerTitles,
    required this.contentValues,
    required this.footerValues,
  }) : super(key: key);
  final int numberOfColumn;
  final List<int> flexs;
  final List<TextAlign?> textAligns;
  final List<String> headerTitles;
  final List<List<String>> contentValues;
  final List<Tuple2<String, String>> footerValues;

  List<Tuple3<int, String, TextAlign?>> get _headers {
    final List<Tuple3<int, String, TextAlign?>> list = [];
    for (var i = 0; i < numberOfColumn; i++) {
      list.add(Tuple3(flexs[i], headerTitles[i], textAligns[i]));
    }
    return list;
  }

  List<List<Tuple3<int, String, TextAlign?>>> get _contents {
    final List<List<Tuple3<int, String, TextAlign?>>> rows = [];
    for (final item in contentValues) {
      final List<Tuple3<int, String, TextAlign?>> list = [];
      for (var i = 0; i < numberOfColumn; i++) {
        list.add(Tuple3(flexs[i], item[i], textAligns[i]));
      }
      rows.add(list);
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        _buildContent(context),
        _buildFooter(context),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: OneColors.bgBangKe,
          ),
          child: Row(
            children: [
              for (final header in _headers)
                Expanded(
                    flex: header.item1,
                    child: AutoSizeText(
                      header.item2,
                      style: OneTheme.of(context).caption1,
                      textAlign: header.item3,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                    )),
            ],
          ),
        ),
        const Divider(color: Color(0xFFCFD1DA), thickness: 1.0, height: 0),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    if (_contents.isEmpty)
      return Column(
        children: [
          Text('Chưa có thông tin', style: OneTheme.of(context).body1),
          const Divider(color: OneColors.dividerGrey, endIndent: 0, thickness: 1.0),
        ],
      );
    final List<Widget> items = [];
    for (final row in _contents) {
      items.add(_buildContentItem(context, row));
    }
    return Column(
      children: items,
    );
  }

  Widget _buildContentItem(BuildContext context, List<Tuple3<int, String, TextAlign?>> item) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              for (final child in item)
                Expanded(
                    flex: child.item1,
                    child: AutoSizeText(
                      child.item2,
                      style: OneTheme.of(context).caption2,
                      textAlign: child.item3,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                    )),
            ],
          ),
        ),
        const Divider(color: OneColors.dividerGrey, endIndent: 0, thickness: 1.0),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      // padding: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.only(left: 30.0, right: 8.0),
      child: Column(
        children: [
          for (final footer in footerValues)
            Column(
              children: [
                Row(
                  children: [
                    Expanded(flex: 2, child: AutoSizeText(footer.item1, style: OneTheme.of(context).caption1, textAlign: TextAlign.left)),
                    Expanded(flex: 1, child: AutoSizeText(footer.item2, style: OneTheme.of(context).caption2.copyWith(color: OneColors.textPrice), textAlign: TextAlign.right)),
                  ],
                ),
                const Divider(color: OneColors.dividerGrey, endIndent: 0, thickness: 1.0),
              ],
            ),
        ],
      ),
    );
  }
}
