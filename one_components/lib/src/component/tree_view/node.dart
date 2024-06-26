import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'tree_node.dart';
import 'tree_view.dart';
import 'utilities.dart';

/// Defines the data used to display a [TreeNode].
///
/// Used by [TreeView] to display a [TreeNode].
///
/// This object allows the creation of key, label and icon to display
/// a node on the [TreeView] widget. The key and label properties are
/// required. The key is needed for events that occur on the generated
/// [TreeNode]. It should always be unique.
class Node<T> {
  /// The unique string that identifies this object.
  final String key;

  /// The string value that is displayed on the [TreeNode].
  final String label;

  /// The string value that is displayed on the [TreeNode].
  final String? description;

  /// An optional icon that is displayed on the [TreeNode].
  final IconData? icon;

  /// An optional icon that is displayed on the [TreeNode].
  final String? iconUrl;

  /// An optional divider that is displayed on the [TreeNode].
  final bool hasDivider;

  /// The open or closed state of the [TreeNode]. Applicable only if the
  /// node is a parent
  final bool expanded;

  /// Generic data model that can be assigned to the [TreeNode]. This makes
  /// it useful to assign and retrieve data associated with the [TreeNode]
  final T? data;

  /// The sub [Node]s of this object.
  final List<Node> children;

  /// Force the node to be a parent so that node can show expander without
  /// having children node.
  final bool parent;

  const Node({
    required this.key,
    required this.label,
    this.description,
    this.children = const [],
    this.expanded = false,
    this.hasDivider = false,
    this.parent = false,
    this.icon,
    this.data,
    this.iconUrl,
  });

  /// Creates a [Node] from a string value. It generates a unique key.
  factory Node.fromLabel(String label) {
    final String _key = Utilities.generateRandom();
    return Node(
      key: '${_key}_$label',
      label: label,
    );
  }

  /// Creates a [Node] from a Map<String, dynamic> map. The map
  /// should contain a "label" value. If the key value is
  /// missing, it generates a unique key.
  /// If the expanded value, if present, can be any 'truthful'
  /// value. Excepted values include: 1, yes, true and their
  /// associated string values.
  factory Node.fromMap(Map<String, dynamic> map) {
    String? _key = map['key'];
    final String _label = map['label'];
    final String _description = map['description'];
    final _data = map['data'];
    IconData? _icon;
    List<Node> _children = [];
    _key ??= Utilities.generateRandom();
    // if (map['icon'] != null) {
    // int _iconData = int.parse(map['icon']);
    // if (map['icon'].runtimeType == String) {
    //   _iconData = int.parse(map['icon']);
    // } else if (map['icon'].runtimeType == double) {
    //   _iconData = (map['icon'] as double).toInt();
    // } else {
    //   _iconData = map['icon'];
    // }
    // _icon = const IconData(_iconData);
    // }
    if (map['children'] != null) {
      final List<Map<String, dynamic>> _childrenMap = List.from(map['children']);
      _children = _childrenMap.map((Map<String, dynamic> child) => Node.fromMap(child)).toList();
    }
    return Node(
      key: '$_key',
      label: _label,
      description: _description,
      icon: _icon,
      data: _data,
      expanded: Utilities.truthful(map['expanded']),
      parent: Utilities.truthful(map['parent']),
      children: _children,
    );
  }

  /// Creates a copy of this object but with the given fields
  /// replaced with the new values.
  Node copyWith({
    String? key,
    String? label,
    String? description,
    List<Node>? children,
    bool? expanded,
    bool? hasDivider,
    bool? parent,
    IconData? icon,
    String? iconUrl,
    T? data,
  }) =>
      Node(
        key: key ?? this.key,
        label: label ?? this.label,
        description: description ?? this.description,
        icon: icon ?? this.icon,
        expanded: expanded ?? this.expanded,
        hasDivider: hasDivider ?? this.hasDivider,
        parent: parent ?? this.parent,
        children: children ?? this.children,
        iconUrl: iconUrl ?? this.iconUrl,
        data: data ?? this.data,
      );

  /// Whether this object has children [Node].
  bool get isParent => children.isNotEmpty || parent;

  /// Whether this object has a non-null icon.
  bool get hasIcon => icon != null || (iconUrl?.isNotEmpty ?? false);

  /// Whether this object has data associated with it.
  bool get hasData => data != null;

  /// Map representation of this object
  Map<String, dynamic> get asMap {
    final Map<String, dynamic> _map = {
      'key': key,
      'label': label,
      'description': description,
      'icon': icon == null ? null : icon!.codePoint,
      'expanded': expanded,
      'parent': parent,
      'children': children.map((Node child) => child.asMap).toList(),
    };
    //TODO: figure out a means to check for getter or method on generic to include map from generic
    return _map;
  }

  @override
  String toString() {
    return const JsonEncoder().convert(asMap);
  }

  @override
  int get hashCode {
    return Object.hash(
      key,
      label,
      description,
      icon,
      iconUrl,
      expanded,
      hasDivider,
      parent,
      children,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is Node &&
        other.key == key &&
        other.label == label &&
        other.description == description &&
        other.icon == icon &&
        other.iconUrl == iconUrl &&
        other.expanded == expanded &&
        other.hasDivider == hasDivider &&
        other.parent == parent &&
        other.data.runtimeType == T &&
        other.children.length == children.length;
  }
}
