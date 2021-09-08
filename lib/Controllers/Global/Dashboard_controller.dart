// import 'dart:async';
import 'package:get/get.dart';
import 'package:woosh/DebugTool/DebugTool.dart';
import 'package:woosh/Service/Service.dart';
// import 'package:woosh/Controllers/Global/StorageController.dart';

class DashoardController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxInt notifications = 0.obs;

  @override
  void onInit() {
    super.onInit();
    Print.yellow("DASHBOARD CONTROLLER INIT");
  }

  void onNav(int index) {
    // To update unread notifications
    if(currentIndex.value==1)
      getPendingNotification();
    currentIndex.value = index;
  }

  void getPendingNotification() async {
    await Get.find<Service>().getPendingNotification().then((value) {
      Print.greenBG(value);
      notifications.value = value.data["result"]["unread"] ?? 0;
    }).catchError((error) {
      Print.red(error);
    });
  }
}
