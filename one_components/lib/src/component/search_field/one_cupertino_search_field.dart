/*
 * File: one_cupertino_search_field.dart
 * File Created: Wednesday, 17th March 2021 11:01:12 pm
 * Author: Hieu Tran
 * -----
 * Last Modified: Wednesday, 17th March 2021 11:03:51 pm
 * Modified By: Hieu Tran
 */

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class OneCupertinoSearchField extends StatefulWidget {
  const OneCupertinoSearchField({
    Key? key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onFiltered,
    this.duration,
  }) : super(key: key);

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onFiltered;
  final Duration? duration;

  @override
  _OneCupertinoSearchFieldState createState() => _OneCupertinoSearchFieldState();
}

class _OneCupertinoSearchFieldState extends State<OneCupertinoSearchField> {
  late TextEditingController _controller;
  TextEditingController get _effectiveController => widget.controller ?? _controller;
  final _textUpdates = StreamController<String>();
  Duration get duration => widget.duration ?? const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController();
    }
    _effectiveController.addListener(_handleControllerChanged);
    _textUpdates.stream.distinct().debounceTime(duration).forEach(_onFiltered);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      controller: _effectiveController,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
    );
  }

  @override
  void dispose() {
    _effectiveController.removeListener(_handleControllerChanged);
    _textUpdates.close();
    super.dispose();
  }

  void _handleControllerChanged() {
    _textUpdates.add(_effectiveController.text);
    // if (_effectiveController.text.trim() != _controller.text.trim()) {
    //   _effectiveController.text = _controller.text.trim();
    // }
  }

  void _onFiltered(String s) {
    if (!mounted) return;
    if (widget.onFiltered != null) {
      widget.onFiltered!(s.trim());
    }
  }
}
