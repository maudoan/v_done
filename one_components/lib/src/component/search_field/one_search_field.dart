/*
 * File: one_search_field.dart
 * File Created: Monday, 7th June 2021 3:02:50 pm
 * Author: Ha Thanh Tan
 * -----
 * Last Modified: Hà Thanh Tân
 * Modified By: Hà Thanh Tân
 */

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:one_assets/one_assets.dart';
import 'package:one_components/src/shared/constant.dart';
import 'package:rxdart/rxdart.dart';

part 'one_search_controller.dart';
part 'one_search_value.dart';

class OneSearchField extends StatefulWidget {
  const OneSearchField({
    Key? key,
    this.hint,
    this.duration,
    this.onFiltered,
    this.onClear,
    this.controller,
    this.onEditingCompleted,
    this.onFocusChanged,
    this.enable,
    this.searchSuffix = true,
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.text,
    this.visibility = OneVisibility.VISIBLE,
    this.maxLength,
  }) : super(key: key);

  final String? hint;
  final Duration? duration;
  final ValueChanged<String>? onFiltered;
  final VoidCallback? onClear;
  final ValueChanged<String>? onEditingCompleted;
  final ValueChanged<bool>? onFocusChanged;
  final OneSearchController? controller;
  final bool? enable;
  final bool? searchSuffix;
  final OneVisibility visibility;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int? maxLength;

  @override
  State<StatefulWidget> createState() => _OneSearchFieldState();
}

class _OneSearchFieldState extends State<OneSearchField> {
  late OneSearchController _controller;
  OneSearchController get _effectiveController => widget.controller ?? _controller;

  late TextEditingController _txtController;
  final _textUpdates = StreamController<String>();
  late final ValueNotifier<bool> _hasText;
  late final FocusNode _focusNode;
  TextInputAction get _textInputAction => widget.textInputAction;

  String get _hint => widget.hint ?? 'Nhập liệu tìm kiếm...';
  Duration get duration => widget.duration ?? const Duration(milliseconds: 500);

  bool? _enable;
  bool get enable => _enable ?? _effectiveController.enable;

  OneVisibility? _visibility;
  OneVisibility get visibility => _visibility ?? _effectiveController.visibility;

  @override
  void initState() {
    super.initState();
    _txtController = TextEditingController();
    _txtController.addListener(_handleTxtControllerChanged);
    _textUpdates.stream.distinct().debounceTime(duration).forEach(_onFiltered);
    _hasText = ValueNotifier(false);
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChanged);
    _enable = widget.enable;
    if (widget.controller == null) {
      _controller = OneSearchController(
        text: _txtController.text,
        visibility: widget.visibility,
        enable: widget.enable ?? true,
      );
    } else {
      _txtController.text = widget.controller!.text;
      _visibility = widget.visibility;
      if (widget.enable != null) widget.controller!.enable = widget.enable!;
      widget.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(OneSearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller = OneSearchController.fromValue(oldWidget.controller!.value);
      }
      if (widget.controller != null) {
        _txtController.text = widget.controller!.text;
        if (oldWidget.controller == null) {
          _controller = OneSearchController(
            text: _txtController.text,
            visibility: widget.visibility,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          top: 10.0,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: OneColors.shadow.withOpacity(0.2),
                  blurRadius: 20.0,
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 56,
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: _txtController,
                  focusNode: _focusNode,
                  textInputAction: _textInputAction,
                  decoration: InputDecoration(
                    hintText: _hint,
                    hintStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: OneColors.textGrey1),
                    focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.all(Radius.circular(8))),
                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.all(Radius.circular(8))),
                    contentPadding: const EdgeInsets.only(left: 15.0, right: 5.0),
                    fillColor: Colors.transparent,
                    filled: true,
                    counterText: "",
                  ),
                  style: OneTheme.of(context).textFieldText,
                  onTap: () {},
                  enabled: enable,
                  onEditingComplete: () {
                    if (_textInputAction == TextInputAction.done) {
                      FocusScope.of(context).unfocus();
                    }
                    if (widget.onEditingCompleted != null) {
                      widget.onEditingCompleted!(_txtController.text.trim());
                    }
                  },
                  maxLength: widget.maxLength,
                ),
              ),
              _buildSuffix(),
              const SizedBox(width: 10.0),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSuffix() {
    return ValueListenableBuilder<bool>(
      valueListenable: _hasText,
      builder: (context, value, child) {
        return InkWell(
          onTap: () {
            _txtController.clear();
            if (widget.onClear != null) widget.onClear!();
          },
          child: value
              ? SvgPicture.asset(OneIcons.ic_cancel)
              : widget.searchSuffix ?? true
                  ? SvgPicture.asset(OneIcons.ic_search)
                  : Container(),
        );
      },
    );
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    _txtController.removeListener(_handleTxtControllerChanged);
    _textUpdates.close();
    _focusNode.removeListener(_handleFocusChanged);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleTxtControllerChanged() {
    final _txtTrim = _txtController.text.trim();
    _hasText.value = _txtTrim.isNotEmpty;
    if (_effectiveController.text != _txtTrim) {
      _effectiveController.text = _txtTrim;
    }
    _textUpdates.add(_txtTrim);
  }

  void _handleControllerChanged() {
    if (_effectiveController.text != _txtController.text) {
      _txtController.text = _effectiveController.text;
      _txtController.selection = TextSelection.fromPosition(TextPosition(offset: _txtController.text.length));
      _textUpdates.add(_txtController.text);
    }
    setState(() {
      _enable = _effectiveController.enable;
      _visibility = _effectiveController.visibility;
    });
  }

  void _onFiltered(String s) {
    if (!mounted) return;
    if (widget.onFiltered != null) {
      widget.onFiltered!(s.trim());
    }
  }

  void _handleFocusChanged() {
    if (widget.onFocusChanged != null) widget.onFocusChanged!(_focusNode.hasFocus);
  }
}
