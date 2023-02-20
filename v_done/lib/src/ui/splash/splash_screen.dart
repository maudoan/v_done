import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:one_components/one_components.dart';
import 'package:v_done/src/shared/app_scaffold.dart';
import 'package:v_done/src/ui/splash/cubit/splash_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/app_route.dart';
import '../../shared/constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _appVer = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Get.find<SplashCubit>().getAppInfo();
      Future.delayed(const Duration(milliseconds: 3000), () {
        Get.offAllNamed(AppRoute.DASHBOARD_SCREEN.name);
      });
    });
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        left: false,
        right: false,
        child: Stack(children: <Widget>[
          Container(
            color: Color(0xff0066FF),
          ),
          Image.asset('assets/img/splash_bg.png', height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width),
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Image.asset('assets/res_for_gen/ic_logo_splash.png', height: 150, width: 150),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom > 0 ? MediaQuery.of(context).padding.bottom : 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _appVer,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Copyright © 2021 Aneed Technology\nAll rights reserved.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          _buildListener(),
        ]),
      ),
    );
  }

  Widget _buildListener() {
    return BlocListener(
      bloc: Get.find<SplashCubit>(),
      listener: (context, state) async {},
      child: Container(),
    );
  }
}
