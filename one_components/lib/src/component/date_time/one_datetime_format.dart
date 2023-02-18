/*
 * File: one_datetime_format.dart
 * File Created: Wednesday, 12th May 2021 8:18:16 pm
 * Author: Hieu Tran
 * -----
 * Last Modified: Wednesday, 12th May 2021 8:18:40 pm
 * Modified By: Hieu Tran
 */

import 'dart:developer';

import 'package:intl/intl.dart';

enum OneDateFormat {
  TRANS_DATETIME,
  DATE,
  DATE_SHORT_MONTH_EN,
  DATE_TIME12,
  DATE_TIME24,
  DATE_TIME24s,
  TIME24s_DATE,
  TIME12,
  TIME24,
  TIME24s,
  MONTH_YEAR,
  MONTH_YEAR_API,
  YEAR_MONTH_API,
  YEAR_MONTH_DATE_API,
  YEAR_MONTH_DATE_API2,
  YEAR,
  QUARTER_YEAR,
  VERBOSE,
  DATE_TIME24s_ERP_API_A,
  DATE_TIME24s_ERP_API_B,
}

extension OneDateUtils on OneDateFormat {
  DateFormat get fm {
    switch (this) {
      case OneDateFormat.TRANS_DATETIME:
        return DateFormat('yyyyMMddHHmmssSSS');
      case OneDateFormat.DATE:
        return DateFormat('dd/MM/yyyy', 'vi');
      case OneDateFormat.DATE_SHORT_MONTH_EN:
        return DateFormat('dd-MMM-yyyy', 'en');
      case OneDateFormat.DATE_TIME12:
        return DateFormat('dd/MM/yyyy hh:mm a', 'vi');
      case OneDateFormat.DATE_TIME24:
        return DateFormat('dd/MM/yyyy HH:mm', 'vi');
      case OneDateFormat.DATE_TIME24s:
        return DateFormat('dd/MM/yyyy HH:mm:ss', 'vi');
       case OneDateFormat.TIME24s_DATE:
        return DateFormat('HH:mm:ss dd/MM/yyyy', 'vi');
      case OneDateFormat.TIME12:
        return DateFormat('hh:mm a', 'vi');
      case OneDateFormat.TIME24:
        return DateFormat('HH:mm', 'vi');
      case OneDateFormat.TIME24s:
        return DateFormat('HH:mm:ss', 'vi');
      case OneDateFormat.MONTH_YEAR:
        return DateFormat('MM/yyyy', 'vi');
      case OneDateFormat.MONTH_YEAR_API:
        return DateFormat('MMyyyy');
      case OneDateFormat.YEAR_MONTH_API:
        return DateFormat('yyyyMM');
      case OneDateFormat.YEAR_MONTH_DATE_API:
        return DateFormat('yyyyMMdd');
      case OneDateFormat.YEAR_MONTH_DATE_API2:
        return DateFormat('yyyy/MM/dd');
      case OneDateFormat.YEAR:
        return DateFormat('yyyy', 'vi');
      case OneDateFormat.QUARTER_YEAR:
        return DateFormat('\'Q\'Q/yyyy', 'vi');
      case OneDateFormat.VERBOSE:
        return DateFormat('EEEEE, \'ngày\' dd \'tháng\' MM \'năm\' yyyy, \'vào lúc\' HH \'giờ\' mm \'phút\' ss \'giây\'', 'vi');
      case OneDateFormat.DATE_TIME24s_ERP_API_A:
        return DateFormat("yyyy-MM-dd'T'HH:mm:ss");
      case OneDateFormat.DATE_TIME24s_ERP_API_B:
        return DateFormat('yyyy-MM-dd HH:mm:ss');
    }
  }

  static String convertFrom(DateTime date, {required OneDateFormat toFormat}) {
    return toFormat.fm.format(date);
  }

  static String? convertFromStrTo(
    String? dateStr, {
    required OneDateFormat fromFm,
    required OneDateFormat toFm,
  }) {
    if (dateStr == null) return null;
    try {
      return toFm.fm.format(fromFm.fm.parse(dateStr));
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  static DateTime? convertToDateFrom(
    String? dateStr, {
    required OneDateFormat fromFormat,
  }) {
    if (dateStr == null) return null;
    try {
      return fromFormat.fm.parse(dateStr);
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  static int calculateAge(DateTime birthDate) {
    final DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    final int month1 = currentDate.month;
    final int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      final int day1 = currentDate.day;
      final int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  static int compareDate(DateTime one, DateTime two) {
    final _dateOne = DateTime(one.year, one.month, one.day);
    final _dateTwo = DateTime(two.year, two.month, two.day);
    return _dateOne.compareTo(_dateTwo);
  }

  static int daysBetween(DateTime one, DateTime two) {
    final _dateOne = DateTime(one.year, one.month, one.day);
    final _dateTwo = DateTime(two.year, two.month, two.day);
    return (_dateTwo.difference(_dateOne).inHours / 24).round();
  }
}
