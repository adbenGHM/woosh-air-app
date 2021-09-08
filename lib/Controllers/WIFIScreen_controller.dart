import 'dart:async';
import 'dart:convert';
// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:woosh/Components/Components.dart';
// import 'package:woosh/AppMeta/metaData.dart';
import 'package:woosh/DebugTool/DebugTool.dart';
import 'package:woosh/Service/ErrorHandler.dart';
import 'package:woosh/Service/Service.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:woosh/Components/Components.dart';

class WIFIScreenController extends GetxController {
  // ignore: non_constant_identifier_names
  final String BLE_SERVICE_UUID = "6e400001-b5a3-f393-e0a9-e50e24dcca9e";
  // ignore: non_constant_identifier_names
  final String BLE_CHARACTERISTIC_WRITE_UUID =
      "6e400003-b5a3-f393-e0a9-e50e24dcca9e";
  // ignore: non_constant_identifier_names
  final String BLE_CHARACTERISTIC_READ_UUID =
      "6e400004-b5a3-f393-e0a9-e50e24dcca9e";

  RxList<Map<String, dynamic>> wifi = <Map<String, dynamic>>[].obs;
  RxBool isConnecting = false.obs;
  RxBool isScanning = true.obs;
  RxBool isLoading = false.obs;
  RxBool isManual = false.obs;
  // RxInt countDown = 15.obs;
  Timer? defaultTimer;
  RxString countDownText = "Hub is trying to connect to WiFi ...".obs;

  Rx<Map<String, dynamic>?> selectedWifi = Rx<Map<String, dynamic>?>(null);
  final TextEditingController password = new TextEditingController();
  final TextEditingController ssid = new TextEditingController();

  BluetoothDevice hub;
  WIFIScreenController(this.hub);

  @override
  void onInit() async {
    super.onInit();
    Print.yellow("WIFI SCREEN CONTROLLER INIT");
    await _initilize();
  }

  @override
  void onClose() async {
    super.onClose();
    await _onDispose();
  }

  Future<void> _onDispose() async {
    await this.hub.disconnect();
  }

  Future<void> _initilize() async {
    await this.hub.disconnect();
    await this.hub.connect();
    await scanForWIFI();
  }

  Future<void> scanForWIFI() async {
    isScanning.value = true;
    Print.yellow("Now scanning");
    List<BluetoothService> services = await this.hub.discoverServices();
    services.forEach((service) async {
      if (service.uuid.toString() == BLE_SERVICE_UUID) {
        service.characteristics.forEach((characteristic) async {
          if (characteristic.properties.read &&
              characteristic.uuid.toString() == BLE_CHARACTERISTIC_READ_UUID) {
            List<int> ssidBuffers = await characteristic.read();
            List<String> ssids = utf8.decode(ssidBuffers).split(',');
            List<Map<String, String>> wifiSsids = [];
            for (int i = 0; i < ssids.length; i++)
              if (ssids[i].length > 0) wifiSsids.add({"ssid": ssids[i]});
            wifi.value = wifiSsids;
            if (wifiSsids.isEmpty) isManual.value = true;
            else isManual.value = false;
            // Remove it later
            print(wifi.value);
            isScanning.value = false;
          }
        });
      }
    });
    isScanning.value = false;
  }

  bool _validate() {
    String message = "";
    if (password.text.isEmpty) message = "";
    if (ssid.text.isEmpty) message = "Please enter a SSID";
    if (message.isNotEmpty)
      CustomDialog(
        title: "Alert",
        message: message,
      ).show();
    return message.isEmpty;
  }

  void sendWifiToHub() async {
    if (isLoading.value) return;
    if (!_validate()) return;
    this.isLoading.value = true;
    try {
      final String passKey = await this.getPasskey();
      if (passKey.isEmpty) return;
      // Gets connected during the initilization
      await this.hub.disconnect();
      await this.hub.connect();
      List<BluetoothService> services = await this.hub.discoverServices();
      services.forEach((service) {
        if (service.uuid.toString() == BLE_SERVICE_UUID) {
          service.characteristics.forEach((characteristic) async {
            if (characteristic.properties.write &&
                characteristic.uuid.toString() ==
                    BLE_CHARACTERISTIC_WRITE_UUID) {
              String dataString =
                  '{"ssid": "${ssid.text}", "password": "${password.text}", "passkey":"$passKey","uuid":"${characteristic.uuid.toString()}"}';
              print(dataString);
              await characteristic.write(utf8.encode(dataString));
              print('Data Wrote');
              await this.hub.disconnect();
              // Get.offNamed('/scan');
              checkHubStatus();
            }
          });
        }
      });
    } catch (e) {
      print(e.toString());
      ErrorHandler(e).handle();
    } finally {
      this.isLoading.value = false;
    }
  }

  Future<String> getPasskey() async {
    String passCode = '';
    print(this.hub.id.toString());
    // this.hub.name to be changed to uuid of the hub
    await Get.find<Service>()
        .linkUser(this.hub.name.toString())
        .then((response) {
      passCode = response.data['result']['passkey'];
    }).catchError((error) {
      ErrorHandler(error).handle();
    });
    return passCode;
  }

  void selectWifi(Map<String, dynamic> wifi) {
    selectedWifi.value = wifi;
    ssid.text = wifi['ssid'];
  }

  void _getSetup() async {
    this.isLoading.value = true;
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
      ErrorHandler(error).handle().then((value) {
        _getSetup();
      });
    });
    this.isLoading.value = false;
  }

  void checkHubStatus() async {
    this.showTimer();
    // countDown.value = 15;
    // defaultTimer = Timer(Duration(seconds: 1),(){
    //   countDown.value--;
    // });
    int count = 0;
    int i = 0;
    this.isLoading.value = true;
    Timer.periodic(
      Duration(
        seconds: 3,
      ),
      (timer) async {
        count++;
        if (count > 5) {
          this.isLoading.value = false;
          timer.cancel();
          defaultTimer?.cancel();
          Get.back();
          _onStatusError();
        }

        if (await getStatus()) {
          Timer.periodic(Duration(seconds: 2),
          (timerInner){
            i++;
            if(i==2) countDownText.value = "Connected to WiFi Successfully!";
            else if(i==3) countDownText.value = "Connecting to Woosh Sever...";
            else if(i==4) countDownText.value = "Connected to Woosh Sever!";
            else if(i==5) {
              timerInner.cancel();
              defaultTimer?.cancel();
              Get.back();
              this.isLoading.value = false;
              timer.cancel();
              _getSetup();
            }
          });
          
        }
      },
    );
  }

  void showTimer() {
    RxInt countDown = 25.obs;
    defaultTimer = Timer.periodic(Duration(seconds: 1),(defaultTimer) async {
      countDown.value = countDown.value-1;
    });
    Get.defaultDialog(
      barrierDismissible: false,
      title: "Please wait",
      middleText: "while we confirm your hub's connectivity",
      content: Container(
        child: Obx(
          (){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${countDown.value}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)),
                SizedBox(height: 10),
                Text(countDownText.value),
              ],
            );
          }
        )
      )
    );
  }

  Future<bool> getStatus() async {
    bool status = false;
    await Get.find<Service>().getHubStatus().then((value) {
      if (value.data["result"]["status"]) status = true;
    }).catchError((error) {
      Print.red(error);
    });

    return status;
  }

  void _onStatusError() {
    Get.defaultDialog(
      title: 'Connection error',
      middleText: 'Please check the WiFi password and reconnect',
    );
  }
}
