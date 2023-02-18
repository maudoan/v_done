// /*
//  * File: catalog_tree_utils.dart
//  * File Created: Monday, 26th July 2021 11:28:59 am
//  * Author: Hieu Tran
//  * -----
//  * Last Modified: Monday, 26th July 2021 11:29:05 am
//  * Modified By: Hieu Tran
//  */

// import 'catalog.dart';

// List<Catalog> $loadCatalogTree(List<Catalog> list) {
//   final List<Catalog> nodes = [];
//   for (final node in list) {
//     if (node.level == 1) {
//       node.children = $loadCatalogChildren(list.where((e) => e.id != node.id || e.level != node.level).toList(), node, node.level + 1);
//       nodes.add(node);
//     } else if (node.level <= 0) {
//       nodes.add(node);
//     }
//   }
//   return nodes;
// }

// List<Catalog> $loadCatalogChildren(List<Catalog> list, Catalog parent, int level) {
//   final List<Catalog> nodes = [];
//   if (parent.numChilds! > 0) {
//     final filtered = list.where((e) => e.parentId == parent.id && e.level == level).toList();
//     for (final node in filtered) {
//       node.children = $loadCatalogChildren(list, node, node.level + 1);
//       nodes.add(node);
//     }
//   }
//   return nodes;
// }
