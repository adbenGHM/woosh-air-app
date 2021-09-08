import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:woosh/Routes/Routes.dart';
import 'package:woosh/Controllers/Global/Global.dart';
import 'package:woosh/DebugTool/DebugTool.dart';
import 'package:woosh/Service/Service.dart';

void main() async {
  await initService();
  runApp(MyApp());
}

Future<void> initService() async {
  Print.yellow('STARTING SERVICE...');
  await Get.putAsync(() async => Service());
  Print.yellow('ALL SERVICE STARTED');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: GlobalController(),
      themeMode: ThemeMode.light,
      title: 'Woosh',
      getPages: routes,
      initialRoute: '/splash',
    );
  }
}
