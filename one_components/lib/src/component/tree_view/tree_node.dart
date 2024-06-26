import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:one_assets/one_assets.dart';
import 'package:one_components/one_components.dart';

const double _kBorderWidth = 0.75;

/// Defines the [TreeNode] widget.
///
/// This widget is used to display a tree node and its children. It requires
/// a single [Node] value. It uses this node to display the state of the
/// widget. It uses the [TreeViewTheme] to handle the appearance and the
/// [TreeView] properties to handle to user actions.
///
/// __This class should not be used directly!__
/// The [TreeView] and [TreeViewController] handlers the data and rendering
/// of the nodes.
class TreeNode extends StatefulWidget {
  /// The node object used to display the widget state
  final Node node;
  final String? term;

  const TreeNode({
    Key? key,
    required this.node,
    this.term,
  }) : super(key: key);

  @override
  _TreeNodeState createState() => _TreeNodeState();
}

class _TreeNodeState extends State<TreeNode> with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween = CurveTween(curve: Curves.easeIn);
  // static double _kIconSize = 28;

  late AnimationController _controller;
  late Animation<double> _heightFactor;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _isExpanded = widget.node.expanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.duration = TreeView.of(context)!.theme.expandSpeed;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(TreeNode oldWidget) {
    if (widget.node.expanded != oldWidget.node.expanded) {
      setState(() {
        _isExpanded = widget.node.expanded;
        if (_isExpanded) {
          _controller.forward();
        } else {
          _controller.reverse().then<void>((void value) {
            if (!mounted) return;
            setState(() {});
          });
        }
      });
    } else if (widget.node != oldWidget.node) {
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  void _handleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {});
        });
      }
    });
    TreeView.of(context)!.onExpansionChanged!(widget.node.key, _isExpanded);
  }

  void _handleTap() {
    final TreeView? _treeView = TreeView.of(context);
    assert(_treeView != null, 'TreeView must exist in context');
    _treeView!.onNodeTap!(widget.node.key);
  }

  void _handleDoubleTap() {
    final TreeView? _treeView = TreeView.of(context);
    assert(_treeView != null, 'TreeView must exist in context');
    _treeView!.onNodeDoubleTap!(widget.node.key);
  }

  Widget _buildDivider() {
    return widget.node.hasDivider ? const Divider(color: OneColors.dividerGrey, thickness: 1) : const SizedBox();
  }

  Widget _buildNodeExpander() {
    final TreeView? _treeView = TreeView.of(context);
    final TreeViewTheme _theme = _treeView!.theme;
    return widget.node.isParent
        ? GestureDetector(
            onTap: () => _handleExpand(),
            child: _TreeNodeExpander(
              speed: _controller.duration ?? Duration.zero,
              expanded: widget.node.expanded,
              themeData: _theme.expanderTheme,
            ),
          )
        : Container(
            width: 10,
          );
  }

  Widget _buildNodeIcon() {
    final TreeView? _treeView = TreeView.of(context);
    final TreeViewTheme _theme = _treeView!.theme;
    final bool isSelected = _treeView.controller.selectedKey == widget.node.key;
    return Container(
      alignment: Alignment.center,
      width: widget.node.hasIcon ? (_theme.iconTheme.size ?? 0) + _theme.iconPadding : 0,
      child: widget.node.hasIcon
          ? (widget.node.icon != null
              ? Icon(
                  widget.node.icon,
                  size: _theme.iconTheme.size,
                  color: isSelected ? _theme.colorScheme.onPrimary : _theme.iconTheme.color,
                )
              : SvgPicture.asset(widget.node.iconUrl!))
          : null,
    );
  }

  Widget _buildNodeLabel() {
    final TreeView? _treeView = TreeView.of(context);
    assert(_treeView != null, 'TreeView must exist in context');
    final TreeViewTheme _theme = _treeView!.theme;
    final bool isSelected = _treeView.controller.selectedKey != null && _treeView.controller.selectedKey == widget.node.key;
    final icon = _buildNodeIcon();
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: _theme.verticalSpacing ?? (_theme.dense ? 10 : 15),
        horizontal: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          icon,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SubstringHighlight(
                  text: widget.node.label,
                  term: widget.term,
                  softWrap: widget.node.isParent ? _theme.parentLabelOverflow == null : _theme.labelOverflow == null,
                  overflow: widget.node.isParent ? _theme.parentLabelOverflow : _theme.labelOverflow,
                  textStyle: widget.node.isParent
                      ? _theme.parentLabelStyle.copyWith(
                          fontWeight: _theme.parentLabelStyle.fontWeight,
                          color: isSelected ? _theme.colorScheme.onPrimary : _theme.parentLabelStyle.color,
                        )
                      : _theme.labelStyle.copyWith(
                          fontWeight: _theme.labelStyle.fontWeight,
                          color: isSelected ? _theme.colorScheme.onPrimary : null,
                        ),
                ),
                if (widget.node.description?.isNotEmpty ?? false)
                  SubstringHighlight(
                    text: widget.node.description!,
                    term: widget.term,
                    softWrap: _theme.labelOverflow == null,
                    overflow: _theme.labelOverflow,
                    textStyle: _theme.labelStyle.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                      color: OneColors.textGrey2,
                    ),
                  )
              ],
            ),

            // Text(
            //   widget.node.label,
            //   softWrap: widget.node.isParent ? _theme.parentLabelOverflow == null : _theme.labelOverflow == null,
            //   overflow: widget.node.isParent ? _theme.parentLabelOverflow : _theme.labelOverflow,
            //   style: widget.node.isParent
            //       ? _theme.parentLabelStyle.copyWith(
            //           fontWeight: _theme.parentLabelStyle.fontWeight,
            //           color: isSelected ? _theme.colorScheme.onPrimary : _theme.parentLabelStyle.color,
            //         )
            //       : _theme.labelStyle.copyWith(
            //           fontWeight: _theme.labelStyle.fontWeight,
            //           color: isSelected ? _theme.colorScheme.onPrimary : null,
            //         ),
            // ),
          ),
        ],
      ),
    );
  }

  Widget _buildNodeWidget() {
    final TreeView? _treeView = TreeView.of(context);
    assert(_treeView != null, 'TreeView must exist in context');
    final TreeViewTheme _theme = _treeView!.theme;
    final bool isSelected = _treeView.controller.selectedKey != null && _treeView.controller.selectedKey == widget.node.key;
    final bool canSelectParent = _treeView.allowParentSelect;
    final divider = _buildDivider();
    final arrowContainer = _buildNodeExpander();
    final labelContainer = _treeView.nodeBuilder != null ? _treeView.nodeBuilder!(context, widget.node) : _buildNodeLabel();
    Widget _tappable = _treeView.onNodeDoubleTap != null
        ? InkWell(
            hoverColor: Colors.blue,
            onTap: _handleTap,
            onDoubleTap: _handleDoubleTap,
            child: labelContainer,
          )
        : InkWell(
            hoverColor: Colors.blue,
            onTap: _handleTap,
            child: labelContainer,
          );
    if (widget.node.isParent) {
      if (_treeView.supportParentDoubleTap && canSelectParent) {
        _tappable = InkWell(
          onTap: canSelectParent ? _handleTap : _handleExpand,
          onDoubleTap: () {
            _handleExpand();
            _handleDoubleTap();
          },
          child: labelContainer,
        );
      } else if (_treeView.supportParentDoubleTap) {
        _tappable = InkWell(
          onTap: _handleExpand,
          onDoubleTap: _handleDoubleTap,
          child: labelContainer,
        );
      } else {
        _tappable = InkWell(
          onTap: canSelectParent ? _handleTap : _handleExpand,
          child: labelContainer,
        );
      }
    }
    return Container(
      color: isSelected ? _theme.colorScheme.primary : null,
      child: Column(
        children: [
          divider,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _theme.expanderTheme.position == ExpanderPosition.end
                ? [
                    Expanded(
                      child: _tappable,
                    ),
                    arrowContainer,
                  ]
                : [
                    arrowContainer,
                    Expanded(
                      child: _tappable,
                    ),
                  ],
          ),
        ],
      ),
    );
  }

  Widget _animatedBuilder(BuildContext context, Widget? child) {
    final nodeWidget = _buildNodeWidget();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        nodeWidget,
        ClipRect(
          child: Align(
            heightFactor: _heightFactor.value,
            child: child,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final TreeView? _treeView = TreeView.of(context);
    final bool closed = (!_isExpanded || !widget.node.expanded) && _controller.isDismissed;
    return widget.node.isParent
        ? AnimatedBuilder(
            animation: _controller.view,
            builder: _animatedBuilder,
            child: closed
                ? null
                : Container(
                    margin: EdgeInsets.only(
                      left: _treeView!.theme.horizontalSpacing ?? _treeView.theme.iconTheme.size ?? 0,
                    ),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: widget.node.children.map((Node node) {
                          return Column(
                            children: [
                              // if (node.hasDivider) const Divider(color: OneColors.dividerGrey, thickness: 1),
                              TreeNode(node: node, term: widget.term),
                            ],
                          );
                        }).toList()),
                  ),
          )
        : Container(child: _buildNodeWidget());
  }
}

