/*
 * File: one_textfield_dropdown.dart
 * File Created: Wednesday, 30th June 2021 12:52:58 pm
 * Author: Hieu Tran
 * -----
 * Last Modified: Wednesday, 30th June 2021 1:16:24 pm
 * Modified By: Hieu Tran
 */

part of 'one_textfield.dart';

class OneTextFieldDropdown<T> extends StatefulWidget {
  const OneTextFieldDropdown({
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
    this.padding,
    this.controller,
    this.isRequired,
    this.isAlwaysShowTitle = true,
    this.clearable = false,
    this.readOnly = false,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.onTap,
    this.onTapClear,
    this.suffixIconAssetPath,
    this.suffixIconOnTap,
    this.prefixIconAssetPath,
    this.prefixColor,
    this.onEditingCompleted,
    this.onChanged,
    this.onFocusChanged,
    this.onFiltered,
    this.filterDuration,
    this.orientation = OneOrientation.VERTICAL,
    this.labelFlex = 1,
    this.textFlex = 1,
    this.textAlign = TextAlign.start,
    this.style = OneTextFieldStyle.underline,
    this.inputFormatters,
    this.onBeginSuggestion,
    required this.suggestionsCallback,
    required this.onSuggestionSelected,
  })  : assert(!obscureText || maxLines == 1, 'Obscured fields cannot be multiline.'),
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
  final EdgeInsetsGeometry? padding;
  final OneTextFieldController? controller;
  final bool? isRequired;
  final bool isAlwaysShowTitle;
  final bool clearable;
  final bool readOnly;
  final bool obscureText;
  final int? maxLines;
  final int minLines;
  final VoidCallback? onTap;
  final VoidCallback? onTapClear;
  final String? suffixIconAssetPath;
  final VoidCallback? suffixIconOnTap;
  final String? prefixIconAssetPath;
  final Color? prefixColor;
  final ValueChanged<String>? onEditingCompleted;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? onFocusChanged;
  final ValueChanged<String>? onFiltered;
  final Duration? filterDuration;
  final OneOrientation orientation;
  final int labelFlex;
  final int textFlex;
  final TextAlign textAlign;
  final OneTextFieldStyle style;
  final List<TextInputFormatter>? inputFormatters;

  final bool Function()? onBeginSuggestion;
  final SuggestionsCallback<T> suggestionsCallback;
  final void Function(T) onSuggestionSelected;

  @override
  _OneTextFieldDropdownState<T> createState() => _OneTextFieldDropdownState<T>();
}

class _OneTextFieldDropdownState<T> extends State<OneTextFieldDropdown<T>> with TickerProviderStateMixin {
  late OneTextFieldController _controller;
  OneTextFieldController get _effectiveController => widget.controller ?? _controller;

  late final TextEditingController _txtController;
  late final StreamController<String> _textUpdates;
  late final ValueNotifier<bool> _hasText;
  late final FocusNode _focusNode;

  TextStyle? get _labelStyle {
    if (widget.orientation == OneOrientation.HORIZONTAL) {
      if (widget.titleStyle != null) return widget.titleStyle;
      if (!enable) return OneTheme.of(context).textFieldLabelHorizDisabled;
      if (_focusNode.hasFocus) return OneTheme.of(context).textFieldLabelHorizFocused;
      return OneTheme.of(context).textFieldLabelHoriz;
    }
    if (widget.titleStyle != null) return widget.titleStyle;
    if (!enable) return OneTheme.of(context).textFieldLabelDisabled;
    if (_focusNode.hasFocus) return OneTheme.of(context).textFieldLabelFocused;
    return OneTheme.of(context).textFieldLabel;
  }

  String? get _hintText {
    return widget.hintText != null ? '${widget.hintText} ${isRequired && !isTitleVisible ? '* ' : ''}' : '';
  }

  TextStyle? get _hintStyle {
    if (widget.hintStyle != null) return widget.hintStyle;
    if (!enable) return OneTheme.of(context).textFieldHintDisabled;
    return OneTheme.of(context).textFieldHint;
  }

  TextStyle? get _textStyle {
    if (widget.textStyle != null) return widget.textStyle;
    if (!enable) return OneTheme.of(context).textFieldTextDisabled;
    return OneTheme.of(context).textFieldText;
  }

