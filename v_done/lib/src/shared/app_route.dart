import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_done/src/ui/splash/cubit/splash_cubit.dart';
import 'package:v_done/src/ui/splash/splash_screen.dart';

enum AppRoute {
  SPALSH_SCREEN,
}

extension AppRouteExt on AppRoute {
  String get name {
    switch (this) {
      case AppRoute.SPALSH_SCREEN:
        return '/splash';
    }
  }

  static AppRoute? from(String? name) {
    for (final item in AppRoute.values) {
      if (item.name == name) {
        return item;
      }
    }
    return null;
  }

  static Route generateRoute(RouteSettings settings) {
    switch (AppRouteExt.from(settings.name)) {
      case AppRoute.SPALSH_SCREEN:
        return GetPageRoute(
            settings: settings,
            page: () => const SplashScreen(),
            bindings: [
              BindingsBuilder.put(() => SplashCubit()),
            ],
            curve: Curves.ease,
            transition: Transition.fade);
      default:
        return GetPageRoute(settings: settings, curve: Curves.linear, transition: Transition.rightToLeft
            // page: () => EmptyScreen(desc: 'No route defined for ${settings.name}'),
            );
    }
  }

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static Route<dynamic> bindingRoute(RouteSettings settings) {
    return AppRouteExt.generateRoute(settings);
  }
}
