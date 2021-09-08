import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:woosh/AppMeta/metaData.dart';
import 'package:woosh/Components/Components.dart';
import 'package:woosh/Controllers/BluetoothScreen_controller.dart';

class Bluetooth extends StatelessWidget {
  // final List<ScanResult> devices;

  final BluetoothScreenController controller =
      Get.put(BluetoothScreenController(Get.arguments));

  Bluetooth({
    Key? key,
  }) : super(key: key);

  Widget _buildHubs() {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxHeight: 300,
        minHeight: Get.height * 0.2,
      ),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return false;
        },
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                
                ...controller.finalDevices.value.map(
                  (e) => TextButton(
                    onPressed: () => controller.setupWIFI(e.device),
                    child: CustomText(
                      e.device.name,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScreen() {
    return Container(
      decoration: BoxDecoration(
        gradient: screenBackGradient,
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: screenPaddingType1,
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                children: <Widget>[
                  CustomBanner(
                    wrap: true,
                    banner: banner2,
                    bannerTitle: controller.finalDevices.value.length>1?
                                        "Multiple Hubs were found !"
                                        :controller.finalDevices.value.length==0?
                                        "No Hub has been discovered, please rescan"
                                        :"Woosh Hub has been discovered",
                    bannerText: "Please pair and connect",
                    height: 170 * scaleScreen,
                  ),
                  SizedBox(height: scaleScreen * 50),
                  CustomText(
                    "Select a hub",
                    fontWeight: FontWeight.w500,
                    color: Color(0xff5C5C5C),
                  ),
                  SizedBox(height: 15),
                  _buildHubs(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.refresh_rounded,
          color: Colors.white
        ),
        onPressed: () => Get.offAllNamed('/discover_hub'),
        backgroundColor: primaryColor,
        elevation: 0.0,
        mini: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: screenBackGradient,
        ),
        child: SafeArea(
          child: _buildScreen(),
        ),
      ),
    );
  }
}
