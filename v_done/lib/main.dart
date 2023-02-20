import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:one_assets/one_assets.dart';
import 'package:v_done/src/data/_core/api_helper.dart';
import 'package:v_done/src/data/service/service_locator.dart';
import 'package:v_done/src/shared/app_route.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    setupServiceLocator();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
      ),
    );
    precacheImage(const AssetImage('assets/ic_logo.png'), context);
    precacheImage(const AssetImage('assets/img/splash_bg.png'), context);
    precacheImage(const AssetImage('assets/res_for_gen/ic_logo_splash.png'), context);
    return GetMaterialApp(
      title: 'V Done',
      navigatorKey: AppRouteExt.navigatorKey,
      key: key,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('vi', 'VI'),
        Locale.fromSubtags(languageCode: 'vi'),
      ],
      theme: CustomTheme.fromContext(context).appTheme,
      initialRoute: AppRoute.SPALSH_SCREEN.name,
      onGenerateRoute: AppRouteExt.bindingRoute,
      initialBinding: AppBinding(),
    );
  }
}

class AppBinding extends Bindings {
  @override
  void dependencies() {
    injectService();
  }

  void injectService() {}
}
