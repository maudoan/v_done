import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_live1/src/ui/createLive/create_live.dart';
import 'package:v_live1/src/ui/watchLive/watch_live.dart';

enum VLiveRoute { CREATELIVE_SCREEN, WATCHLIVE_SCREEN }

extension VLiveRouteExt on VLiveRoute {
  String get name {
    switch (this) {
      case VLiveRoute.CREATELIVE_SCREEN:
        return '/CreateLive';
      case VLiveRoute.WATCHLIVE_SCREEN:
        return '/WatchLive';
    }
  }

  static VLiveRoute? from(String? name) {
    for (final item in VLiveRoute.values) {
      if (item.name == name) {
        return item;
      }
    }
    return null;
  }

  static Route generateRoute(RouteSettings settings) {
    switch (VLiveRouteExt.from(settings.name)) {
      case VLiveRoute.CREATELIVE_SCREEN:
        return GetPageRoute(
            settings: settings,
            page: () => const CreateLiveScreen(),
            bindings: [
              // BindingsBuilder.put(() => SplashCubit()),
            ],
            curve: Curves.ease,
            transition: Transition.fade);
      case VLiveRoute.WATCHLIVE_SCREEN:
        return GetPageRoute(
            settings: settings,
            page: () => const WatchLiveScreen(),
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
    return VLiveRouteExt.generateRoute(settings);
  }
}
