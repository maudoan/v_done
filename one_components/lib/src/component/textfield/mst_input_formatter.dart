/*
 * File: mst_input_formatter.dart
 * File Created: Sunday, 30th May 2021 1:36:53 pm
 * Author: Dương Trí
 * -----
 * Last Modified: Sunday, 30th May 2021 1:37:02 pm
 * Modified By: Dương Trí
 */

import 'package:flutter/services.dart';

class MSTInputFormater extends TextInputFormatter {
  MSTInputFormater();
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final bool isInsertedCharacter = oldValue.text.length + 1 == newValue.text.length && newValue.text.startsWith(oldValue.text);
    final bool isRemovedCharacter = oldValue.text.length - 1 == newValue.text.length && oldValue.text.startsWith(newValue.text);

    if (!isInsertedCharacter && !isRemovedCharacter) {
      return newValue;
    }

    if (isRemovedCharacter) {
      return newValue;
    }

    if (newValue.text.length > 14) {
      return oldValue;
    }

    String result = '';
    if (newValue.text.length > 10 && newValue.text.length <= 13) {
      if (newValue.text.length > 11) {
        result = newValue.text.substring(0, 10) + '-' + newValue.text.substring(11, newValue.text.length);
      } else {
        result = newValue.text.substring(0, 10) + '-' + newValue.text.substring(10, newValue.text.length);
      }
      return TextEditingValue(
        text: result,
        selection: TextSelection.collapsed(offset: result.length),
      );
    } else {
      return newValue;
    }
  }
}
