/*
 * File: one_number_picker.dart
 * File Path: c:\PTPM1_IT_OneApp\one_components\lib\src\component\number_picker\one_number_picker.dart
 * File Created: Wednesday, 31/03/2021 11:56:37
 * Author: Lê Nguyên Trà (traln@Aneed.vn)
 * -----
 * Last Modified: Friday, 02/04/2021 08:41:46
 * Modified By: Hieu T ran
 * -----
 * Copyright OneBSS - 2021 , Trung tâm Aneed - IT3
 */

import 'dart:async';

import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:one_assets/one_assets.dart';
import 'package:one_components/src/shared/constant.dart';
import 'package:one_components/src/shared/number_extension.dart';
import 'package:one_components/src/shared/string_extension.dart';
import 'package:rxdart/rxdart.dart';

part 'one_number_picker_controller.dart';
part 'one_number_picker_value.dart';

enum OneNumberPickerStyle {
  primary,
  borderless,
}

class OneNumberPicker extends StatefulWidget {
  const OneNumberPicker({
    Key? key,
    this.initialValue = 1,
    this.minimum = 0,
    this.maximum = 99,
    this.step = 1,
    this.enable,
    this.onChanged,
    this.controller,
    this.onFiltered,
    this.onInputFocusChanged,
    this.filterDuration,
    this.visibility = OneVisibility.VISIBLE,
    this.decimalDigits = 0,
    this.background,
    this.borderColor,
    this.icMinusColor,
    this.icPlusColor,
    this.style = OneNumberPickerStyle.primary,
    this.borderRadius,
    this.autoSizeTextFieldFullWidth = true,
    this.maxWidth = 100,
  }) : super(key: key);

  final double initialValue;
  final double minimum;
  final double maximum;
  final double step;
  final bool? enable;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onFiltered;
  final ValueChanged<bool>? onInputFocusChanged;
  final Duration? filterDuration;
  final OneNumberPickerController? controller;
  final OneVisibility visibility;
  final int decimalDigits;
  final Color? background;
  final Color? borderColor;
  final Color? icMinusColor;
  final Color? icPlusColor;
  final OneNumberPickerStyle style;
  final BorderRadiusGeometry? borderRadius;
  final bool autoSizeTextFieldFullWidth;
  final double maxWidth;

  @override
  State<StatefulWidget> createState() => _OneNumberPickerState();
}

class _OneNumberPickerState extends State<OneNumberPicker> {
  late OneNumberPickerController _controller;
  OneNumberPickerController get _effectiveController => widget.controller ?? _controller;

  late TextEditingController _txtController;
  late final StreamController<double> _numberUpdates;
  late final StreamController<double> _numberFilters;
  Duration get filterDuration => widget.filterDuration ?? const Duration(milliseconds: 500);
  late final FocusNode _focusNode;

  Color get _background => widget.background ?? Colors.white;
  Color get _borderColor {
    if (widget.style == OneNumberPickerStyle.borderless) return Colors.transparent;
    return widget.borderColor ?? (_focusNode.hasFocus ? OneColors.brandVNP : OneColors.borderGrey);
  }

  BoxDecoration get _decoration {
    return BoxDecoration(
      color: enable ? _background : OneColors.greyLight,
      border: Border.all(color: _borderColor, width: 1),
      borderRadius: widget.borderRadius ?? BorderRadius.circular(4.0),
    );
  }

  Color get _icMinusColor {
    if (!enable) {
      return OneColors.textGrey1;
    }
    return widget.icMinusColor ?? OneColors.textGrey1;
  }

  Color get _icPlusColor {
    if (!enable) {
      return OneColors.textGrey1;
    }
    return widget.icPlusColor ?? OneColors.textGrey1;
  }

  bool? _enable;
  bool get enable => _enable ?? _effectiveController.enable;

  OneVisibility? _visibility;
  OneVisibility get visibility => _visibility ?? _effectiveController.visibility;

  late double _number;
  double? get _numberText => _txtController.text.tryCurrencyToDouble();

