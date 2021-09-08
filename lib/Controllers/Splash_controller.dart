import 'dart:async';
import 'package:get/get.dart';
import 'package:woosh/Controllers/Global/Dashboard_controller.dart';
import 'package:woosh/DebugTool/DebugTool.dart';
import 'package:woosh/Controllers/Global/StorageController.dart';
import 'package:woosh/Service/ErrorHandler.dart';
import 'package:woosh/Service/Service.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Print.yellow("SPALSH CONTROLLER INIT");
    initilize();
  }

  void initilize() {
    decide();
  }

  Future<bool?> decide() async {
    Print.yellow("DECIDING");
    Timer(
      Duration(seconds: 2),
      () => checkLogin(),
    );
  }

  Future<bool?> checkLogin() async {
    String? token = await Get.find<StorageController>().getToken();
    if (token == null)
      Get.offNamed('/login');
    else
      _getSetup();
  }

  void _getSetup() async {
    Get.find<DashoardController>().getPendingNotification();
    Print.yellow("Getting setup");
    await Get.find<Service>().stepSetup().then((response) {
      Print.green(response.data["result"]);
      if (!response.data["result"]["has_hub"])
        Get.offNamed("/discover_hub");
      else if (!response.data["result"]["has_filter"])
        Get.offNamed("/scan");
      else
        Get.offNamed("/dashboard");
    }).catchError((error) {
      Print.red(error);
      ErrorHandler(error).handle().then((value) async {
        if(error.response.data["code"] == 401){
          await Get.find<StorageController>().logout();
          Get.offNamed('/login');
        }
        else{
        _getSetup();
        }
      });
    });
  }
}