class _TreeNodeExpander extends StatefulWidget {
  final bool expanded;
  final ExpanderThemeData? themeData;
  final Duration _expandSpeed;

  const _TreeNodeExpander({
    required Duration speed,
    this.themeData,
    this.expanded = false,
  }) : _expandSpeed = speed;

  @override
  _TreeNodeExpanderState createState() => _TreeNodeExpanderState();
}

class _TreeNodeExpanderState extends State<_TreeNodeExpander> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    final bool isEnd = widget.themeData!.position == ExpanderPosition.end;
    if (widget.themeData!.type != ExpanderType.plusMinus) {
      controller = AnimationController(
        duration: widget.themeData!.animated
            ? isEnd
                ? widget._expandSpeed * 0.625
                : widget._expandSpeed
            : const Duration(milliseconds: 0),
        vsync: this,
      );
      animation = Tween<double>(
        begin: 0,
        end: isEnd ? 180 : 90,
      ).animate(controller);
    } else {
      controller = AnimationController(duration: const Duration(milliseconds: 0), vsync: this);
      animation = Tween<double>(begin: 0, end: 0).animate(controller);
    }
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(_TreeNodeExpander oldWidget) {
    if (widget.themeData != oldWidget.themeData || widget.expanded != oldWidget.expanded) {
      final bool isEnd = widget.themeData!.position == ExpanderPosition.end;
      setState(() {
        if (widget.themeData!.type != ExpanderType.plusMinus) {
          controller.duration = widget.themeData!.animated
              ? isEnd
                  ? widget._expandSpeed * 0.625
                  : widget._expandSpeed
              : const Duration(milliseconds: 0);
          animation = Tween<double>(
            begin: 0,
            end: isEnd ? 180 : 90,
          ).animate(controller);
        } else {
          controller.duration = const Duration(milliseconds: 0);
          animation = Tween<double>(begin: 0, end: 0).animate(controller);
        }
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  Color? _onColor(Color? color) {
    if (color != null) {
      if (color.computeLuminance() > 0.6) {
        return Colors.black;
      } else {
        return Colors.white;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    IconData _arrow;
    double _iconSize = widget.themeData!.size;
    double _borderWidth = 0;
    BoxShape _shapeBorder = BoxShape.rectangle;
    Color? _backColor = Colors.transparent;
    Color? _iconColor = widget.themeData!.color ?? Theme.of(context).iconTheme.color;
    switch (widget.themeData!.modifier) {
      case ExpanderModifier.none:
        break;
      case ExpanderModifier.circleFilled:
        _shapeBorder = BoxShape.circle;
        _backColor = widget.themeData!.color ?? Colors.black;
        _iconColor = _onColor(_backColor);
        break;
      case ExpanderModifier.circleOutlined:
        _borderWidth = _kBorderWidth;
        _shapeBorder = BoxShape.circle;
        break;
      case ExpanderModifier.squareFilled:
        _backColor = widget.themeData!.color ?? Colors.black;
        _iconColor = _onColor(_backColor);
        break;
      case ExpanderModifier.squareOutlined:
        _borderWidth = _kBorderWidth;
        break;
    }
    switch (widget.themeData!.type) {
      case ExpanderType.chevron:
        _arrow = Icons.expand_less;
        break;
      case ExpanderType.arrow:
        _arrow = Icons.arrow_downward;
        _iconSize = widget.themeData!.size > 20 ? widget.themeData!.size - 8 : widget.themeData!.size;
        break;
      case ExpanderType.caret:
        _arrow = Icons.arrow_drop_down;
        break;
      case ExpanderType.plusMinus:
        _arrow = widget.expanded ? Icons.remove : Icons.add;
        break;
    }

    final Icon _icon = Icon(
      _arrow,
      size: _iconSize,
      color: _iconColor,
    );

    if (widget.expanded) {
      controller.reverse();
    } else {
      controller.forward();
    }
    return Container(
      width: widget.themeData!.size + 2,
      height: widget.themeData!.size + 2,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: _shapeBorder,
        border: _borderWidth == 0
            ? null
            : Border.all(
                width: _borderWidth,
                color: widget.themeData!.color ?? Colors.black,
              ),
        color: _backColor,
      ),
      child: AnimatedBuilder(
        animation: controller,
        child: _icon,
        builder: (context, child) {
          return Transform.rotate(
            angle: animation.value * (-pi / 180),
            child: child,
          );
        },
      ),
    );
  }
}