  @override
  void initState() {
    super.initState();
    _numberUpdates = StreamController<double>();
    _numberUpdates.stream.distinct().forEach(_onChanged);
    _numberFilters = StreamController<double>();
    _numberFilters.stream.distinct().debounceTime(filterDuration).forEach(_onFiltered);
    _number = widget.initialValue;
    _enable = widget.enable;

    if (widget.controller == null) {
      _controller = OneNumberPickerController(
        number: widget.initialValue,
        enable: widget.enable ?? true,
        visibility: widget.visibility,
      );
    } else {
      _number = widget.controller!.number;
      _visibility = widget.visibility;
      if (widget.enable != null) widget.controller!.enable = widget.enable!;
      widget.controller!.addListener(_handleControllerChanged);
    }
    _txtController = TextEditingController(text: _number.decimalWithDigits(widget.decimalDigits));
    _txtController.selection = TextSelection.fromPosition(TextPosition(offset: _txtController.text.length));
    _txtController.addListener(_handleTxtControllerChanged);

    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChanged);
  }

  @override
  void didUpdateWidget(OneNumberPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller = OneNumberPickerController.fromValue(oldWidget.controller!.value);
      }
      if (widget.controller != null) {
        _txtController.text = widget.controller!.number.decimalWithDigits(widget.decimalDigits);
        if (oldWidget.controller == null) {
          _controller = OneNumberPickerController(
            number: widget.initialValue,
            enable: widget.enable ?? true,
            visibility: widget.visibility,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: widget.maxWidth),
      decoration: _decoration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            color: Colors.transparent,
            child: Ink(
              child: InkWell(
                onTap: _minus,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 6, 4, 6),
                  child: SvgPicture.asset(OneIcons.ic_minus, color: _icMinusColor, height: 24),
                ),
              ),
            ),
          ),
          Flexible(
            child: Container(
              constraints: const BoxConstraints(minWidth: 24),
              child: AutoSizeTextField(
                enableInteractiveSelection: false,
                fullwidth: widget.autoSizeTextFieldFullWidth,
                controller: _txtController,
                focusNode: _focusNode,
                enabled: enable,
                style: OneTheme.of(context).title1,
                keyboardType: const TextInputType.numberWithOptions(signed: false),
                inputFormatters: [OneIntUtils.decimalInputFormatWithDigits(widget.decimalDigits)],
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: widget.minimum.decimalWithDigits(widget.decimalDigits),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.all(0),
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: Ink(
              child: InkWell(
                onTap: _add,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4, 6, 8, 6),
                  child: SvgPicture.asset(OneIcons.ic_plus, color: _icPlusColor, height: 24),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    _txtController.removeListener(_handleTxtControllerChanged);
    _numberUpdates.close();
    _numberFilters.close();
    _focusNode.removeListener(_handleFocusChanged);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleTxtControllerChanged() {
    final _num = _numberText ?? widget.minimum;
    if (_num >= widget.maximum)
      _didChange(widget.maximum);
    else if (_num <= widget.minimum)
      _didChange(widget.minimum, isUpdateText: false);
    else
      _didChange(_num, isUpdateText: false);
  }

  void _add() {
    if (!enable) return;
    final _fNumber = _number + widget.step;
    if (_fNumber <= widget.minimum) {
      _didChange(widget.minimum);
    } else if (_fNumber >= widget.maximum) {
      _didChange(widget.maximum);
    } else {
      _didChange(_fNumber);
    }
  }

  void _minus() {
    if (!enable) return;
    final _fNumber = _number - widget.step;
    if (_fNumber <= widget.minimum) {
      _didChange(widget.minimum);
    } else if (_fNumber >= widget.maximum) {
      _didChange(widget.maximum);
    } else {
      _didChange(_fNumber);
    }
  }

  void _didChange(double number, {bool isUpdateText = true}) {
    _number = number;

    if (_effectiveController.number != number) {
      _effectiveController.number = number;
    }

    if (isUpdateText && number != _numberText) {
      _txtController.text = _number.decimalWithDigits(widget.decimalDigits);
      _txtController.selection = TextSelection.fromPosition(TextPosition(offset: _txtController.text.length));
    }

    _numberUpdates.add(_number);
    _numberFilters.add(_number);
  }

  void _handleControllerChanged() {
    if (_effectiveController.number != _number) {
      final _fNumber = _effectiveController.number;
      if (_fNumber <= widget.minimum) {
        _didChange(widget.minimum);
      } else if (_fNumber >= widget.maximum) {
        _didChange(widget.maximum);
      } else {
        _didChange(_fNumber);
      }
    }

    setState(() {
      _enable = _effectiveController.enable;
      _visibility = _effectiveController.visibility;
    });
  }

  void _onFiltered(double num) {
    if (!mounted) return;
    if (widget.onFiltered != null) {
      widget.onFiltered!(num);
    }
  }

  void _onChanged(double num) {
    if (!mounted) return;
    if (widget.onChanged != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onChanged!(num);
      });
    }
  }

  void _handleFocusChanged() {
    if (_focusNode.hasFocus) _txtController.selection = TextSelection.fromPosition(TextPosition(offset: _txtController.text.length));
    if (!_focusNode.hasFocus && (_number != _numberText || _txtController.text.isEmpty)) {
      _txtController.text = _number.decimalWithDigits(widget.decimalDigits);
    }
    if (widget.onInputFocusChanged != null) widget.onInputFocusChanged!(_focusNode.hasFocus);
    setState(() {});
  }
}
