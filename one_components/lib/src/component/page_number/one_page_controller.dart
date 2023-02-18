/*
 * File: one_page_controller.dart
 * File Created: Wednesday, 28th July 2021 11:42:10 am
 * Author: Hieu Tran
 * -----
 * Last Modified: Wednesday, 28th July 2021 11:52:20 am
 * Modified By: Hieu Tran
 */

part of 'one_page_number.dart';

class OnePageController extends ValueNotifier<OnePageValue> {
  OnePageController({
    bool enable = true,
    int currentPage = 1,
    int? maxSize,
    OneVisibility visibility = OneVisibility.VISIBLE,
  }) : super(OnePageValue(
          enable: enable,
          currentPage: currentPage,
          maxSize: maxSize,
          visibility: visibility,
        ));

  OnePageController.fromValue(OnePageValue value) : super(value);

  bool get enable => value.enable;
  int get currentPage => value.currentPage;
  int? get maxSize => value.maxSize;
  OneVisibility get visibility => value.visibility;

  set enable(bool enable) => value = value.copyWith(enable: enable);
  set currentPage(int currentPage) => value = value.copyWith(currentPage: currentPage);
  set maxSize(int? maxSize) => value = value.copyWith(maxSize: maxSize);
  set visibility(OneVisibility visibility) => value = value.copyWith(visibility: visibility);

  @override
  set value(OnePageValue newValue) {
    super.value = newValue;
  }
}
