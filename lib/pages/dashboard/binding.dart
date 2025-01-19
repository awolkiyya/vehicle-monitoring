import 'package:get/get.dart';
import 'package:mini_project/pages/dashboard/index.dart';

class VehicleBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<VehicleController>(VehicleController());
  }
}