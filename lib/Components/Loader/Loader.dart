import 'package:flutter/material.dart';
import "package:get/get.dart";

class Loader {
  void show() {
    Get.dialog(
      Material(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: SizedBox(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  void remove() => Get.back();
}
