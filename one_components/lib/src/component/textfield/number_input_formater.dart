/*
 * File: number_input_formatter.dart
 * File Created: Sunday, 2nd Jun 2021 5:37:53 pm
 * Author: Dương Trí
 * -----
 * Last Modified: Sunday, 2nd Jun 2021 5:37:53 pm
 * Modified By: Dương Trí
 */

import 'package:flutter/services.dart';

class NumberInputFormater extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // final bool isInsertedCharacter = oldValue.text.length + 1 == newValue.text.length && newValue.text.startsWith(oldValue.text);
    // final bool isRemovedCharacter = oldValue.text.length - 1 == newValue.text.length && oldValue.text.startsWith(newValue.text);

    // if (!isInsertedCharacter && !isRemovedCharacter) {
    //   return oldValue;
    // }

    if (RegExp(r'\D').hasMatch(newValue.text)) {
      return oldValue;
    } else {
      return newValue;
    }
  }
}
