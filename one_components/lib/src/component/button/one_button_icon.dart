/*
 * File: one_button_circle.dart
 * File Created: Tuesday, 16th March 2021 2:28:23 pm
 * Author: Hieu Tran
 * -----
 * Last Modified: Tuesday, 16th March 2021 2:30:34 pm
 * Modified By: Hieu Tran
 */

part of 'one_button.dart';

class OneButtonIcon extends StatefulWidget {
  const OneButtonIcon({
    Key? key,
    OneButtonSize? size,
    this.onPressed,
    this.state = OneButtonState.primary,
    this.controller,
    required this.iconAssetPath,
    this.enable,
    this.color,
    this.gradient,
    this.background,
    this.textColor,
    this.isCircle = false,
  })  : size = size ?? (isCircle ? OneButtonSize.largest : OneButtonSize.middle),
        super(key: key);

  final String iconAssetPath;
  final VoidCallback? onPressed;
  final OneButtonState state;
  final OneButtonSize size;
  final OneButtonController? controller;
  final bool? enable;
  final Color? color;
  final LinearGradient? gradient;
  final Color? background;
  final Color? textColor;
  final bool isCircle;

  @override
  _OneButtonIcon createState() => _OneButtonIcon();
}

class _OneButtonIcon extends State<OneButtonIcon> {
  late OneButtonController _controller;
  OneButtonController get _effectiveController => widget.controller ?? _controller;

  bool? _enable;
  bool get enable => _enable ?? _effectiveController.enable;

  OneButtonState? _state;
  OneButtonState get state => _state ?? _effectiveController.state;

  OneVisibility? _visibility;
  OneVisibility get visibility => _visibility ?? _effectiveController.visibility;

  Color get _color => widget.color ?? OneColors.brandAneed;
  LinearGradient get _gradient {
    if (widget.gradient != null) {
      return widget.gradient!;
    } else if (widget.color != null) {
      return LinearGradient(
        colors: [widget.color!, widget.color!],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
    return OneColors.gradient;
  }

  Color get _background => widget.background ?? Colors.white;

  BorderRadiusGeometry get _borderRadius {
    return widget.isCircle ? BorderRadius.circular(_height / 2) : BorderRadius.circular(8.0);
  }

  BoxDecoration get _decoration {
    return BoxDecoration(
      color: (state != OneButtonState.outline && state != OneButtonState.borderless) || !enable ? OneColors.greyLight : _background,
      gradient: state != OneButtonState.primary || !enable ? null : _gradient,
      borderRadius: _borderRadius,
      border: state == OneButtonState.outline && enable ? Border.all(width: 1.0, color: _color) : null,
    );
  }

  Color get _textColor {
    if (!enable) {
      return OneColors.textGrey1;
    }
    switch (state) {
      case OneButtonState.primary:
        return widget.textColor ?? Colors.white;
      case OneButtonState.borderless:
      case OneButtonState.outline:
        return widget.textColor ?? _color;
      case OneButtonState.disable:
        return OneColors.textGrey1;
      default:
        return widget.textColor ?? Colors.white;
    }
  }

  double get _height {
    switch (widget.size) {
      case OneButtonSize.small:
        return 32;
      case OneButtonSize.middle:
        return 40;
      case OneButtonSize.large:
        return 48;
      case OneButtonSize.largest:
        return 56;
      default:
        return 40;
    }
  }

  @override
  void initState() {
    super.initState();
    _enable = widget.enable;
    if (widget.controller == null) {
      _controller = OneButtonController(
        state: widget.state,
      );
    } else {
      widget.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(OneButtonIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller = OneButtonController.fromValue(oldWidget.controller!.value);
      }
      if (widget.controller != null) {
        if (oldWidget.controller == null) {
          _controller = OneButtonController(
            state: widget.state,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      width: _height,
      child: ElevatedButton(
        onPressed: enable ? widget.onPressed : null,
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
            overlayColor: MaterialStateProperty.resolveWith((states) => _textColor.withOpacity(0.3)),
            backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
            foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
            shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: _borderRadius))),
        child: Ink(
          decoration: _decoration,
          child: Container(
            alignment: Alignment.center,
            child: SvgPicture.asset(widget.iconAssetPath, color: _textColor, cacheColorFilter: true),
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     height: _height,
  //     width: _height,
  //     decoration: _decoration,
  //     child: ElevatedButton(
  //       onPressed: enable ? widget.onPressed : null,
  //       style: ButtonStyle(
  //         padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
  //         overlayColor: MaterialStateProperty.resolveWith((states) {
  //           return _textColor.withOpacity(0.3);
  //         }),
  //         backgroundColor: MaterialStateProperty.resolveWith((states) {
  //           return Colors.transparent;
  //         }),
  //         foregroundColor: MaterialStateProperty.resolveWith((states) {
  //           return Colors.transparent;
  //         }),
  //         elevation: MaterialStateProperty.all(0),
  //         shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: _borderRadius)),
  //       ),
  //       child: SvgPicture.asset(widget.iconAssetPath, color: _textColor),
  //     ),
  //   );
  // }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  void _handleControllerChanged() {
    setState(() {
      _enable = _effectiveController.enable;
      _state = _effectiveController.state;
      _visibility = _effectiveController.visibility;
    });
  }
}
