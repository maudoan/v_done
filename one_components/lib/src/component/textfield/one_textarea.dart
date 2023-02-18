/*
 * File: one_textarea.dart
 * File Created: Tuesday, 11th May 2021 7:32:56 pm
 * Author: Hieu Tran
 * -----
 * Last Modified: Tuesday, 11th May 2021 7:33:16 pm
 * Modified By: Hieu Tran
 */

part of 'one_textfield.dart';

class OneTextArea extends StatefulWidget {
  const OneTextArea({
    Key? key,
    this.titleText,
    this.titleStyle,
    this.hintText,
    this.hintStyle,
    this.errorText,
    this.textStyle,
    this.enable,
    this.keyboardType = TextInputType.text,
    this.visibility = OneVisibility.VISIBLE,
    this.controller,
    this.isRequired = false,
    this.clearable = false,
    this.readOnly = false,
    int? maxLines = 2,
    this.minLines = 2,
    this.onTapClear,
    this.suffixIconAssetPath,
    this.suffixIconOnTap,
    this.suffix,
    this.onEditingCompleted,
    this.onChanged,
    this.onFocusChanged,
    this.background,
    this.textAlign = TextAlign.start,
  })  : maxLines = maxLines != null ? (maxLines < minLines ? minLines : maxLines) : null,
        super(key: key);

  final String? titleText;
  final TextStyle? titleStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? errorText;
  final TextStyle? textStyle;
  final bool? enable;
  final TextInputType keyboardType;
  final OneVisibility visibility;
  final OneTextFieldController? controller;
  final bool isRequired;
  final bool clearable;
  final bool readOnly;
  final int? maxLines;
  final int minLines;
  final VoidCallback? onTapClear;
  final String? suffixIconAssetPath;
  final VoidCallback? suffixIconOnTap;
  final Widget? suffix;
  final ValueChanged<String>? onEditingCompleted;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? onFocusChanged;
  final Color? background;
  final TextAlign textAlign;

  @override
  _OneTextAreaState createState() => _OneTextAreaState();
}

class _OneTextAreaState extends State<OneTextArea> with TickerProviderStateMixin {
  late OneTextFieldController _controller;
  OneTextFieldController get _effectiveController => widget.controller ?? _controller;

  late TextEditingController _txtController;
  late ValueNotifier<bool> _hasText;
  late FocusNode _focusNode;

  TextStyle? get _labelStyle {
    if (widget.titleStyle != null) return widget.titleStyle;
    if (!enable) return OneTheme.of(context).textFieldLabelDisabled;
    if (_focusNode.hasFocus) return OneTheme.of(context).textFieldLabelFocused;
    return OneTheme.of(context).textFieldLabel;
  }

  String? get _hintText {
    return widget.hintText != null ? '${widget.hintText} ${widget.isRequired && !isTitleVisible ? '*' : ''}' : null;
  }

  TextStyle? get _hintStyle {
    if (!enable) return OneTheme.of(context).textFieldHintDisabled;
    return OneTheme.of(context).textFieldHint;
  }

  TextStyle? get _textStyle {
    if (!enable) return OneTheme.of(context).textFieldTextDisabled;
    return OneTheme.of(context).textFieldText;
  }

  BoxDecoration get _decoration {
    final color = _focusNode.hasFocus ? OneColors.brandAneed : OneColors.dividerGrey;
    return BoxDecoration(
      color: widget.background ?? Colors.transparent,
      borderRadius: BorderRadius.circular(5.0),
      border: Border.all(width: enable ? 1.0 : 0.5, color: color),
    );
  }

  bool? _enable;
  bool get enable => _enable ?? _effectiveController.enable;

  OneVisibility? _visibility;
  OneVisibility get visibility => _visibility ?? _effectiveController.visibility;

  bool get isClearVisible => widget.clearable && enable;
  bool get hasSuffix => widget.suffix != null;
  bool get isTitleVisible => widget.titleText != null;

  String? _errorText;
  String? get errorText => _errorText?.trim();
  bool get hasError => errorText != null && errorText!.isNotEmpty;

