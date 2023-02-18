/*
 * File: one_page_number.dart
 * File Created: Thursday, 6th May 2021 1:51:57 am
 * Author: Hieu Tran
 * -----
 * Last Modified: Thursday, 2nd Jun 2021 2:58:53 pm
 * Modified By: Dương Trí
 */

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:one_assets/one_assets.dart';
import 'package:one_components/src/component/textfield/number_input_formater.dart';
import 'package:one_components/src/shared/constant.dart';

part 'one_page_controller.dart';
part 'one_page_value.dart';

class OnePageNumber extends StatefulWidget {
  const OnePageNumber({
    Key? key,
    this.padding = const EdgeInsets.all(8.0),
    this.onChanged,
    this.controller,
    this.initialPage = 1,
  }) : super(key: key);

  final EdgeInsetsGeometry padding;
  final ValueChanged<int>? onChanged;
  final OnePageController? controller;
  final int initialPage;

  @override
  _OnePageNumberState createState() => _OnePageNumberState();
}

class _OnePageNumberState extends State<OnePageNumber> {
  late OnePageController _controller;
  OnePageController get _effectiveController => widget.controller ?? _controller;

  late int _currentPage;
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _currentPage = widget.initialPage;
    if (widget.controller == null) {
      _controller = OnePageController(
        currentPage: widget.initialPage,
      );
    } else {
      widget.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(OnePageNumber oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller = OnePageController.fromValue(oldWidget.controller!.value);
      }
      if (widget.controller != null) {
        _currentPage = widget.controller!.currentPage;
        if (oldWidget.controller == null) {
          _controller = OnePageController(
            currentPage: widget.initialPage,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildButton(
            OneIcons.ic_left_arrow_first,
            onTap: (_currentPage != 1) ? first : null,
          ),
          const SizedBox(width: 8),
          _buildButton(
            OneIcons.ic_left_arrow,
            title: 'Trước',
            onTap: (_currentPage > 1) ? back : null,
          ),
          const SizedBox(width: 8),
          Expanded(child: _buildPageNumber()),
          const SizedBox(width: 8),
          _buildButton(
            OneIcons.ic_right_arrow,
            title: 'Sau',
            isRight: true,
            onTap: () {
              if (_effectiveController.maxSize == null || _currentPage < _effectiveController.maxSize! || (_effectiveController.maxSize == -1 && _currentPage > 0)) {
                next();
              }
            },
          ),
          const SizedBox(width: 8),
          _buildButton(
            OneIcons.ic_left_arrow_last,
            isRight: true,
            onTap: last,
          ),
        ],
      ),
    );
  }

  Widget _buildPageNumber() {
    _textController.text = '$_currentPage';
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: OneColors.bgPageNumber,
      ),
      child: Center(
        child: TextField(
          autocorrect: false,
          enableSuggestions: false,
          textAlign: TextAlign.center,
          controller: _textController,
          style: OneTheme.of(context).title1,
          autofocus: false,
          keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
          decoration: const InputDecoration.collapsed(hintText: ''),
          inputFormatters: [NumberInputFormater()],
          onEditingComplete: () {
            if (_textController.text.isNotEmpty) {
              final pageNumber = int.parse(_textController.text);
              if (pageNumber <= 0 || (_effectiveController.maxSize != null && pageNumber > _effectiveController.maxSize!)) {
                _textController.text = _currentPage.toString();
              }
              random(_textController.text);
            }
          },
          onTap: () {
            _textController.selection = TextSelection(
              baseOffset: 0,
              extentOffset: _textController.text.length,
            );
          },
        ),
      ),
    );
  }

  Widget _buildButton(String iconUrl, {String? title, bool isRight = false, VoidCallback? onTap}) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: OneColors.greyLight,
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.0),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                if (isRight && title != null) ...[
                  const SizedBox(width: 4.0),
                  Text(title, style: OneTheme.of(context).body2.copyWith(color: OneColors.textGrey2)),
                ] else
                  const SizedBox(),
                SvgPicture.asset(iconUrl, color: OneColors.textGrey2, cacheColorFilter: true),
                if (!isRight && title != null) ...[
                  Text(title, style: OneTheme.of(context).body2.copyWith(color: OneColors.textGrey2)),
                  const SizedBox(width: 4.0),
                ] else
                  const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  void _didChange(int number) {
    setState(() {
      _currentPage = number != -1 ? number : _currentPage;
    });
    if (_effectiveController.currentPage != number) {
      _effectiveController.currentPage = number;
    }
    if (widget.onChanged != null) {
      widget.onChanged!(number);
    }
  }

  void _handleControllerChanged() {
    if (_effectiveController.currentPage != _currentPage) {
      _didChange(_effectiveController.currentPage);
    }

    setState(() {
      // _enable = _effectiveController.enable;
      // _visibility = _effectiveController.visibility;
    });
  }

  void first() => _didChange(1);
  void back() => _didChange(_currentPage -= 1);
  void next() => _didChange(_currentPage += 1);
  void last() => _didChange(_effectiveController.maxSize ?? -1);
  void random(String pageNumber) => _didChange(int.parse(pageNumber));
}
