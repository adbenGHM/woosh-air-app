import 'dart:async';
// import 'package:flutter/material.dart';
// import 'dart:convert';

import 'package:get/get.dart';
// import 'package:woosh/AppMeta/metaData.dart';
import 'package:woosh/DebugTool/DebugTool.dart';
import 'package:flutter_blue/flutter_blue.dart';

// import 'package:permission_handler/permission_handler.dart';
// import 'package:woosh/Components/Components.dart';

class BluetoothScreenController extends GetxController {
  List<ScanResult> devices = [];
  Rx<List<ScanResult>> finalDevices = Rx<List<ScanResult>>([]);
  RxBool isConnecting = false.obs;
  // ScanResult device = ScanResult.obs;

  BluetoothScreenController(this.devices);

  @override
  void onInit() {
    super.onInit();
    Print.yellow("BLUETOOTH SCREEN CONTROLLER INIT");
    _initilize();
  }

  void setupWIFI(device) async {
    Get.toNamed('/wifi', arguments: device);
  }

  void _initilize() {
    Print.green(devices);
    finalDevices.value = devices.where((dev) => dev.device.name.length>0).toList();
  }
}
