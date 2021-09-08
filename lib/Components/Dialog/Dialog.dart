import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog {
  String title;
  String message;
  CustomDialog({
    this.title = "",
    this.message = "",
  });

  Future show() async {
    await Get.defaultDialog(
      title: title,
      middleText: message,
      backgroundColor: new Color.fromRGBO(206, 214, 208, 0.6),
    );
  }
}
