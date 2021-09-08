import 'package:get/get.dart';
import 'package:woosh/DebugTool/DebugTool.dart';
// import 'package:woosh/AppMeta/metaData.dart';
import 'package:flutter/material.dart';

class Snackbar {
  final String title;
  final String message;
  final Function? onClosed;

  Snackbar(
    this.title,
    this.message, {
    this.onClosed,
  }) {
    Get.snackbar(
      title,
      message,
      duration: Duration(seconds: 3),
      backgroundColor: const Color(0xffE2FFD2),
      snackbarStatus: (status) {
        Print.yellow(status);
        if (status == SnackbarStatus.CLOSED) onClosed!();
      },
    );
  }
}
