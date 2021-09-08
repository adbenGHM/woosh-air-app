import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woosh/DebugTool/DebugTool.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';

class DiscoverHubController extends GetxController {
  FlutterBlue flutterBlue = FlutterBlue.instance;

  @override
  void onInit() {
    super.onInit();
    Print.yellow("HUB CONTROLLER INIT");
    _initilize();
  }

  void _initilize() async {
    await Permission.bluetooth.request();
    await Permission.location.request();
    _searchDevices();
  }

  void _searchDevices() async {
    Print.yellow("LOOKING FOR DEVICES");

    if (!await flutterBlue.isOn) {
      Print.red("BLUETOOTH IS OFF");
      Get.snackbar(
          "Bluetooth", "Please turn on the bluetooth, to scan the devices",
          snackPosition: SnackPosition.BOTTOM,
          isDismissible: true,
          shouldIconPulse: true,
          barBlur: 20,
          icon: Icon(Icons.bluetooth));
      Timer(Duration(seconds: 7), () => _searchDevices());
      return;
    }

    List<ScanResult> devices = await flutterBlue.startScan(timeout: Duration(seconds: 1));
  
    if (devices.isEmpty) {
      Get.snackbar(
        "No hubs were found",
        "Please turn on you hub or bring it closer to pair with your device",
        snackPosition: SnackPosition.BOTTOM,
        isDismissible: true,
        shouldIconPulse: true,
        barBlur: 10,
        icon: Icon(Icons.error_outline),
        duration: Duration(seconds: 10),
      );
      Timer(Duration(seconds: 7), () => _searchDevices());
    } else {
      Get.offNamed('/bluetooth', arguments: devices);
    }
  }
}
