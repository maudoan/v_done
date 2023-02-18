/*
 * File: int_extensions.dart
 * File Path: c:\PTPM1_IT_OneApp\one_base\lib\src\shared\int_extensions.dart
 * File Created: Monday, 19/04/2021 10:22:07
 * Author: Lê Nguyên Trà 
 * -----
 * Last Modified: Monday, 19/04/2021 10:22:20
 * Modified By: Lê Nguyên Trà
 * -----
 * Copyright OneBSS - 2021 ,
 */

import 'package:intl/intl.dart';
import 'package:one_components/one_components.dart';

extension OneIntUtils on int {
  String get vnd => '$currencyđ';
  String get vndd => '$currency VNĐ';
  String get currency {
    final oCcy = NumberFormat('#,##0', 'vi_VN');
    return oCcy.format(this);
  }

  static NumberFormat get currencyFormat => NumberFormat('#,##0', 'vi_VN');
  static CurrencyInputFormatter get currencyInputFormat => CurrencyInputFormatter(customPattern: '#,##0', locale: 'vi_VN', decimalDigits: 0);
  static CurrencyInputFormatter decimalInputFormatWithDigits([digits = 1]) {
    return CurrencyInputFormatter(
      customPattern: '#,##0',
      locale: 'vi_VN',
      decimalDigits: digits,
    );
  }

  /// Convert to luu luong
  String getLuuLuong(String type) {
    return toString() + type;
  }
}

extension OneDoubleUtils on double {
  String get vnd => '$currencyđ';
  String get vndd => '$currency VNĐ';
  String get currency {
    final oCcy = NumberFormat('#,##0', 'vi_VN');
    return oCcy.format(this);
  }

  String get decimalPercent => decimalWithDigits(2);

  String decimalWithDigits([digits = 1]) {
    final digitStr = List.generate(digits, (index) => '0').join('');
    final oCcy = NumberFormat('#,##0${digitStr.isNotEmpty ? '.$digitStr' : ''}', 'vi_VN');
    return oCcy.format(this);
  }

  static NumberFormat get currencyFormat => NumberFormat('#,##0', 'vi_VN');
  static CurrencyInputFormatter get currencyInputFormat => CurrencyInputFormatter(customPattern: '#,##0', locale: 'vi_VN', decimalDigits: 0);
  static CurrencyInputFormatter decimalInputFormatWithDigits([digits = 1]) {
    return CurrencyInputFormatter(
      customPattern: '#,##0',
      locale: 'vi_VN',
      decimalDigits: digits,
    );
  }
}