  InputBorder? get _enabledBorder {
    switch (widget.style) {
      case OneTextFieldStyle.underline:
        return UnderlineInputBorder(
          borderSide: BorderSide(color: OneColors.textGrey1.withOpacity(0.5)),
        );
      case OneTextFieldStyle.outline:
        return OutlineInputBorder(
          borderSide: BorderSide(color: OneColors.textGrey1.withOpacity(0.5)),
        );
      case OneTextFieldStyle.none:
        return const UnderlineInputBorder(borderSide: BorderSide.none);
    }
  }

  InputBorder? get _focusedBorder {
    switch (widget.style) {
      case OneTextFieldStyle.underline:
        return const UnderlineInputBorder(
          borderSide: BorderSide(color: OneColors.brandAneed),
        );
      case OneTextFieldStyle.outline:
        return const OutlineInputBorder(
          borderSide: BorderSide(color: OneColors.brandAneed),
        );
      case OneTextFieldStyle.none:
        return const UnderlineInputBorder(borderSide: BorderSide.none);
    }
  }

  EdgeInsets? get _contentPadding {
    switch (widget.style) {
      case OneTextFieldStyle.underline:
        return EdgeInsets.fromLTRB(hasPrefix ? 31 : 0, 2, hasSuffix ? 24 : 0, 6);
      case OneTextFieldStyle.outline:
        return EdgeInsets.fromLTRB(hasPrefix ? 41 : 10, 10, hasSuffix ? 24 : 10, 10);
      case OneTextFieldStyle.none:
        return EdgeInsets.fromLTRB(hasPrefix ? 31 : 0, 2, hasSuffix ? 24 : 0, 6);
    }
  }

  Duration get filterDuration => widget.filterDuration ?? const Duration(milliseconds: 500);

  bool? _enable;
  bool get enable => _enable ?? _effectiveController.enable;

  OneVisibility? _visibility;
  OneVisibility get visibility => _visibility ?? _effectiveController.visibility;

  bool get isClearVisible => widget.clearable && enable;
  bool get hasSuffix => isClearVisible || widget.suffixIconAssetPath != null;
  bool get hasTitle => widget.titleText != null;
  bool get isTitleVisible => widget.titleText != null && (widget.isAlwaysShowTitle || _focusNode.hasFocus || _hasText.value);

  String? _errorText;
  String? get errorText => _errorText?.trim();
  bool get hasError => errorText != null && errorText!.isNotEmpty;

  bool? _isRequired;
  bool get isRequired => _isRequired ?? _effectiveController.isRequired;

  late final ShakeController _shakeController;

  Color? get prefixColor => widget.prefixColor;
  String? get prefixIconAssetPath => widget.prefixIconAssetPath?.trim();
  bool get hasPrefix => prefixIconAssetPath != null;

  @override
  void initState() {
    super.initState();
    _shakeController = ShakeController(vsync: this);
    _txtController = TextEditingController();
    _txtController.addListener(_handleTxtControllerChanged);
    _textUpdates = StreamController<String>();
    _textUpdates.stream.distinct().debounceTime(filterDuration).forEach(_onFiltered);
    _hasText = ValueNotifier(false);
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChanged);
    _enable = widget.enable;
    _isRequired = widget.isRequired;
    _errorText = widget.errorText;

    if (widget.controller == null) {
      _controller = OneTextFieldController(
        text: _txtController.text,
        visibility: widget.visibility,
        enable: widget.enable ?? true,
        isRequired: widget.isRequired ?? false,
      );
    } else {
      _txtController.text = widget.controller!.text;
      _visibility = widget.visibility;
      if (widget.isRequired != null) widget.controller!.isRequired = widget.isRequired!;
      if (widget.enable != null) widget.controller!.enable = widget.enable!;
      widget.controller!.shake = _shake;
      widget.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(OneTextFieldDropdown<T> oldWidget) {
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
      child: widget.orientation == OneOrientation.HORIZONTAL ? _buildHorizontal(context) : _buildVertical(context),
    );
  }

