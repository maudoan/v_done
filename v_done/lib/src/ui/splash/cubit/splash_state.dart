part of 'splash_cubit.dart';

abstract class SplashState {
  SplashState();
}

class AppInfoInProgress extends SplashState {}

class AppInfoSuccess extends SplashState {
  final PackageInfo response;

  AppInfoSuccess({required this.response});
}

class AppInfoFailure extends SplashState {
  final dynamic error;

  AppInfoFailure(this.error);
}
