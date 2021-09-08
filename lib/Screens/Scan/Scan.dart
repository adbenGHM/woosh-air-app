import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woosh/AppMeta/metaData.dart';
import 'package:woosh/Components/Components.dart';
import 'package:woosh/Controllers/Scan_controller.dart';

class Scan extends StatelessWidget {
  Scan({Key? key}) : super(key: key);

  final ScanScreenController _controller = Get.put(ScanScreenController());

  Widget _buildQRList() {
    return Column(
      children: <Widget>[
        CustomText.primary(
          "Your Filter",
        ),
        SizedBox(height: 15),
        ..._controller.qr.value.map(
          (e) => Container(
            margin: EdgeInsets.symmetric(vertical: 2),
            child: CustomText(
              e,
              // fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildScanButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            InkWell(
              onTap: _controller.onScan,
              child: Image.asset(
                scan_scanLogo,
                scale: 1.2,
              ),
            ),
            SizedBox(height: 10),
            CustomText(
              "Add filter",
              color: Color(0xff5C5C5C),
            ),
            SizedBox(height: 10),
            TextButton(
              child: Text("Skip"),
              onPressed: _controller.onNext
            )
          ],
        ),
        _controller.qr.value.isNotEmpty
            ? Row(
                children: <Widget>[
                  VerticalDivider(),
                  NextButton(
                    isLoading: _controller.isLoading.value,
                    onTap: _controller.onNext,
                  ),
                ],
              )
            : SizedBox(),
      ],
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
              child: Obx(
                () => Column(
                  children: <Widget>[
                    CustomBanner(
                      banner: banner3,
                      wrap: true,
                      bannerTitle: "Let’s setup your woosh filter",
                      bannerText: _controller.qr.value.isEmpty
                          ? "Pull down on the green tab to connect to battery"
                          : "You can start using the app or add more filters",
                      height: 230 * scaleScreen,
                    ),
                    SizedBox(height: scaleScreen * 50),
                    _controller.qr.value.isNotEmpty
                        ? _buildQRList()
                        : SizedBox(),
                    _buildScanButton(),
                  ],
                ),
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
