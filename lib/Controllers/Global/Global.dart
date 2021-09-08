import 'package:get/get.dart';
import 'package:woosh/Controllers/Global/StorageController.dart';
import 'package:woosh/DebugTool/DebugTool.dart';
import 'package:woosh/Controllers/Global/Dashboard_controller.dart';

class GlobalController implements Bindings {

  @override
  void dependencies() {
    Print.green("CONTROLLER DEPENDENCIES CALLED");
    Get.put<StorageController>(StorageController());
    Get.put<DashoardController>(DashoardController());
  }
}
