/*
 * File: one_statepage.dart
 * File Created: Tuesday, 4th May 2021 3:23:14 pm
 * Author: Do Truong Son
 * -----
 * Last Modified: Monday, 24th May 2021 2:53:02 pm
 * Modified By: Hieu Tran
 */

import 'package:flutter/material.dart';
import 'package:one_assets/one_assets.dart';

enum OneStatePageType {
  EMPTY_DATA,
  NO_FOUND_SEARCH,
  NOT_FOUND,
  DISCONECTED,
  NO_PERMISSION,
  BUILDING,
}

class OneStatePage extends StatelessWidget {
  const OneStatePage({
    Key? key,
    this.type = OneStatePageType.EMPTY_DATA,
    this.title,
    this.desc,
    this.titleStyle,
    this.descStyle,
  }) : super(key: key);

  factory OneStatePage.fromError(dynamic error,
      {TextStyle? titleStyle, TextStyle? descStyle}) {
    return OneStatePage(
      type: OneStatePageType.NOT_FOUND,
      title: 'Không có dữ liệu để hiển thị',
      desc: error.toString(),
      titleStyle: titleStyle,
      descStyle: descStyle,
    );
  }

  factory OneStatePage.empty(
      {String? title,
      String? error,
      TextStyle? titleStyle,
      TextStyle? descStyle}) {
    return OneStatePage(
      type: OneStatePageType.EMPTY_DATA,
      title: title ?? 'Không có dữ liệu để hiển thị',
      desc: error,
      titleStyle: titleStyle,
      descStyle: descStyle,
    );
  }

  final OneStatePageType type;
  final String? title;
  final String? desc;
  final TextStyle? titleStyle;
  final TextStyle? descStyle;

  String _getAssetByPageType(OneStatePageType pageType) {
    switch (pageType) {
      case OneStatePageType.EMPTY_DATA:
        return OneImages.empty_data;
      case OneStatePageType.NO_FOUND_SEARCH:
        return OneImages.no_search;
      case OneStatePageType.NOT_FOUND:
        return OneImages.not_found;
      case OneStatePageType.DISCONECTED:
        return OneImages.disconnected;
      case OneStatePageType.NO_PERMISSION:
        return OneImages.no_permission;
      case OneStatePageType.BUILDING:
        return OneImages.building_page;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(_getAssetByPageType(type)),
          const SizedBox(height: 20),
          if (title?.isNotEmpty ?? false)
            SelectableText(
              title!,
              style: titleStyle ?? OneTheme.of(context).title1,
              textAlign: TextAlign.center,
            ),
          if (desc?.isNotEmpty ?? false)
            SelectableText(
              desc!,
              style: descStyle ?? OneTheme.of(context).body2,
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
