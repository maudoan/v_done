/*
 * File: one_datagridview.dart
 * File Created: Saturday, 23rd October 2021 8:52:53 am
 * Author: Dương Trí
 * -----
 * Last Modified: Saturday, 23rd October 2021 5:56:17 pm
 * Modified By: Dương Trí
 */

import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:one_assets/one_assets.dart';

import 'data_cell_table.dart';

class OneDataGridView extends StatefulWidget {
  const OneDataGridView({
    Key? key,
    // required this.cellWidget,
    required this.width,
    required this.listHeader,
    required this.listData,
  }) : super(key: key);

  // final Widget cellWidget;
  final double width;
  final List<DataCellTable> listHeader;
  final List<List<String>> listData;

  @override
  _OneDataGridViewState createState() => _OneDataGridViewState();
}

class _OneDataGridViewState extends State<OneDataGridView> {
  // Define table scroll controler
  late LinkedScrollControllerGroup _tableLinkedScrollControllers;
  late ScrollController _headerController;
  late ScrollController _bodyController;

  // Define body scroll controller
  late LinkedScrollControllerGroup _bodyLinkedScrollControllers;
  late ScrollController _cellDataController;

  // Widget get _cellWidget => widget.cellWidget;
  double get _width => widget.width;

  List<DataCellTable> get _listHeader => widget.listHeader;
  List<List<String>> get _listData => widget.listData;

  @override
  void initState() {
    super.initState();
    _tableLinkedScrollControllers = LinkedScrollControllerGroup();
    _headerController = _tableLinkedScrollControllers.addAndGet();
    _bodyController = _tableLinkedScrollControllers.addAndGet();
    _bodyLinkedScrollControllers = LinkedScrollControllerGroup();
    _cellDataController = _bodyLinkedScrollControllers.addAndGet();
  }

  @override
  void dispose() {
    _headerController.dispose();
    _bodyController.dispose();
    _cellDataController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(height: _listHeader.first.height ?? 50, child: _buildTableHeader(context)),
            Expanded(child: _buildTableBody(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader(BuildContext context) {
    return SizedBox(
      width: _width,
      child: Row(
        children: [
          Expanded(
            child: ListView(
              controller: _headerController,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: List.generate(_listHeader.length, (index) {
                return _buildTableCell(
                  value: _listHeader[index].value,
                  width: _listHeader[index].width,
                  color: _listHeader[index].headerBackground,
                  align: _listHeader[index].headerAlign,
                  fontWeight: _listHeader[index].headerFontWeight,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableBody(BuildContext context) {
    return Scrollbar(
      thumbVisibility: false,
      radius: const Radius.circular(8),
      thickness: 8.0,
      child: RefreshIndicator(
        notificationPredicate: (ScrollNotification notification) {
          return notification.depth == 0 || notification.depth == 1;
        },
        onRefresh: () async {
          await Future.delayed(
            const Duration(seconds: 2),
          );
        },
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _bodyController,
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                child: SizedBox(
                  width: _width,
                  child: ListView(
                    padding: const EdgeInsets.only(top: 0),
                    controller: _cellDataController,
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    children: List.generate(_listData.length, (rowIndex) {
                      return Row(
                        children: List.generate(_listHeader.length, (columnIndex) {
                          return _buildTableCell(
                            value: _listData[rowIndex][columnIndex],
                            width: _listHeader[columnIndex].width,
                            color: rowIndex.isEven ? Colors.white : OneColors.bgChildItem,
                            align: _listHeader[columnIndex].rowAlign,
                            textColor: _listHeader[columnIndex].rowColor,
                          );
                        }),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableCell({
    required String value,
    required double width,
    double? height,
    Color? color,
    AlignmentGeometry? align,
    double? fontSize,
    FontWeight? fontWeight,
    Color? textColor,
  }) {
    return Container(
        padding: const EdgeInsets.all(8),
        width: width,
        height: height ?? 50,
        decoration: BoxDecoration(
          color: color,
          border: const Border(
            bottom: BorderSide(width: 1.0, color: OneColors.bgLine),
          ),
        ),
        alignment: align ?? Alignment.centerLeft,
        child: Text(
          '$value',
          style: TextStyle(fontSize: fontSize ?? 12.0, fontWeight: fontWeight ?? FontWeight.normal, color: textColor),
        ));
  }
}
