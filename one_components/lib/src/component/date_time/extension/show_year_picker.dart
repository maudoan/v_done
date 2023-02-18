/*
 * File: show_year_picker.dart
 * File Created: Wednesday, 17th March 2021 1:45:00 pm
 * Author: Tân Hà
 * -----
 * Last Modified: Wednesday, 17th March 2021 1:45:06 pm
 * Modified By: Tân Hà
 */
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<DateTime?> showYearPicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
}) async {
  return await showDialog<DateTime>(
      context: context,
      builder: (context) => _YearPickerDialog(
            initialDate: initialDate,
            firstDate: firstDate,
            lastDate: lastDate,
          ));
}

class _YearPickerDialog extends StatefulWidget {
  const _YearPickerDialog({
    Key? key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
  }) : super(key: key);

  final DateTime initialDate, firstDate, lastDate;
  @override
  _YearPickerDialogState createState() => _YearPickerDialogState();
}

class _YearPickerDialogState extends State<_YearPickerDialog> {
  late DateTime selectedDate;

  String _locale(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return '${locale.languageCode}_${locale.countryCode}';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = MaterialLocalizations.of(context);
    final locale = _locale(context);
    final header = buildHeader(theme, locale);
    final pager = buildPager(theme, locale);
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        pager,
        buildButtonBar(context, localizations),
      ],
    );
    return Dialog(
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Builder(builder: (context) {
            if (MediaQuery.of(context).orientation == Orientation.portrait) {
              return IntrinsicWidth(
                child: Column(children: [header, content]),
              );
            }
            return IntrinsicHeight(
              child: Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [header, content]),
            );
          })
        ],
      ),
    );
  }

  Widget buildHeader(ThemeData theme, String locale) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: theme.primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat.y(locale).format(selectedDate),
            style: theme.primaryTextTheme.subtitle1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Chọn Năm',
                style: theme.primaryTextTheme.headline5,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildPager(ThemeData theme, String locale) {
    return SizedBox(
      height: 220.0,
      width: 300.0,
      child: YearPicker(
        firstDate: widget.firstDate,
        lastDate: widget.lastDate,
        initialDate: widget.initialDate,
        selectedDate: selectedDate,
        onChanged: (DateTime dateTime) {
          selectedDate = dateTime;
          setState(() {});
        },
      ),
    );
  }

  Widget buildButtonBar(BuildContext context, MaterialLocalizations localizations) {
    return ButtonTheme(
      child: ButtonBar(
        children: [
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: Text(localizations.cancelButtonLabel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, selectedDate),
            child: Text(localizations.okButtonLabel),
          )
        ],
      ),
    );
  }
}
