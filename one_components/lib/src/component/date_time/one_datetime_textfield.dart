/*
 * File: one_datetime_textfield.dart
 * File Created: Wednesday, 2nd March 2021 8:35:34 am
 * Author: Ha Thanh Tan
 * -----
 * Last Modified: Wednesday, 12th May 2021 9:54:50 am
 * Modified By: Hieu Tran
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:one_assets/one_assets.dart';
import 'package:one_components/src/3rd/flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:one_components/src/component/shake_widget.dart';
import 'package:one_components/src/component/textfield/one_textfield.dart';
import 'package:tuple/tuple.dart';

import 'extension/show_month_picker.dart';
import 'extension/show_quarterly_picker.dart';
import 'extension/show_year_picker.dart';
import 'one_datetime_format.dart';
import 'one_mask_text_input_formatter.dart';

part 'one_datetime_textfield_controller.dart';
part 'one_datetime_textfield_value.dart';
part 'one_datetime_textfield_value_gen.dart';

enum OneDateTimeType {
  DATE,
  DATE_TIME,
  TIME,
  MONTH_YEAR,
  YEAR,
  QUARTER,
}

class OneDateTimeRegex {
  static const VALID_DATE = r'^(1[0-9]|2[0-9]|3[0-1]|0[1-9]|[1-9])\/(1[0-2]|0[1-9]|[1-9])\/\d{4}$';
}

extension OneDateTimeTypeExt on OneDateTimeType {
  OneDateFormat get oneFm => value.item1;
  DateFormat get fm => value.item1.fm;
  String get title => value.item2;
  String get hint => value.item3;

  static DateTime MIN_DATE = DateTime(DateTime.now().year - 150, DateTime.now().month, DateTime.now().day);
  static DateTime ENOUGH_DATE = DateTime(DateTime.now().year - 18, DateTime.now().month, DateTime.now().day - 1);
  static DateTime MAX_DATE = DateTime(DateTime.now().year + 10, DateTime.now().month, DateTime.now().day);

  Tuple3<OneDateFormat, String, String> get value {
    switch (this) {
      case OneDateTimeType.DATE:
        return const Tuple3(OneDateFormat.DATE, 'Ngày', 'Chọn Ngày');
      case OneDateTimeType.DATE_TIME:
        return const Tuple3(OneDateFormat.DATE_TIME24, 'Ngày giờ', 'Chọn Ngày giờ');
      case OneDateTimeType.TIME:
        return const Tuple3(OneDateFormat.TIME24, 'Giờ', 'Chọn Giờ');
      case OneDateTimeType.MONTH_YEAR:
        return const Tuple3(OneDateFormat.MONTH_YEAR, 'Tháng năm', 'Chọn Tháng năm');
      case OneDateTimeType.YEAR:
        return const Tuple3(OneDateFormat.YEAR, 'Năm', 'Chọn Năm');
      case OneDateTimeType.QUARTER:
        return const Tuple3(OneDateFormat.QUARTER_YEAR, 'Quý Năm', 'Chọn Quý năm');
    }
  }
}

class OneDateTimeTextField extends StatefulWidget {
  const OneDateTimeTextField({
    Key? key,
    required this.type,
    this.titleText,
    this.titleStyle,
    this.hintText,
    this.hintStyle,
    this.textStyle,
    this.isEnable,
    this.onChanged,
    this.padding = EdgeInsets.zero,
    this.controller,
    this.firstDate,
    this.lastDate,
    this.isRequired = false,
    this.automaticTextAdjustment = true,
    this.dateFormat,
    this.maxLines = 1,
    this.prefixIconAssetPath,
    this.prefixColor,
    this.textFieldStyle = OneTextFieldStyle.underline,
    this.borderColor,
    this.isAlwaysShowTitle = true,
    this.inputFormatters,
    this.keyboardType = TextInputType.datetime,
  }) : super(key: key);

  final OneDateTimeType type;
  final String? titleText;
  final String? hintText;
  final TextStyle? titleStyle;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final bool? isEnable;
  final Function(DateTime? dateTime, DateFormat format)? onChanged;
  final EdgeInsetsGeometry padding;
  final OneDateTimeController? controller;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool isRequired;
  final bool automaticTextAdjustment;
  final OneDateFormat? dateFormat;
  final int? maxLines;
  final String? prefixIconAssetPath;
  final Color? prefixColor;
  final OneTextFieldStyle textFieldStyle;
  final Color? borderColor;
  final bool isAlwaysShowTitle;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keyboardType;

  @override
  _OneDateTimeTextFieldSate createState() => _OneDateTimeTextFieldSate();
}

class _OneDateTimeTextFieldSate extends State<OneDateTimeTextField> with TickerProviderStateMixin {
  late OneDateTimeController _controller;
  late OneTextFieldController _txtController;
  late final StreamController<DateTime?> _selectUpdates;

  Tuple3<OneDateFormat, String, String> get _dateTime {
    final format = widget.dateFormat != null ? widget.dateFormat! : null;
    final title = widget.titleText != null ? widget.titleText! : (!widget.automaticTextAdjustment ? '' : null);
    final hint = widget.hintText != null ? widget.hintText! : (!widget.automaticTextAdjustment ? '-' : null);
    return Tuple3(format ?? widget.type.oneFm, title ?? widget.type.title, hint ?? widget.type.hint);
  }

  DateFormat get _dateFormat => _dateTime.item1.fm;
  String get _titleText => _dateTime.item2;
  String get _hintText => _dateTime.item3;
  bool? _isFocus;
  bool get _isReadOnly => _dateTime.item1 != OneDateFormat.DATE;

  TextStyle? get _labelStyle {
    if (widget.titleStyle != null) return widget.titleStyle;
    if (!isEnable) return OneTheme.of(context).textFieldLabelDisabled;
    if (_isFocus ?? false) return OneTheme.of(context).textFieldLabelFocused;
    return OneTheme.of(context).textFieldLabel;
  }

  TextStyle? get _hintStyle {
    if (widget.hintStyle != null) return widget.hintStyle;
    if (!isEnable) return OneTheme.of(context).textFieldHintDisabled;
    return OneTheme.of(context).textFieldHint;
  }

  TextStyle? get _textStyle {
    if (widget.textStyle != null) return widget.textStyle;
    if (!isEnable) return OneTheme.of(context).textFieldTextDisabled;
    return OneTheme.of(context).textFieldText;
  }

  List<TextInputFormatter>? get _inputFormatters {
    if (widget.inputFormatters != null) return widget.inputFormatters;
    return [OneMaskedTextInputFormatter()];
  }

  bool? _isEnable;
  bool get isEnable => _isEnable ?? _controller.isEnable;

  String get _suffixIconAssetPath => widget.type == OneDateTimeType.TIME ? OneIcons.ic_clock : OneIcons.ic_calendar;
  DateTime get _firstDate => widget.firstDate ?? OneDateTimeTypeExt.MIN_DATE;
  DateTime get _lastDate => widget.lastDate ?? OneDateTimeTypeExt.MAX_DATE;

  final ValueNotifier<String?> _errorText = ValueNotifier(null);
  bool get hasError => _errorText.value != null && _errorText.value!.isNotEmpty;
  late ShakeController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = ShakeController(vsync: this);
    _txtController = OneTextFieldController();
    _selectUpdates = StreamController<DateTime?>();
    _selectUpdates.stream.distinct().forEach(_onChangeUpdated);
    _isEnable = widget.isEnable;

    if (widget.controller == null) {
      _controller = OneDateTimeController(
        dateTime: DateTime.now(),
        isEnable: widget.isEnable ?? true,
      );
    } else {
      _controller = widget.controller!;
      _controller.addListener(_handleControllerChanged);
      _controller.validate = _validate;
      widget.controller!.shake = _shake;
      // if (widget.isRequired != null) widget.controller!.isRequired = widget.isRequired!;
      if (widget.isEnable != null) widget.controller!.isEnable = widget.isEnable!;
    }

    _handleShowValue();
  }

  @override
  void didUpdateWidget(OneDateTimeTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);
      if (oldWidget.controller != null && widget.controller == null) {
        _controller = OneDateTimeController.fromValue(oldWidget.controller!.value);
      }
      if (widget.controller != null) {
        if (oldWidget.controller == null) {
          _controller = OneDateTimeController(
            dateTime: DateTime.now(),
            isEnable: widget.isEnable ?? true,
          );
        }
      }
    }
    _handleShowValue();
  }

  @override
  Widget build(BuildContext context) {
    return ShakeWidget(
      controller: _shakeController,
      child: Container(
        padding: widget.padding,
        child: _buildTextField(context),
      ),
    );
  }

  Widget _buildTextField(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: _errorText,
      builder: (context, value, child) {
        return OneTextField(
          titleText: _titleText,
          titleStyle: _labelStyle,
          hintText: _hintText,
          hintStyle: _hintStyle,
          textStyle: _textStyle,
          controller: _txtController,
          suffixIconAssetPath: _suffixIconAssetPath,
          readOnly: _isReadOnly,
          onTap: _isReadOnly && isEnable ? _initDatePicker : null,
          onFiltered: (value) => _handleInput(value),
          suffixIconOnTap: isEnable ? _initDatePicker : null,
          enable: isEnable,
          errorText: value,
          isRequired: widget.isRequired,
          maxLines: widget.maxLines,
          prefixIconAssetPath: widget.prefixIconAssetPath,
          prefixColor: widget.prefixColor,
          style: widget.textFieldStyle,
          borderColor: widget.borderColor,
          isAlwaysShowTitle: widget.isAlwaysShowTitle,
          onFocusChanged: (value) {
            setState(() {
              _isFocus = value;
            });
          },
          inputFormatters: _inputFormatters,
          keyboardType: widget.keyboardType,
        );
      },
    );
  }

  void _handleInput(String value) {
    try {
      if (RegExp(OneDateTimeRegex.VALID_DATE).hasMatch(value)) {
        var dateTime = _dateFormat.parse(value);
        if (dateTime.compareTo(_firstDate) < 0) dateTime = _firstDate;
        if (dateTime.compareTo(_lastDate) > 0) dateTime = _lastDate;
        _didChange(dateTime);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    _shakeController.dispose();
    _selectUpdates.close();
    super.dispose();
  }

  void _didChange(DateTime? dateTime) {
    if (_controller.dateTime != dateTime) {
      _controller.dateTime = dateTime;
      _controller.errorText = null;
    }
    _handleShowValue();
    _selectUpdates.add(dateTime);
  }

  void _handleControllerChanged() {
    _didChange(_controller.dateTime);
    setState(() {
      _isEnable = _controller.isEnable;
      _txtController.enable = isEnable;
      _errorText.value = _controller.errorText?.trim();
    });
  }

  void _onChangeUpdated(DateTime? selected) {
    if (!mounted) return;
    if (widget.onChanged != null) {
      widget.onChanged!(selected, _dateFormat);
    }
  }

  void _handleShowValue() {
    final dateTime = _controller.dateTime;
    final value = dateTime != null ? _dateFormat.format(dateTime) : '';
    _txtController.text = value;
  }

  Future<void> _initDatePicker() async {
    var _initialDate = _controller.dateTime ?? DateTime.now();
    if (_initialDate.compareTo(_firstDate) < 0) _initialDate = _firstDate;
    if (_initialDate.compareTo(_lastDate) > 0) _initialDate = _lastDate;
    switch (widget.type) {
      case OneDateTimeType.DATE:
        final DateTime? picked = await showDatePicker(context: context, initialDate: _initialDate, firstDate: _firstDate, lastDate: _lastDate, fieldHintText: 'DD/MM/YYYY');
        if (picked != null) {
          final _dateTime = DateTime(picked.year, picked.month, picked.day, _initialDate.hour, _initialDate.minute);
          _didChange(_dateTime);
        }
        break;
      case OneDateTimeType.DATE_TIME:
        DatePicker.showDateTimePicker(
          context,
          currentTime: _initialDate,
          minTime: _firstDate,
          maxTime: _lastDate,
          onConfirm: (date) {
            _didChange(date);
          },
        );
        break;
      case OneDateTimeType.TIME:
        final TimeOfDay? picked = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(_initialDate));
        if (picked != null) {
          final _dateTime = DateTime(_initialDate.year, _initialDate.month, _initialDate.day, picked.hour, picked.minute);
          _didChange(_dateTime);
        }
        break;
      case OneDateTimeType.MONTH_YEAR:
        final DateTime? picked = await showMonthPicker(context: context, initialDate: _initialDate, firstDate: _firstDate, lastDate: _lastDate);
        if (picked != null) {
          final _dateTime = DateTime(picked.year, picked.month, picked.day, _initialDate.hour, _initialDate.minute);
          _didChange(_dateTime);
        }
        break;
      case OneDateTimeType.YEAR:
        final DateTime? picked = await showYearPicker(context: context, initialDate: _initialDate, firstDate: _firstDate, lastDate: _lastDate);
        if (picked != null) {
          final _dateTime = DateTime(picked.year, picked.month, picked.day, _initialDate.hour, _initialDate.minute);
          _didChange(_dateTime);
        }
        break;
      case OneDateTimeType.QUARTER:
        final DateTime? picked = await showQuarterlyPicker(context: context, initialDate: _initialDate, firstDate: _firstDate, lastDate: _lastDate);
        if (picked != null) {
          final _dateTime = DateTime(picked.year, picked.month, picked.day, _initialDate.hour, _initialDate.minute);
          _didChange(_dateTime);
        }
        break;
    }
  }

  bool _validate() {
    if (widget.isRequired && _txtController.text.isEmpty) {
      _errorText.value = 'Không để trống.';
      _shakeController.shake();
      return false;
    } else {
      _errorText.value = null;
    }
    return true;
  }

  void _shake({String? errorText}) {
    _errorText.value = errorText?.trim();
    if (errorText?.isNotEmpty ?? false) _shakeController.shake();
  }
}
