import 'dart:convert';
import 'dart:io'
    show HttpClient, HttpOverrides, Platform, SecurityContext, X509Certificate;

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:one_components/one_components.dart';
import 'package:v_done/src/data/_core/error.dart';

import 'pretty_dio_logger.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      };
  }
}

class ApiHelper {
  static String? get _proxy => '';
  // static String? get _proxy => EnvConfig.PROXY;

  BaseOptions get opts => BaseOptions(
        // baseUrl: EnvConfig.BASE_URL,
        baseUrl: 'https://',
        contentType: 'application/json',
        connectTimeout: 300 * 1000, //Chờ 300s
        receiveTimeout: 300 * 1000, //Chờ 300s
      );

  BaseOptions get optsGoogleMap => BaseOptions(
        // baseUrl: EnvConfig.BASE_GOOGLE_MAPS_URL,
        baseUrl: 'https://',
        contentType: 'application/json',
        connectTimeout: 300 * 1000, //Chờ 300s
        receiveTimeout: 300 * 1000, //Chờ 300s
      );

  Dio createDioWith(BaseOptions opts, {bool withSSLEnable = false}) {
    final dio = Dio(opts);

    //trungdn: add proxy debugable base on https://flutterigniter.com/debugging-network-requests/
    if (kDebugMode) {
      if (_proxy?.isEmpty ?? true) {
        return dio;
      }

      // Tap into the onHttpClientCreate callback
      // to configure the proxy just as we did earlier.
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        // Hook into the findProxy callback to set the client's proxy.
        client.findProxy = (url) {
          return 'PROXY $_proxy';
        };

        // This is a workaround to allow Charles to receive
        // SSL payloads when your app is running on Android.
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => Platform.isAndroid;

        //hieutv: Fix Connection closed before full header was received
        client.maxConnectionsPerHost = 10;

        return client;
      };
    } else {
      //hieutv: Fix Connection closed before full header was received
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        if (withSSLEnable)
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;

        client.maxConnectionsPerHost = 10;

        return client;
      };
    }

    return dio;
  }

  Dio createDio() {
    final baseUrl = '';
    return createDioWith(opts.copyWith(baseUrl: baseUrl));
  }

  Dio createDioGoogleMaps() => createDioWith(optsGoogleMap);
}

extension AppDioExtension on Dio {
  Dio addAuthInterceptors() {
    return this
      ..interceptors.add(InterceptorsWrapper(
        onRequest: authRequestInterceptor,
      ));
  }

  Future authRequestInterceptor(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final currentBaseUrl = '';
    if (currentBaseUrl?.isNotEmpty ?? false) options.baseUrl = currentBaseUrl!;
    return handler.next(options);
  }

  Dio addInterceptors() {
    return this
      ..interceptors.add(InterceptorsWrapper(
        onRequest: requestInterceptor,
        onResponse: responseInterceptor,
        onError: errorInterceptor,
      ));
  }

  Future requestInterceptor(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final _token = '';
      final _appSecret = '';
      final _selectedMenuId = '';
      final currentBaseUrl = '';
      if (currentBaseUrl?.isNotEmpty ?? false)
        options.baseUrl = currentBaseUrl!;
      options.headers.addAll({'Content-Type': 'application/json'});
      options.headers.addAll({'Authorization': 'Bearer ${_token}'});
      options.headers.addAll({'App-secret': _appSecret});
      options.headers.addAll({'SelectedMenuId': _selectedMenuId});

      return handler.next(options);
    } catch (e) {
      //hieutv: Bổ sung chưa có token thì cancel request và văng lỗi
      return handler.reject(DioError(
        requestOptions: options,
        type: DioErrorType.cancel,
      ));
    }
  }

  Future responseInterceptor(
      Response response, ResponseInterceptorHandler handler) async {
    try {
      if (response.data is Map && response.data?['error_code'] != 200) {
        return handler.reject(DioError(
          requestOptions: response.requestOptions,
          response: response,
          type: DioErrorType.response,
        ));
      }
      _sendMessage(response);

      return handler.next(response);
    } catch (e) {
      return handler.next(response);
    }
  }

  Future errorInterceptor(
      DioError dioError, ErrorInterceptorHandler handler) async {
    try {
      if (dioError.response?.statusCode == 403 ||
          dioError.response?.statusCode == 401) {
        final _error = ErrorHandling.tryParse(dioError);
        OneToast.show(msg: _error.message, type: OneToastType.WARNING);
        // await Get.find<AuthRepository>().clear();
        return;
      }
      return handler.next(dioError);
    } catch (e) {
      return handler.next(dioError);
    }
  }

  Dio addOneAppLog() {
    if (!kReleaseMode) {
      return this..interceptors.add(PrettyDioLogger(requestBody: true));
    }
    return this;
  }

  static void _sendMessage(Response response) {
    final isLogFullReqTele = false;
    if (!isLogFullReqTele) return;

    final _method = response.requestOptions.method;
    // final _headers = json.encode(_error?.requestOptions.headers);
    final _uri = response.requestOptions.uri;
    String? _data;
    if (response.requestOptions.data is FormData) {
      final _formData = response.requestOptions.data as FormData;
      _data = '${_formData.fields.toString()}';
    } else if (response.requestOptions.data is Map)
      _data = '${json.encode(response.requestOptions.data)}';
    else
      _data = response.requestOptions.data.toString();

    final _response = response;
    final _statusCode = response.statusCode;
    final _statusMess = response.statusMessage;
  }
}
