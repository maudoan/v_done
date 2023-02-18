/*
 * File: show_quarterly_picker.dart
 * File Created: Thursday, 18th March 2021 9:13:55 am
 * Author: Tân Hà
 * -----
 * Last Modified: Thursday, 18th March 2021 9:14:00 am
 * Modified By: Hieu Tran
 */
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:one_components/src/component/date_time/one_datetime_format.dart';

Future<DateTime?> showQuarterlyPicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  DateTime? lastDate,
}) async {
  return await showDialog<DateTime>(
      context: context,
      builder: (context) => _QuarterlyPickerDialog(
            initialDate: initialDate,
            firstDate: firstDate,
            lastDate: lastDate,
          ));
}

class _QuarterlyPickerDialog extends StatefulWidget {
  final DateTime initialDate;
  final DateTime? firstDate, lastDate;
  const _QuarterlyPickerDialog({
    Key? key,
    required this.initialDate,
    this.firstDate,
    this.lastDate,
  }) : super(key: key);
  @override
  _QuarterlyPickerDialogState createState() => _QuarterlyPickerDialogState();
}

class _QuarterlyPickerDialogState extends State<_QuarterlyPickerDialog> {
  late PageController _pageController;
  late DateTime _selectedDate;
  late int _displayedPage;
  DateTime? _firstDate, _lastDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime(widget.initialDate.year, widget.initialDate.month);

    if (widget.firstDate != null) _firstDate = DateTime(widget.firstDate!.year, widget.firstDate!.month);
    if (widget.lastDate != null) _lastDate = DateTime(widget.lastDate!.year, widget.lastDate!.month);

    _displayedPage = _selectedDate.year;
    _pageController = PageController(initialPage: _displayedPage);
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
              'Chọn Quý Năm',
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
                    OneDateFormat.QUARTER_YEAR.fm.format(_selectedDate),
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
                      onPressed: () => _pageController.animateToPage(_displayedPage - 1, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: theme.primaryIconTheme.color,
                      ),
                      onPressed: () => _pageController.animateToPage(_displayedPage + 1, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut),
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
      height: 150.0,
      width: 250.0,
      child: Theme(
        data: theme.copyWith(
          buttonTheme: const ButtonThemeData(
            padding: EdgeInsets.all(2.0),
            shape: CircleBorder(),
            minWidth: 4.0,
          ),
        ),
        child: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          onPageChanged: (index) {
            setState(() {
              _displayedPage = index;
            });
          },
          itemBuilder: (context, page) {
            return GridView.count(
              padding: const EdgeInsets.all(8.0),
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              cacheExtent: 10,
              childAspectRatio: 1.6,
              children: List<int>.generate(4, (i) => i + 1)
                  .map((month) => DateTime(page, month * 3))
                  .map(
                    (date) => Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: _getQuarterButton(date, theme, locale),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }

  Widget _getQuarterButton(final DateTime date, final ThemeData theme, final String locale) {
    final quarter = (date.month / 3).ceil();
    VoidCallback? callback;
    if (_firstDate == null && _lastDate == null)
      callback = () => setState(() => _selectedDate = DateTime(date.year, date.month));
    else if (_firstDate != null && _lastDate != null && _firstDate!.compareTo(date) <= 0 && _lastDate!.compareTo(date) >= 0)
      callback = () => setState(() => _selectedDate = DateTime(date.year, date.month));
    else if (_firstDate != null && _lastDate == null && _firstDate!.compareTo(date) <= 0)
      callback = () => setState(() => _selectedDate = DateTime(date.year, date.month));
    else if (_firstDate == null && _lastDate != null && _lastDate!.compareTo(date) >= 0)
      callback = () => setState(() => _selectedDate = DateTime(date.year, date.month));
    else
      callback = null;
    return TextButton(
      onPressed: callback,
      style: TextButton.styleFrom(
        backgroundColor: date.month == _selectedDate.month && date.year == _selectedDate.year ? theme.colorScheme.secondary : null,
        shape:
            CircleBorder(side: quarter == (DateTime.now().month ~/ 3 + 1) && date.year == DateTime.now().year ? BorderSide(color: theme.colorScheme.secondary) : BorderSide.none),
      ),
      child: Text(
        'Q$quarter/$_displayedPage',
        style: TextStyle(
          color: date.month == _selectedDate.month && date.year == _selectedDate.year
              ? theme.textTheme.button?.color
              : (quarter == (DateTime.now().month ~/ 3 + 1) && date.year == DateTime.now().year ? theme.colorScheme.secondary : null),
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
            onPressed: () => Navigator.pop(context, _selectedDate),
            child: Text(localizations.okButtonLabel),
          )
        ],
      ),
    );
  }
}
