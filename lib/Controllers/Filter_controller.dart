import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woosh/AppMeta/metaData.dart';
import 'package:woosh/Components/Components.dart';
import 'package:woosh/DebugTool/DebugTool.dart';
// import 'package:woosh/Controllers/Global/StorageController.dart';
import 'package:woosh/Service/ErrorHandler.dart';
import 'package:woosh/Service/Service.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}

class FilterController extends GetxController {
  RxList<Map> hubs = <Map>[].obs;
  RxList<Map> pressures = <Map>[].obs;
  final TextEditingController filterName = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final Loader loader = Loader();
  RxString pincode = "".obs;
  RxList<Map> indoorAirQuality = <Map>[].obs;
  RxList<Map> outdoorAirQuality = <Map>[].obs;
  RxBool isHubOnline = true.obs;
  RxDouble today = (-1.0).obs;
  RxString todayDateLocation = "".obs;
  RxDouble tomorrow = (-1.0).obs;
  RxDouble dayAfterTomorrow = (-1.0).obs;

  @override
  void onInit() {
    super.onInit();
    Print.yellow("FILTER CONTROLLER INIT");
    initilize();
  }

  Future initilize() async {
    await Future.wait(
      [
        getHubs(),
        getIndoorAir(),
        getPincode(),
        checkHubOnline(),
      ],
    );
  }

  Future getHubs() async {
    await Get.find<Service>().getHubs().then((response) {
      Print.magenta(response.data["result"][0]["connected_nodes"]);
      hubs.value = [...response.data["result"][0]["connected_nodes"]];
      pressures.value = [...response.data["result"][1]["chart"]];
    }).catchError((error) {
      ErrorHandler(error).handle();
    });
  }

