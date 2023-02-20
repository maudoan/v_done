import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_done/src/ui/dashboard/dash_board.dart';
import 'package:v_done/src/ui/splash/cubit/splash_cubit.dart';
import 'package:v_done/src/ui/splash/splash_screen.dart';
import 'package:v_live1/src/shared/v_live_route.dart';

enum AppRoute { SPALSH_SCREEN, DASHBOARD_SCREEN }

extension AppRouteExt on AppRoute {
  String get name {
    switch (this) {
      case AppRoute.SPALSH_SCREEN:
        return '/splash';
      case AppRoute.DASHBOARD_SCREEN:
        return '/dashboard';
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
    final routeName = settings.name;
      final tienIchRoutes = VLiveRoute.values.map((v) => v.name).toList();

    if (tienIchRoutes.contains(routeName)) {
      return VLiveRouteExt.generateRoute(settings);
    }
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
      case AppRoute.DASHBOARD_SCREEN:
        return GetPageRoute(
            settings: settings,
            page: () => const DashBoardScreen(),
            bindings: [
              // BindingsBuilder.put(() => SplashCubit()),
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
