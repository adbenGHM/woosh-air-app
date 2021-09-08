import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woosh/AppMeta/metaData.dart';
import 'package:woosh/Components/Components.dart';
import 'package:woosh/Controllers/Global/StorageController.dart';
import 'package:woosh/DebugTool/DebugTool.dart';
import 'package:woosh/Models/UserModal.dart';
// import 'package:woosh/Controllers/Global/StorageController.dart';
import 'package:woosh/Service/ErrorHandler.dart';
import 'package:woosh/Service/Service.dart';

class ProfileController extends GetxController {
  final Loader loader = Loader();
  RxString name = "".obs;
  RxString email = "".obs;

  @override
  void onInit() {
    super.onInit();
    Print.yellow("POFILE CONTROLLER INIT");
    initilize();
  }

  void initilize() async {
    UserModel user = Get.find<StorageController>().user.value;
    name.value = user.name;
    email.value = user.email;
  }

  void onReset() {
    Get.defaultDialog(
      title: 'Are you sure ?',
      middleText:
          'You want to fully reset the hub, this will remove all the associated filters',
      cancel: FlatButtonCustom(
        onTap: () {
          Get.back();
        },
        child: CustomText(
          "Cancel",
          color: Colors.black,
        ),
      ),
      confirm: OutlinedButtonCustom(
        onTap: () {
          Get.back();
          _handleReset(true);
        },
        child: CustomText(
          "Reset",
          color: primaryColor,
        ),
      ),
    );
  }

  void onPasswordChange() {
    Get.defaultDialog(
      title: 'Are you sure ?',
      middleText: 'You want to change WiFi password associated with the hub',
      cancel: FlatButtonCustom(
        onTap: () {
          Get.back();
        },
        child: CustomText(
          "Cancel",
          color: Colors.black,
        ),
      ),
      confirm: OutlinedButtonCustom(
        onTap: () {
          Get.back();
          _handleReset(false);
        },
        child: CustomText(
          "Reset",
          color: primaryColor,
        ),
      ),
    );
  }

  void _handleReset(bool isFullReset) async {
    await Get.find<Service>().unlinkHub(isFullReset).then((value) {
      print(value.toString());
      Get.offAllNamed('/discover_hub');
    }).catchError((error) {
      ErrorHandler(error).handle();
    });
  }

  void onLogout() {
    Get.defaultDialog(
      title: 'Are you sure ?',
      middleText: 'You want to logout',
      cancel: FlatButtonCustom(
        onTap: () {
          Get.back();
        },
        child: CustomText(
          "Cancel",
          color: Colors.black,
        ),
      ),
      confirm: OutlinedButtonCustom(
        onTap: () {
          Get.back();
          _handleLogout();
        },
        child: CustomText(
          "Logout",
          color: primaryColor,
        ),
      ),
    );
  }

  void _handleLogout() {
    Get.offAllNamed("/login");
    Get.find<StorageController>().logout();
  }
}
