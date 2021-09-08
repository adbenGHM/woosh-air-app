import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// THIS METADATA FILE CONTAINS ALL THE META DATA
/// OF THE APPLICATION LIKE [COLORS], [FONTSIZE],
/// [FONTS], [FONTWEIGHT], [PADDING] AND SO ON

///
///
///
///[APPLICATION BASE URL]
const String baseUrl = "http://3.17.139.144:3000";

///
///
///
///
///
///
///

///[*********** APPLICATION FONT SIZE ************]
///META DATA FOR [APPLICATION FONT]
///[GLOBAL FONT SIZE]
const double primaryFontSize = 21.0;
const double secondaryFontSize = 14.0;

///
///
///
///
///
///
///
///
///
///
///
///
///
///
///[*********** APPLICATION TEXT ************]
/// META DATA FOR [APPLICATION TEXT]
/// [GLOBAL TEXT]
const String appTitle = "woosh";

///
///
///
/// [SPLASH SCREEN TEXT]
const String splash_H1 = "Keep the air flowing";
const String splash_P1 = "Neve breadth into dust";

///
///
///
///
///
///
///
///
///
///[****************** COLORS ******************]
/// META DATA FOR [COLORS]
/// [GLOBAL COLORS]
const Color screenBackgroundColor = const Color(0xffffffff);
const Color primaryColor = const Color(0xffB3F392);
const Color secondaryColor = const Color(0xffF1FFE7);
const Gradient screenBackGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xffEFFFE6),
    Color(0xffffffff),
  ],
);

///
///
///
/// [SPLASH SCREEN COLOR]
const Color bigCircleColor = const Color(0xffF7FFF7);
const Color smallCircleColor = const Color(0xffE2FFD2);

/// [LOGIN SCREEN COLOR]
const Color login_HeaderBG = const Color(0xffF7FFF7);
const Color signup_HeaderBG = const Color(0xffF7FFF7);

///
///
///
///
///
///
///
///
///
///
///
///
///
//////[****************** ASSETS ******************]
/// META DATA FOR [ASSETS]
/// [GLOBAL ASSETS]
const String mainLogo = "assets/icons/mainLogo.png";
const String banner1 = "assets/images/b1.png";
const String banner2 = "assets/images/b2.png";
const String banner3 = "assets/images/b3.png";

///
///[LOGIN SCREEN]
const String login_googleLogo = "assets/icons/google.png";
const String login_appleLogo = "assets/icons/apple.png";
const String login_facebookLogo = "assets/icons/facebook.png";

///
///
///[SCAN SCREEN]
const String scan_scanLogo = "assets/icons/scan.png";

///
///
///
///
///
///
///
///
///
///
///
///
///
///[***************************PADDING************************]
///META DATA FOR [PADDING]
///[GLOBAL PADDING]
EdgeInsets screenPaddingType1 = EdgeInsets.symmetric(
  vertical: Get.height * 0.05569,
  horizontal: Get.width * 00.0416,
);

///
///
///
///
///
///
///
///
///
///
///
///[***********************MOCK ASSETS****************************]
///
const double height_mock = 790.0;
const double width_mock = 360.0;
final double scaleScreen = Get.width / width_mock;
