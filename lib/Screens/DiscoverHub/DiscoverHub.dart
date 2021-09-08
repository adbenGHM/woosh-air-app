// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:woosh/AppMeta/metaData.dart';
import 'package:woosh/Components/Components.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:woosh/Controllers/DiscoverHub_controller.dart';

class DiscoverHub extends StatelessWidget {
  DiscoverHub({Key? key}) : super(key: key);

  final DiscoverHubController controller = Get.put(DiscoverHubController());

  Widget _buildScreen() {
    return Container(
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
                    bannerTitle: "Plug in your Woosh hub",
                    bannerText: "Look for green power indicator",
                    height: 300 * scaleScreen,
                  ),
                  SizedBox(height: scaleScreen * 50),
                  CustomText(
                    "Discovering a nearby hub",
                    color: Color(0xff5C5C5C),
                  ),
                  SizedBox(height: 15),
                  SpinKitRipple(
                    color: primaryColor,
                    size: 60.0,
                  ),
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
