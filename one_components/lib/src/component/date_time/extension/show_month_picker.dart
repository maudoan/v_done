/*
 * File: show_month_picker.dart
 * File Created: Wednesday, 17th March 2021 11:22:51 am
 * Author: Tân Hà
 * -----
 * Last Modified: Wednesday, 17th March 2021 11:23:08 am
 * Modified By: Tân Hà
 */
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<DateTime?> showMonthPicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  DateTime? lastDate,
}) async {
  return await showDialog<DateTime>(
      context: context,
      builder: (context) => _MonthPickerDialog(
            initialDate: initialDate,
            firstDate: firstDate,
            lastDate: lastDate,
          ));
}

class _MonthPickerDialog extends StatefulWidget {
  final DateTime? initialDate, firstDate, lastDate;
  const _MonthPickerDialog({
    Key? key,
    required this.initialDate,
    this.firstDate,
    this.lastDate,
  }) : super(key: key);
  @override
  _MonthPickerDialogState createState() => _MonthPickerDialogState();
}

class _MonthPickerDialogState extends State<_MonthPickerDialog> {
  PageController? pageController;
  DateTime? selectedDate;
  late int displayedPage;
  DateTime? _firstDate, _lastDate;
  @override
  void initState() {
    super.initState();
    selectedDate = DateTime(widget.initialDate!.year, widget.initialDate!.month);
    _firstDate = DateTime(widget.firstDate!.year, widget.firstDate!.month);
    _lastDate = DateTime(widget.lastDate!.year, widget.lastDate!.month);
    displayedPage = selectedDate!.year;
    pageController = PageController(initialPage: displayedPage);
  }

  String _locale(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return '${locale.languageCode}_${locale.countryCode}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = MaterialLocalizations.of(context);
    final locale = _locale(context);
    final header = buildHeader(theme, locale);
    final pager = buildPager(theme, locale);
    final content = Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [pager, buildButtonBar(context, localizations)],
      ),
      color: theme.dialogBackgroundColor,
    );
    return Theme(
      data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.transparent),
      child: Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
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
      ),
    );
  }

  Widget buildHeader(ThemeData theme, String locale) {
    return Material(
      color: theme.primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              DateFormat.yMMMM(locale).format(selectedDate!),
              style: theme.primaryTextTheme.subtitle1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {});
                  },
                  child: Text(
                    DateFormat.y(locale).format(DateTime(displayedPage)),
                    style: theme.primaryTextTheme.headline5,
                  ),
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_up,
                        color: theme.primaryIconTheme.color,
                      ),
                      onPressed: () => pageController!.animateToPage(displayedPage - 1, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: theme.primaryIconTheme.color,
                      ),
                      onPressed: () => pageController!.animateToPage(displayedPage + 1, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildPager(ThemeData theme, String locale) {
    return SizedBox(
      height: 190.0,
      width: 300.0,
      child: Theme(
        data: theme.copyWith(
          buttonTheme: const ButtonThemeData(
            padding: EdgeInsets.all(2.0),
            shape: CircleBorder(),
            minWidth: 4.0,
          ),
        ),
        child: PageView.builder(
          controller: pageController,
          scrollDirection: Axis.vertical,
          onPageChanged: (index) {
            setState(() {
              displayedPage = index;
            });
          },
          itemBuilder: (context, page) {
            return GridView.count(
              padding: const EdgeInsets.all(8.0),
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              childAspectRatio: 2,
              children: List<int>.generate(12, (i) => i + 1)
                  .map((month) => DateTime(page, month))
                  .map(
                    (date) => Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: _getMonthButton(date, theme, locale),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }

  Widget _getMonthButton(final DateTime date, final ThemeData theme, final String locale) {
    VoidCallback? callback;
    if (_firstDate == null && _lastDate == null)
      callback = () => setState(() => selectedDate = DateTime(date.year, date.month));
    else if (_firstDate != null && _lastDate != null && _firstDate!.compareTo(date) <= 0 && _lastDate!.compareTo(date) >= 0)
      callback = () => setState(() => selectedDate = DateTime(date.year, date.month));
    else if (_firstDate != null && _lastDate == null && _firstDate!.compareTo(date) <= 0)
      callback = () => setState(() => selectedDate = DateTime(date.year, date.month));
    else if (_firstDate == null && _lastDate != null && _lastDate!.compareTo(date) >= 0)
      callback = () => setState(() => selectedDate = DateTime(date.year, date.month));
    else
      callback = null;
    return TextButton(
      onPressed: callback,
      style: TextButton.styleFrom(
        backgroundColor: date.month == selectedDate!.month && date.year == selectedDate!.year ? theme.colorScheme.secondary : null,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: date.month == DateTime.now().month && date.year == DateTime.now().year ? BorderSide(color: theme.colorScheme.secondary) : BorderSide.none),
      ),
      child: Text(
        DateFormat.MMMM(locale).format(date),
        style: TextStyle(
          color: date.month == selectedDate!.month && date.year == selectedDate!.year
              ? theme.textTheme.button!.color
              : date.month == DateTime.now().month && date.year == DateTime.now().year
                  ? theme.colorScheme.secondary
                  : null,
        ),
      ),
    );
  }

  Widget buildButtonBar(BuildContext context, MaterialLocalizations localizations) {
    return ButtonTheme(
      child: ButtonBar(
        children: <Widget>[
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
