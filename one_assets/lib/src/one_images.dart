/*
 * File: one_images.dart
 * File Created: Monday, 1st March 2021 2:26:55 pm
 * Author: Hieu Tran
 * -----
 * Last Modified: Monday, 1st March 2021 2:31:24 pm
 * Modified By: Hieu Tran
 */

import 'dart:io' as dart_io;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class OneImages {
  OneImages._();

  static const String alert_failure = 'packages/one_assets/lib/images/alert_failure.png';
  static const String alert_success = 'packages/one_assets/lib/images/alert_success.png';

  static const String avatar_placeholder = 'packages/one_assets/lib/images/avatar_placeholder.png';
  static const String background = 'packages/one_assets/lib/images/background.png';
  static const String powered_by_Aneed = 'packages/one_assets/lib/images/powered_by_Aneed.png';

  static const String disconnected = 'packages/one_assets/lib/images/disconnected.png';
  static const String empty_data = 'packages/one_assets/lib/images/empty_data.png';
  static const String no_permission = 'packages/one_assets/lib/images/no_permission.png';
  static const String no_search = 'packages/one_assets/lib/images/no_search.png';
  static const String not_found = 'packages/one_assets/lib/images/not_found.png';
  static const String building_page = 'packages/one_assets/lib/images/building_page.png';
  static const String logo_qr = 'packages/one_assets/lib/images/ic_logo_qr.png';
  static const String nlml_red = 'packages/one_assets/lib/images/ic_nlml_red.png';
  static const String nlml_blue = 'packages/one_assets/lib/images/ic_nlml_blue.png';
  static const String nlml_yellow = 'packages/one_assets/lib/images/ic_nlml_yellow.png';
  static const String ic_inhoadon_logo = 'packages/one_assets/lib/images/ic_inhoadon_logo.png';
  static const String square_red = 'packages/one_assets/lib/images/square_red.png';
  static const String square_yellow = 'packages/one_assets/lib/images/square_yellow.png';
  static const String square_blue = 'packages/one_assets/lib/images/square_blue.png';
  static const String circle_red = 'packages/one_assets/lib/images/circle_red.png';
  static const String circle_yellow = 'packages/one_assets/lib/images/circle_yellow.png';
  static const String circle_blue = 'packages/one_assets/lib/images/circle_blue.png';
  static const String triangle_red = 'packages/one_assets/lib/images/triangle_red.png';
  static const String triangle_yellow = 'packages/one_assets/lib/images/triangle_yellow.png';
  static const String triangle_blue = 'packages/one_assets/lib/images/triangle_blue.png';
  static const String ic_capnhat_db = 'packages/one_assets/lib/images/ic_capnhat_db.png';
  static const String ic_chamsoc_db = 'packages/one_assets/lib/images/ic_chamsoc_db.png';
  static const String ic_ghetham_db = 'packages/one_assets/lib/images/ic_ghetham_db.png';
  static const String ic_ghetham_ussd = 'packages/one_assets/lib/images/ic_ghetham_ussd.png';
  static const String ol_connect_ethernet = 'packages/one_assets/lib/images/ol_connect_ethernet.png';
  static const String ol_huongdan_thietlap_02 = 'packages/one_assets/lib/images/ol_huongdan_thietlap_02.jpg';
  static const String ol_huongdan_thietlap_01 = 'packages/one_assets/lib/images/ol_huongdan_thietlap_01.png';
  static const String ol_vitri_lapdat_01 = 'packages/one_assets/lib/images/ol_vitri_lapdat_01.png';
  static const String ol_vitri_lapdat_02 = 'packages/one_assets/lib/images/ol_vitri_lapdat_02.png';
  static const String ol_capnguon = 'packages/one_assets/lib/images/ol_capnguon.png';
  static const String ol_wifi = 'packages/one_assets/lib/images/ol_wifi.png';
}

class BanHangImages {
  BanHangImages._();

  static Future<dart_io.File> _getImageFileFromAssets(String path) async {
    final _byteData = await rootBundle.load(path);
    final _lastPath = path.split('/').last;

    final file = dart_io.File('${(await getTemporaryDirectory()).path}/$_lastPath');
    await file.writeAsBytes(_byteData.buffer.asUint8List(_byteData.offsetInBytes, _byteData.lengthInBytes));

    return file;
  }

  static Future<Uint8List> _loadFromAsset(String key) async {
    final byteData = await rootBundle.load(key);
    return byteData.buffer.asUint8List();
  }
}

class CSKHImages {
  CSKHImages._();

  static Future<dart_io.File> _getImageFileFromAssets(String path) async {
    final _byteData = await rootBundle.load(path);
    final _lastPath = path.split('/').last;

    final file = dart_io.File('${(await getTemporaryDirectory()).path}/$_lastPath');
    await file.writeAsBytes(_byteData.buffer.asUint8List(_byteData.offsetInBytes, _byteData.lengthInBytes));

    return file;
  }

  static Future<Uint8List> _loadFromAsset(String key) async {
    final byteData = await rootBundle.load(key);
    return byteData.buffer.asUint8List();
  }
}
