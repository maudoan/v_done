/*
 * File: one_switch.dart
 * File Created: Friday, 7th May 2021 8:41:49 am
 * Author: Hieu Tran
 * -----
 * Last Modified: Friday, 7th May 2021 8:43:58 am
 * Modified By: Hieu Tran
 */

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:one_assets/one_assets.dart';
import 'package:one_components/src/shared/constant.dart';

import 'flutter_switch.dart';

part 'one_switch_controller.dart';
part 'one_switch_value.dart';

class OneSwitch extends StatefulWidget {
  const OneSwitch({
    Key? key,
    this.enable,
    required this.initialValue,
    required this.onToggle,
    this.title,
    this.label,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.controller,
  })  : assert(title == null || label == null),
        super(key: key);

  final bool? enable;
  final bool initialValue;
  final ValueChanged<bool>? onToggle;
  final Widget? title;
  final String? label;
  final OneSwitchController? controller;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  _OneSwitchState createState() => _OneSwitchState();
}

class _OneSwitchState extends State<OneSwitch> {
  late OneSwitchController _controller;
  OneSwitchController get _effectiveController => widget.controller ?? _controller;

  bool get hasLabel => widget.title != null || widget.label != null;

  bool? _enable;
  bool get enable => _enable ?? _effectiveController.enable;

  bool? _selected;
  bool get selected => _selected ?? _effectiveController.selected;

  @override
  void initState() {
    super.initState();
    _enable = widget.enable;
    if (widget.controller == null) {
      _controller = OneSwitchController(
        label: widget.label,
        selected: widget.initialValue,
        enable: widget.enable ?? true,
      );
    } else {
      _selected = widget.initialValue;
      widget.controller!.selected = _selected;
      if (widget.enable != null) widget.controller!.enable = widget.enable!;
      widget.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(OneSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller = OneSwitchController.fromValue(oldWidget.controller!.value);
      }
      if (widget.controller != null) {
        _selected = widget.controller!.selected;
        if (oldWidget.controller == null) {
          _controller = OneSwitchController(
            label: widget.label,
            selected: widget.initialValue,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: widget.crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        FlutterSwitch(
          activeGradient: OneColors.gradient,
          width: 40.0,
          height: 24.0,
          toggleSize: 18.0,
          padding: 3,
          value: selected,
          onToggle: _didChange,
          disabled: !enable,
        ),
        if (hasLabel) const SizedBox(width: 8),
        if (hasLabel) _buildLabel(context),
      ],
    );
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
          Text(
            widget.label!,
            maxLines: 2,
            overflow: TextOverflow.fade,
            style: OneTheme.of(context).body1.copyWith(
                  fontWeight: FontWeight.w600,
                  color: enable ? OneColors.textGreyDark : OneColors.textGrey1,
                ),
          ),
    );
  }

  void _didChange(bool selected) {
    setState(() {
      _selected = selected;
    });
    if (widget.onToggle != null) widget.onToggle!(selected);

    if (_effectiveController.selected != selected) {
      _effectiveController.selected = selected;
    }
  }

  void _handleControllerChanged() {
    if (_effectiveController.selected != _selected) {
      _didChange(_effectiveController.selected);
    }
    setState(() {
      _enable = _effectiveController.enable;
    });
  }
}
