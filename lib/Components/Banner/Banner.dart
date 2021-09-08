import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woosh/Components/Components.dart';

class CustomBanner extends StatelessWidget {
  final String banner;
  final double? height;
  final String bannerTitle;
  final String bannerText;
  final bool wrap;

  const CustomBanner({
    Key? key,
    required this.banner,
    this.height = 0,
    this.bannerTitle = "",
    this.bannerText = "",
    this.wrap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.11,
        vertical: Get.width * 0.11,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(27),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xffe3e3e3),
            blurRadius: 3.0,
            offset: Offset(0, 5),
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomText.primary(
            bannerTitle,
            wrap: wrap
          ),
          SizedBox(height: 9),
          CustomText(
            bannerText,
            wrap: wrap,
          ),
          SizedBox(height: Get.height * 0.0549),
          Image.asset(
            banner,
            height: height,
          ),
        ],
      ),
    );
  }
}
