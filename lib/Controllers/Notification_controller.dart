import 'dart:async';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:woosh/AppMeta/metaData.dart';
// import 'package:woosh/Components/Components.dart';
import 'package:woosh/Controllers/Global/Dashboard_controller.dart';
import 'package:woosh/DebugTool/DebugTool.dart';
// import 'package:woosh/Controllers/Global/StorageController.dart';
import 'package:woosh/Service/ErrorHandler.dart';
import 'package:woosh/Service/Service.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class NotificationController extends GetxController {
  RxList<Map> notifications = <Map>[].obs;

  @override
  void onInit() {
    super.onInit();
    Print.yellow("NOTIFICATION CONTROLLER INIT");
    initilize();
  }

  void initilize() {
    getNotifications();
  }

  Future getNotifications() async {
    await Get.find<Service>().getNotification().then((value) {
      Print.green(value);
      notifications.value = [...value.data["result"]];
      readAllNoitification();
    }).catchError((error) {
      ErrorHandler(error).handle();
    });
  }

  void readAllNoitification() async {
    await Get.find<Service>().readAllNotification().then((response) {
      Get.find<DashoardController>().getPendingNotification();
    }).catchError((error) {
      Print.red(error);
    });
  }

  void delete(String id) async {
    await Get.find<Service>().deleteNotification(id).then((value) {
      notifications.value = [
        ...notifications.value
            .where((notification) => notification["_id"] != id)
      ];
    }).catchError((error) {
      ErrorHandler(error).handle();
    });
  }
}
