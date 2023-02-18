/*
 * File: string_extension.dart
 * File Created: Friday, 15th October 2021 11:15:58 am
 * Author: Hieu Tran
 * -----
 * Last Modified: Friday, 15th October 2021 11:26:49 am
 * Modified By: Hieu Tran
 */

import 'number_extension.dart';

extension StringExt on String {
  int? tryToInt() => int.tryParse(this);
  double? tryToDouble() => double.tryParse(this);

  int? tryCurrencyToInt() {
    try {
      final currency = replaceAll('đ', '').replaceAll(' VNĐ', '');
      return OneIntUtils.currencyFormat.parse(currency).toInt();
    } catch (e) {
      return null;
    }
  }

  double? tryCurrencyToDouble() {
    try {
      final currency = replaceAll('đ', '').replaceAll(' VNĐ', '');
      return OneIntUtils.currencyFormat.parse(currency).toDouble();
    } catch (e) {
      return null;
    }
  }

  double? tryCurrencyToDoubleNew() {
    try {
      final currency = replaceAll('đ', '').replaceAll(' VNĐ', '').replaceAll('.', ',');
      return OneIntUtils.currencyFormat.parse(currency).toDouble();
    } catch (e) {
      return null;
    }
  }
}
