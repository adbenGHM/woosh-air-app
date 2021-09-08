// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woosh/Components/Components.dart';
import 'package:woosh/DebugTool/DebugTool.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:woosh/Service/ErrorHandler.dart';
import 'package:woosh/Service/Service.dart';

class ScanScreenController extends GetxController {
  RxList<String> qr = <String>[].obs;
  RxBool isLoading = false.obs;
  final TextEditingController filterName = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    Print.yellow("WIFI SCREEN CONTROLLER INIT");
  }

  void onScan() async {
    if (isLoading.value) return;
    String scanner = await FlutterBarcodeScanner.scanBarcode(
      "#66ff66",
      "Cancel",
      true,
      ScanMode.QR,
    );
    if (scanner != '-1') validate(scanner);
  }

  void validate(String filter) async {
    isLoading.value = true;
    bool isValidated = false;
    await Get.find<Service>().validateFilter(filter).then((response) {
      isValidated = true;
    }).catchError((error) {
      Print.green(error);
      ErrorHandler(error).handle();
    });
    isLoading.value = false;
    if (isValidated) getFilterName(filter);
  }

  void getFilterName(String filter) {
    filterName.text = 'Air filter ${qr.value.length + 1}';
    Get.defaultDialog(
      title: "Filter name",
      content: Column(
        children: <Widget>[
          InputFormCustom(
            controller: filterName,
            inputAction: TextInputAction.done,
            hintText: "Enter a filter name",
          ),
          SizedBox(height: 20),
          NextButton(
            onTap: () {
              if (filterName.text.isNotEmpty) {
                Get.back();
                connectToFilter(filter);
              }
            },
          ),
        ],
      ),
    );
  }

  void connectToFilter(String node) async {
    isLoading.value = true;
    await Get.find<Service>().linkNode(node, filterName.text).then((response) {
      qr.value = [...qr.value, filterName.text];
      Print.green(node);
    }).catchError((error) {
      Print.green(node);
      Print.green(error);
      ErrorHandler(error).handle();
    });
    isLoading.value = false;
  }

  void onNext() {
    if (!isLoading.value) Get.offAllNamed('/dashboard');
  }
}
