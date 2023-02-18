import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../_core/api_helper.dart';

part 'service.g.dart';

@RestApi()
abstract class VDoneService {
  factory VDoneService(Dio dio, {String baseUrl}) = _VDoneService;

  static VDoneService create() {
    final dio = ApiHelper().createDio()..addInterceptors();

    final client = VDoneService(dio);
    return client;
  }
}
