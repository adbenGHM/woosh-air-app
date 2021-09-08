import 'package:flutter/material.dart';
import 'package:woosh/AppMeta/metaData.dart';
import 'package:get/get.dart';
import 'package:woosh/Components/Components.dart';
import 'package:woosh/Controllers/Splash_controller.dart';

class Splash extends StatelessWidget {
  final bigCircleDiameter = 600 * scaleScreen;
  final smallCircleDiameter = 350 * scaleScreen;
  final SplashController controller = Get.put(SplashController());

  Widget _buildScreen() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Positioned(
          top: 20 * scaleScreen,
          left: -120 * scaleScreen,
          child: Container(
            height: bigCircleDiameter,
            width: bigCircleDiameter,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bigCircleColor,
            ),
          ),
        ),
        Positioned(
          bottom: -140 * scaleScreen,
          right: smallCircleDiameter * -0.1917,
          child: Container(
            height: smallCircleDiameter,
            width: smallCircleDiameter,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: smallCircleColor,
            ),
          ),
        ),
        Positioned(
          top: 200 * scaleScreen,
          left: 15,
          width: Get.width,
          child: Image.asset(
            mainLogo,
          ),
        ),
        Positioned(
          top: Get.height * 0.686,
          width: Get.width,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomText.primary(
                      "Keep the air",
                    ),
                    CustomText.primary(
                      "flowing",
                    ),
                    SizedBox(height: 10),
                    CustomText(
                      "Never breathe into dust",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: screenBackgroundColor,
      body: _buildScreen(),
    );
  }
}
