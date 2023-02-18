/*
 * File: one_checkbox.dart
 * File Created: Monday, 1st February 2021 1:50:40 pm
 * Author: Hieu Tran
 * -----
 * Last Modified: Monday, 1st February 2021 1:50:55 pm
 * Modified By: Hieu Tran
 */

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:one_assets/one_assets.dart';
import 'package:one_components/src/shared/constant.dart';

part 'one_checkbox_controller.dart';
part 'one_checkbox_value.dart';

class OneCheckbox extends StatefulWidget {
  const OneCheckbox({
    Key? key,
    this.enable,
    this.selected,
    this.readOnly = false,
    this.tristate = false,
    this.title,
    this.label,
    this.onChanged,
    this.padding = const EdgeInsets.fromLTRB(5, 10, 5, 10),
    this.controller,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.icSelectedUrl,
    this.icSelectedDisabledUrl,
    this.icDefaultUrl,
    this.icDefaultDisabledUrl,
  })  : assert(title == null || label == null),
        super(key: key);

  final bool? enable;
  final bool? selected;
  final bool readOnly;
  final bool tristate;
  final Widget? title;
  final String? label;
  final ValueChanged<bool?>? onChanged;
  final EdgeInsetsGeometry padding;
  final OneCheckboxController? controller;
  final CrossAxisAlignment crossAxisAlignment;

  final String? icSelectedUrl;
  final String? icSelectedDisabledUrl;
  final String? icDefaultUrl;
  final String? icDefaultDisabledUrl;

  @override
  State<StatefulWidget> createState() => _OneCheckboxState();
}

class _OneCheckboxState extends State<OneCheckbox> {
  late OneCheckboxController _controller;
  OneCheckboxController get _effectiveController => widget.controller ?? _controller;

  bool get hasLabel => widget.title != null || widget.label != null;

  bool? _enable;
  bool get enable => _enable ?? _effectiveController.enable;
  bool get selectable => !widget.readOnly && enable;

  bool? _selected;
  bool get selected => _selected ?? _effectiveController.selected;

  @override
  void initState() {
    super.initState();
    _enable = widget.enable;
    _selected = widget.selected;
    if (widget.controller == null) {
      _controller = OneCheckboxController(
        label: widget.label,
        selected: widget.selected ?? false,
        enable: widget.enable ?? true,
      );
    } else {
      if (widget.selected != null) widget.controller!.selected = widget.selected!;
      if (widget.enable != null) widget.controller!.enable = widget.enable!;
      widget.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(OneCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller = OneCheckboxController.fromValue(oldWidget.controller!.value);
      }
      if (widget.controller != null) {
        _selected = widget.controller!.selected;
        if (oldWidget.controller == null) {
          _controller = OneCheckboxController(
            label: widget.label,
            selected: widget.selected ?? false,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: enable ? _actionHandler : null,
        child: Padding(
          padding: widget.padding,
          child: Row(
            crossAxisAlignment: widget.crossAxisAlignment,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildCheckbox(),
              if (hasLabel) const SizedBox(width: 8),
              if (hasLabel) _buildLabel(context),
            ],
          ),
        ),
      ),
      color: Colors.transparent,
    );
  }

  SvgPicture _buildCheckbox() {
    switch (selected) {
      case true:
        return SvgPicture.asset(enable ? widget.icSelectedUrl ?? OneIcons.ic_checkbox_selected : widget.icSelectedDisabledUrl ?? OneIcons.ic_checkbox_selected_disabled);
      case false:
        return SvgPicture.asset(enable ? widget.icDefaultUrl ?? OneIcons.ic_checkbox_default : widget.icDefaultDisabledUrl ?? OneIcons.ic_checkbox_disabled);
      default:
        return SvgPicture.asset(enable ? widget.icSelectedUrl ?? OneIcons.ic_checkbox_selected : widget.icSelectedDisabledUrl ?? OneIcons.ic_checkbox_selected_disabled);
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

  void _actionHandler() {
    if (!selectable) return;
    switch (selected) {
      case false:
        _didChange(true);
        break;
      case true:
        _didChange(widget.tristate ? null : false);
        break;
      default: // case null:
        _didChange(false);
        break;
    }
  }

  void _didChange(bool? selected) {
    setState(() {
      _selected = selected;
    });
    if (_effectiveController.selected != selected) {
      _effectiveController.selected = selected;
    }
    if (widget.onChanged != null) {
      widget.onChanged!(selected);
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
