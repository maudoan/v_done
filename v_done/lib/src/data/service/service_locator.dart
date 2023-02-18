import 'package:get/get.dart';
import 'package:v_done/src/data/source/business/vdone_repository.dart';
import 'package:v_done/src/data/source/business/vdone_repository_impl.dart';
import '../service/business/service_barrel.dart';

void setupServiceLocator() {
  Get.put<VDONERepository>(VDONEStorageRepository(), permanent: true);
}
