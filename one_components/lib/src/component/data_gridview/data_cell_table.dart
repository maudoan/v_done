/*
 * File: data_cell.dart
 * File Created: Saturday, 23rd October 2021 3:35:40 pm
 * Author: Dương Trí
 * -----
 * Last Modified: Saturday, 23rd October 2021 3:38:17 pm
 * Modified By: Dương Trí
 */

import 'package:flutter/material.dart';

class DataCellTable {
  String value;
  double width;
  double? height;
  Color? headerBackground;
  Color? rowBackground;
  AlignmentGeometry? headerAlign;
  double? headerSize;
  FontWeight? headerFontWeight;
  Color? headerColor;
  AlignmentGeometry? rowAlign;
  double? rowSize;
  FontWeight? rowFontWeight;
  Color? rowColor;

  DataCellTable({
    required this.value,
    required this.width,
    this.height,
    this.headerBackground,
    this.rowBackground,
    this.headerAlign,
    this.headerSize,
    this.headerFontWeight,
    this.headerColor,
    this.rowAlign,
    this.rowSize,
    this.rowFontWeight,
    this.rowColor,
  });
}