  Widget _buildVertical(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasTitle) ...[_buildLabel(), const SizedBox(height: 7)],
        Stack(
          clipBehavior: Clip.none,
          children: [
            if (hasPrefix) _buildPrefix(),
            _buildDropdownField(context),
            _buildSuffix(),
          ],
        ),
      ],
    );
  }

  Widget _buildHorizontal(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasTitle) ...[
          Expanded(
            flex: widget.labelFlex,
            child: _buildLabel(OneOrientation.HORIZONTAL),
          ),
          const SizedBox(width: 7)
        ],
        Expanded(
          flex: widget.textFlex,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              if (hasPrefix) _buildPrefix(),
              _buildDropdownField(context),
              _buildSuffix(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildLabel([OneOrientation orientation = OneOrientation.VERTICAL]) {
    return ValueListenableBuilder(
      valueListenable: _hasText,
      builder: (context, value, child) {
        return !isTitleVisible
            ? const SizedBox(height: 15)
            : Text.rich(
                TextSpan(
                  style: _labelStyle,
                  children: [
                    TextSpan(text: widget.titleText),
                    if (isRequired && isTitleVisible) TextSpan(text: '*', style: _labelStyle!.copyWith(color: OneColors.error)),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.fade,
              );
      },
    );
  }

  Widget _buildDropdownField(BuildContext context) {
    return TypeAheadField<T>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: _txtController,
        focusNode: _focusNode,
        maxLines: widget.maxLines ?? 1,
        style: _textStyle,
        obscureText: widget.obscureText,
        onTap: widget.onTap,
        enabled: enable,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: _hintText,
          labelStyle: _labelStyle,
          hintStyle: _hintStyle,
          hintMaxLines: widget.maxLines,
          errorText: errorText,
          errorStyle: OneTheme.of(context).textFieldError,
          errorMaxLines: 1,
          focusColor: OneColors.brandAneed,
          focusedBorder: _focusedBorder,
          enabledBorder: _enabledBorder,
          isDense: true,
          contentPadding: _contentPadding,
          enabled: enable,
        ),
      ),
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.white,
        shadowColor: OneColors.shadow.withOpacity(0.2),
      ),
      hideOnEmpty: true,
      hideKeyboard: widget.readOnly,
      suggestionsCallback: (pattern) async {
        bool _allowSuggestion = true;
        if (widget.onBeginSuggestion != null) _allowSuggestion = widget.onBeginSuggestion!();
        if (!_allowSuggestion) {
          _focusNode.unfocus();
          return [];
        }
        try {
          final suggestion = await widget.suggestionsCallback(pattern);
          return suggestion;
        } catch (e) {
          _focusNode.unfocus();
          return [];
        }
      },
      autoFlipDirection: true,
      loadingBuilder: (context) {
        return Container(
          height: 50,
          child: const SpinKitCircle(
            color: Colors.black45,
            size: 40.0,
          ),
        );
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion.toString(), style: OneTheme.of(context).body2),
        );
      },
      onSuggestionSelected: widget.onSuggestionSelected,
    );
  }

  Widget _buildSuffix() {
    final suffixIcon = widget.suffixIconAssetPath != null ? SvgPicture.asset(widget.suffixIconAssetPath!) : const SizedBox();
    final suffixIconWidget = InkWell(
        onTap: () {
          if (widget.suffixIconOnTap != null) widget.suffixIconOnTap!();
          _focusNode.requestFocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: suffixIcon,
        ));
    return Positioned.fill(
      right: -3.0,
      child: Align(
        alignment: Alignment.topRight,
        child: isClearVisible
            ? ValueListenableBuilder<bool>(
                valueListenable: _hasText,
                builder: (context, value, child) {
                  return value
                      ? InkWell(
                          onTap: widget.onTapClear ?? (!widget.readOnly ? () => _txtController.clear() : null),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: SvgPicture.asset(OneIcons.ic_cancel),
                          ),
                        )
                      : suffixIconWidget;
                },
              )
            : suffixIconWidget,
      ),
    );
  }

  Widget _buildPrefix() {
    final prefixIcon = SvgPicture.asset(
      prefixIconAssetPath!,
      color: prefixColor,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.style == OneTextFieldStyle.outline) const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            prefixIcon,
          ],
        ),
      ],
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
    if (_effectiveController.text.trim() != _txtTrim) {
      _effectiveController.text = _txtTrim;
    }
    _textUpdates.add(_txtTrim);
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
      _isRequired = _effectiveController.isRequired;
    });
  }

  void _onFiltered(String s) {
    if (!mounted) return;
    if (widget.onFiltered != null) {
      widget.onFiltered!(s.trim());
    }
  }

  void _handleFocusChanged() {
    final _txtTrim = _txtController.text.trim();
    if (!_focusNode.hasFocus) if (_txtController.text != _txtTrim) _txtController.text = _txtTrim;
    if (widget.onFocusChanged != null) widget.onFocusChanged!(_focusNode.hasFocus);
  }

  void _shake({String? errorText}) {
    setState(() {
      _errorText = errorText?.trim();
      _shakeController.shake();
    });
  }
}
