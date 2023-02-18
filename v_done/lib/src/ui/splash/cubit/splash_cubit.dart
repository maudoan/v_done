import 'package:bloc/bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(AppInfoInProgress());

  Future getAppInfo() async {
    try {
      emit(AppInfoInProgress());
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      emit(AppInfoSuccess(response: packageInfo));
    } catch (e) {
      emit(AppInfoFailure(e));
    }
  }
}
