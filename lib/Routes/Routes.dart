import 'package:get/get.dart';

/// IMPORTING THE PAGES HERE
import 'package:woosh/Screens/Splash.dart';
import 'package:woosh/Screens/Login/Login.dart';
import 'package:woosh/Screens/Signup/Signup.dart';
import 'package:woosh/Screens/DiscoverHub/DiscoverHub.dart';
import 'package:woosh/Screens/Bluetooth/Bluetooth.dart';
import 'package:woosh/Screens/WIFI/WIFI.dart';
import 'package:woosh/Screens/Scan/Scan.dart';
import 'package:woosh/Screens/Dashboard/Dashboard.dart';

/// THE VARIABLE [Routes] HOLDS ALL THE PAGES
/// REQUIRED PARAMETES FOR [GetPage] ARE
/// [name]
/// [page]
/// [transition]
List<GetPage> routes = [
  GetPage(
    name: '/splash',
    page: () => Splash(),
    transition: Transition.zoom,
  ),
  GetPage(
    name: '/login',
    page: () => Login(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/signup',
    page: () => Signup(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/discover_hub',
    page: () => DiscoverHub(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/bluetooth',
    page: () => Bluetooth(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/wifi',
    page: () => WIFI(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/scan',
    page: () => Scan(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/dashboard',
    page: () => Dashboard(),
    transition: Transition.rightToLeft,
  ),
];
