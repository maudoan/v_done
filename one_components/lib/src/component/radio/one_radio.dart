/*
 * File: one_radio.dart
 * File Created: Monday, 25th January 2021 9:47:45 pm
 * Author: Hieu Tran
 * -----
 * Last Modified: Monday, 25th January 2021 10:28:11 pm
 * Modified By: Hieu Tran
 */

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:one_assets/one_assets.dart';
import 'package:one_components/one_components.dart';

part 'one_radio_controller.dart';
part 'one_radio_value.dart';

class OneRadio<T> extends StatefulWidget {
  const OneRadio({
    Key? key,
    required this.radioValue,
    this.title,
    this.label,
    this.groupListenable,
    this.onChanged,
    this.onSelected,
    this.padding = const EdgeInsets.fromLTRB(5, 10, 5, 10),
    this.controller,
    this.textSize = OneTextSize.middle,
    this.enable,
    this.readOnly = false,
    this.term,
    this.icSelectedUrl,
    this.icSelectedDisabledUrl,
    this.icDefaultUrl,
    this.icDefaultDisabledUrl,
    this.maxLines = 2,
  })  : assert(radioValue != null),
        assert(title == null || label == null),
        assert(groupListenable != null || controller != null),
        super(key: key);

  final T radioValue;
  final ValueNotifier<T>? groupListenable;
  final Widget? title;
  final String? label;
  final ValueChanged<T>? onChanged;
  final ValueChanged<T>? onSelected;
  final EdgeInsetsGeometry padding;
  final OneRadioController<T>? controller;
  final OneTextSize textSize;
  final bool? enable;
  final bool readOnly;
  final String? term;

  final String? icSelectedUrl;
  final String? icSelectedDisabledUrl;
  final String? icDefaultUrl;
  final String? icDefaultDisabledUrl;
  final int maxLines;

  @override
  _OneRadioState<T> createState() => _OneRadioState<T>();
}

class _OneRadioState<T> extends State<OneRadio<T>> {
  late OneRadioController _controller;
  OneRadioController get _effectiveController => widget.controller ?? _controller;

  bool get hasLabel => widget.title != null || widget.label != null;

  bool? _enable;
  bool get enable => _enable ?? _effectiveController.enable;
  bool get selectable => !widget.readOnly && enable;

  ValueNotifier<T?>? _groupListenable;
  ValueNotifier<T?> get groupListenable => _groupListenable ?? _effectiveController.groupListenable as ValueNotifier<T?>;

  bool get selected => widget.radioValue == groupListenable.value;

  TextStyle get _textStyle {
    var style = OneTheme.of(context).body1;
    if (widget.textSize == OneTextSize.large) style = OneTheme.of(context).title1;
    if (widget.textSize == OneTextSize.small) style = OneTheme.of(context).caption1;
    return style.copyWith(
      fontWeight: FontWeight.w600,
      color: enable ? OneColors.textGreyDark : OneColors.textGrey1,
    );
  }

  @override
  void initState() {
    super.initState();
    _enable = widget.enable;
    if (widget.controller == null) {
      _controller = OneRadioController(
        label: widget.label,
        groupListenable: widget.groupListenable!,
        enable: widget.enable ?? true,
      );
    } else {
      if (widget.enable != null) widget.controller!.enable = widget.enable!;
      widget.controller!.addListener(_handleControllerChanged);
    }
    _groupListenable = _effectiveController.groupListenable as ValueNotifier<T?>?;
  }

  @override
  void didUpdateWidget(OneRadio<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller = OneRadioController.fromValue(oldWidget.controller!.value);
      }
      if (widget.controller != null) {
        _groupListenable = widget.controller!.groupListenable;
        if (oldWidget.controller == null) {
          _controller = OneRadioController(
            label: widget.label,
            groupListenable: widget.groupListenable!,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: groupListenable,
      builder: (context, dynamic value, child) {
        return Material(
          child: InkWell(
            onTap: enable ? _actionHandler : null,
            child: Padding(
              padding: widget.padding,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildRadio(),
                  if (hasLabel) const SizedBox(width: 8),
                  if (hasLabel) _buildLabel(context),
                ],
              ),
            ),
          ),
          color: Colors.transparent,
        );
      },
    );
  }

  SvgPicture _buildRadio() {
    if (selected) {
      return SvgPicture.asset(enable ? widget.icSelectedUrl ?? OneIcons.ic_radiobutton_selected : widget.icSelectedDisabledUrl ?? OneIcons.ic_radiobutton_selected_disabled);
    } else {
      return SvgPicture.asset(enable ? widget.icDefaultUrl ?? OneIcons.ic_radiobutton_default : widget.icDefaultDisabledUrl ?? OneIcons.ic_radiobutton_disabled);
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  Widget _buildLabel(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: widget.title ??
          SubstringHighlight(
            text: widget.label!,
            maxLines: widget.maxLines,
            overflow: TextOverflow.fade,
            textStyle: _textStyle,
            term: widget.term,
          ),
    );
  }

  void _actionHandler() {
    if (!selectable) return;
    if (widget.radioValue != groupListenable.value) {
      _didChange(widget.radioValue);
    }
    if (widget.onSelected != null) {
      widget.onSelected!(widget.radioValue);
    }
  }

  void _didChange(T value) {
    groupListenable.value = value;
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
    if (_effectiveController.groupListenable != groupListenable) {
      _effectiveController.groupListenable = groupListenable;
    }
  }

  void _handleControllerChanged() {
    if (_effectiveController.groupListenable != _groupListenable) {
      _groupListenable = _effectiveController.groupListenable as ValueNotifier<T?>?;
      _didChange(_effectiveController.groupListenable.value);
    }

    setState(() {
      _enable = _effectiveController.enable;
    });
  }
}