  void deleteFilter(String nodeId, String name) {
    Get.defaultDialog(
      title: 'Are you sure ?',
      middleText: 'You want to delete $name',
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
          unlinkNode(nodeId);
        },
        child: CustomText(
          "Delete",
          color: primaryColor,
        ),
      ),
    );
  }

  void handleConfigure() async {
    await Get.find<Service>().unlinkHub(false).then((value) {
      print(value.toString());
      Get.offAllNamed('/discover_hub');
    }).catchError((error) {
      ErrorHandler(error).handle();
    });
  }

  void unlinkNode(String nodeId) async {
    await Get.find<Service>().unlinkNode(nodeId).then((response) async {
      loader.show();
      await getHubs();
      loader.remove();
    }).catchError((error) {
      ErrorHandler(error).handle();
    });
  }

  Future checkHubOnline() async {
    await Get.find<Service>().getHubStatus().then((response) async {
      isHubOnline.value = response.data["result"]["status"];
    });
  }

  void onScan() async {
    String scanner = await FlutterBarcodeScanner.scanBarcode(
      "#66ff66",
      "Cancel",
      true,
      ScanMode.QR,
    );
    if (scanner != '-1') validate(scanner);
  }

  void validate(String filter) async {
    bool isValidated = false;
    await Get.find<Service>().validateFilter(filter).then((response) {
      isValidated = true;
    }).catchError((error) {
      Print.green(error);
      ErrorHandler(error).handle();
    });
    if (isValidated) getFilterName(filter);
  }

  void getFilterName(String filter) {
    filterName.text = 'Air filter ${hubs.value.length+1}';
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
    await Get.find<Service>().linkNode(node, filterName.text).then((response) {
      Print.green(node);
      loader.show();
      getHubs();
      loader.remove();
    }).catchError((error) {
      Print.red(error);
      ErrorHandler(error).handle();
    });
  }

  Future getIndoorAir() async {
    await Get.find<Service>().getIndoorAirQuality().then((value) {
      Print.green(value);
      indoorAirQuality.value = [
        ...value.data["result"].map((e) => {
              "value": int.parse(e["value"]),
              "date": DateFormat()
                  .add_Md()
                  .format(DateTime.parse(e["date"]))
                  .toString(),
            })
      ];
      Print.green(indoorAirQuality.value);
    }).catchError((error) {
      Print.red(error);
    });
  }

  Future getOutdoorAir() async {
    await Get.find<Service>().getOutdoorAirQuality(pincode.value).then((value) {
      Print.green(value.data["result"]); 
      outdoorAirQuality.value = [
        ...value.data["result"].map((e) {
          if (DateTime.now().isSameDate(DateTime.parse(e["date"]))) {
            today.value = e["value"].toDouble();
            todayDateLocation.value =
                '${e["area"]},${e["state"]} - ${DateFormat().add_MMMd().format(DateTime.parse(e["date"]))}';
          }
          if (DateTime.now()
              .add(Duration(days: 1))
              .isSameDate(DateTime.parse(e["date"])))
            tomorrow.value = e["value"].toDouble();
          if (DateTime.now()
              .add(Duration(days: 2))
              .isSameDate(DateTime.parse(e["date"])))
            dayAfterTomorrow.value = e["value"].toDouble();

          return {
            "value": e["value"],
            "area": e["area"],
            "date": DateFormat()
                .add_Md()
                .format(DateTime.parse(e["date"]))
                .toString(),
          };
        })
      ];
      Print.green(outdoorAirQuality.value);
    }).catchError((error) {
      Print.red(error);
    });
  }

  Future getPincode() async {
    await Get.find<Service>().getPincode().then((value) {
      Print.green(value.data);
      pincode.value = value.data["result"]["zipcode"];
      if (pincode.value.isNotEmpty) getOutdoorAir();
      else {
        addPincode();
      }
    }).catchError((error) {
      Print.red(error);
    });
  }

  void addPincode() {
    Get.defaultDialog(
      title: "Zipcode",
      onWillPop: () async {
        pincodeController.text = "";
        return true;
      },
      content: Column(
        children: <Widget>[
          InputFormCustom(
            controller: pincodeController,
            inputAction: TextInputAction.done,
            hintText: "Enter zipcode",
            keyboadType: TextInputType.phone,
          ),
          SizedBox(height: 20),
          NextButton(
            onTap: () {
              if (pincodeController.text.isNotEmpty) {
                Get.back();
                setPincode();
              }
            },
          ),
        ],
      ),
    );
  }

  void setPincode() async {
    // loader.show();
    await Get.find<Service>().setPincode(pincodeController.text).then((value) {
      Print.green(value.data);
      pincode.value = pincodeController.text;
      pincodeController.text = "";
      getPincode();
      CustomDialog(
        title: "Success",
        message: "Zipcode updated successfully",
      ).show();
    }).catchError((error) {
      Print.red(error);
      ErrorHandler(error).handle();
    });
    // loader.remove();
  }

  List<Map> getPressure(String id) {
    List<Map> res = [];
    pressures.value.forEach((pressure) {
      if (pressure["_id"] == id) res = [...pressure['data']];
    });

    return res;
  }

  void onChangeFilterName(String filterId) {
    Get.defaultDialog(
      title: "Update filter name",
      onWillPop: () async {
        filterName.text = "";
        return true;
      },
      content: Column(
        children: <Widget>[
          InputFormCustom(
            controller: filterName,
            inputAction: TextInputAction.done,
            hintText: "Enter name",
          ),
          SizedBox(height: 20),
          NextButton(
            onTap: () {
              if (filterName.text.isNotEmpty) {
                Get.back();
                updateName(filterId);
              }
            },
          ),
        ],
      ),
    );
  }

  void updateName(String filterId) async {
    await Get.find<Service>()
        .changeFilterName(filterName.text, filterId)
        .then((value) {
      getHubs();
      filterName.text = "";
      CustomDialog(
        title: "Success",
        message: "Name successfully updated",
      ).show();
    }).catchError((error) {
      ErrorHandler(error).handle();
    });
  }

  List<dynamic>? getColor(double value) {
    if (value < 50)
      return [Color(0xff01FF00), "Good"];
    else if (value < 100)
      return [Color(0xffFFFF00), "Moderate"];
    else if (value < 150)
      return [Color(0xffFF9900), "Unhealthy for sensitive groups"];
    else if (value < 200)
      return [Color(0xffFF0000), "Unhealthy"];
    else if (value < 300)
      return [Color(0xff8E7CC3), "Very Unhealthy"];
    else
      return [Color(0xff84210D), "Hazardous"];
  }
}
