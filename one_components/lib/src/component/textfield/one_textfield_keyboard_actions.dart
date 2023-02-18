/*
 * File: one_textfield_keyboard_actions.dart
 * File Created: Tuesday, 31st August 2021 4:28:51 pm
 * Author: Hieu Tran
 * -----
 * Last Modified: Tuesday, 31st August 2021 4:30:10 pm
 * Modified By: Hieu Tran
 */

part of 'one_textfield.dart';

class OneTextFieldKeyboardActions extends StatelessWidget {
  const OneTextFieldKeyboardActions({
    Key? key,
    required this.child,
    required this.listFocusNode,
    this.isDialog = false,
  }) : super(key: key);

  final Widget child;
  final List<FocusNode> listFocusNode;
  final bool isDialog;

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      config: _buildConfig(context),
      isDialog: isDialog,
      child: child,
    );
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    final List<KeyboardActionsItem> _list = [];
    for (final item in listFocusNode) {
      _list.add(KeyboardActionsItem(
        focusNode: item,
      ));
    }
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: _list.isNotEmpty ? _list : null,
    );
  }
}