  late final ShakeController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = ShakeController(vsync: this);
    _txtController = TextEditingController();
    _txtController.addListener(_handleTxtControllerChanged);
    _hasText = ValueNotifier(false);
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChanged);
    _enable = widget.enable;
    _errorText = widget.errorText;

    if (widget.controller == null) {
      _controller = OneTextFieldController(
        text: _txtController.text,
        visibility: widget.visibility,
        enable: widget.enable ?? true,
      );
    } else {
      _txtController.text = widget.controller!.text;
      _visibility = widget.visibility;
      if (widget.enable != null) widget.controller!.enable = widget.enable!;
      widget.controller!.shake = _shake;
      widget.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(OneTextArea oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller = OneTextFieldController.fromValue(oldWidget.controller!.value);
      }
      if (widget.controller != null) {
        _txtController.text = widget.controller!.text;
        if (oldWidget.controller == null) {
          _controller = OneTextFieldController(
            text: _txtController.text,
            visibility: widget.visibility,
          );
        }
      }
    }
    _errorText = widget.errorText ?? _effectiveController.errorText;
  }

  @override
  Widget build(BuildContext context) {
    return ShakeWidget(
      controller: _shakeController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(),
          const SizedBox(height: 7),
          Container(
            decoration: _decoration,
            child: Row(
              children: [
                Expanded(child: _buildTextfield(context)),
                _buildSuffix(),
                const SizedBox(width: 10),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLabel() {
    return ValueListenableBuilder(
      valueListenable: _hasText,
      builder: (context, value, child) {
        return !isTitleVisible
            ? const SizedBox()
            : Text.rich(
                TextSpan(
                  style: _labelStyle,
                  children: [
                    TextSpan(text: widget.titleText),
                    if (widget.isRequired) TextSpan(text: '*', style: _labelStyle!.copyWith(color: OneColors.error)),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.fade,
              );
      },
    );
  }

  Widget _buildTextfield(BuildContext context) {
    return TextFormField(
      controller: _txtController,
      focusNode: _focusNode,
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      // showCursor: _focusNode.hasFocus,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: _hintText,
        hintStyle: _hintStyle,
        hintMaxLines: widget.maxLines ?? 2,
        errorText: errorText,
        errorStyle: OneTheme.of(context).textFieldError,
        errorMaxLines: 1,
        focusColor: OneColors.brandAneed,
        border: InputBorder.none,
        isDense: true,
        enabled: enable,
        contentPadding: const EdgeInsets.all(10),
      ),
      style: _textStyle,
      keyboardType: widget.keyboardType,
      textAlign: widget.textAlign,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        if (widget.onEditingCompleted != null) {
          widget.onEditingCompleted!(_txtController.text);
        }
      },
    );
  }

  Widget _buildSuffix() {
    final suffixIcon = widget.suffixIconAssetPath != null ? SvgPicture.asset(widget.suffixIconAssetPath!) : const SizedBox();
    final suffixIconWidget = InkWell(onTap: widget.suffixIconOnTap, child: suffixIcon);
    return Row(
      children: [
        if (isClearVisible)
          ValueListenableBuilder<bool>(
            valueListenable: _hasText,
            builder: (context, value, child) {
              return value
                  ? InkWell(
                      onTap: widget.onTapClear ?? (!widget.readOnly ? () => _txtController.clear() : null),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SvgPicture.asset(OneIcons.ic_cancel),
                      ),
                    )
                  : suffixIconWidget;
            },
          )
        else
          suffixIconWidget,
        widget.suffix ?? const SizedBox(),
      ],
    );
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    _txtController.removeListener(_handleTxtControllerChanged);
    _focusNode.removeListener(_handleFocusChanged);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleTxtControllerChanged() {
    final _txtTrim = _txtController.text.trim();
    _hasText.value = _txtTrim.isNotEmpty;
    if (_effectiveController.text.trim() != _txtTrim) {
      _effectiveController.text = _txtTrim;
    }
    if (widget.onChanged != null) {
      widget.onChanged!(_txtTrim);
    }
  }

  void _handleControllerChanged() {
    if (_effectiveController.text.trim() != _txtController.text.trim()) {
      _txtController.text = _effectiveController.text.trim();
    }

    setState(() {
      _enable = _effectiveController.enable;
      _errorText = _effectiveController.errorText?.trim();
      _visibility = _effectiveController.visibility;
    });
  }

  void _handleFocusChanged() {
    final _txtTrim = _txtController.text.trim();
    if (!_focusNode.hasFocus) if (_txtController.text != _txtTrim) _txtController.text = _txtTrim;
    if (widget.onFocusChanged != null) widget.onFocusChanged!(_focusNode.hasFocus);
    setState(() {});
  }

  void _shake({String? errorText}) {
    setState(() {
      _errorText = errorText?.trim();
      _shakeController.shake();
    });
  }
}
