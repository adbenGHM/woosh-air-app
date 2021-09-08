// import 'dart:async';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woosh/Controllers/Global/Dashboard_controller.dart';
import 'package:woosh/Controllers/Global/StorageController.dart';
import 'package:woosh/DebugTool/DebugTool.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:woosh/Service/Service.dart';
import 'package:woosh/Components/Components.dart';
import 'package:woosh/Service/ErrorHandler.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    Print.yellow("LOGIN CONTROLLER INIT");
  }

  bool validate() {
    String message = "";
    if (passwordController.text.length <= 4)
      message = "Please enter a valid password";
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text)) message = "Please enter a valid email";

    if (message.isNotEmpty)
      CustomDialog(
        title: "Alert",
        message: message,
      ).show();

    return message == "";
  }

  void login() async {
    if (isLoading.value) return;
    if (!validate()) return;
    isLoading.value = true;

    Print.yellow('Email: ${emailController.text}');
    Print.yellow('Password: ${passwordController.text}');
    await Get.find<Service>()
        .login(
      emailController.text,
      passwordController.text,
    )
        .then((response) async {
      Print.green(response);
      String token = response.data["result"]["token"];
      Map<String, dynamic> data = response.data["result"]["user"];
      await Get.find<StorageController>().updateToken(token);
      await Get.find<StorageController>().updateUserData(data);
      Print.green(data);
      // Get.offAllNamed('/discover_hub');
      _getSetup();
    }).catchError((error) {
      ErrorHandler(error).handle();
    });

    isLoading.value = false;
  }

  void handleGoogleLogin() {
    if (isLoading.value) return;
    Print.yellow("GOOGLE LOGIN");
    _handleSignIn();
  }

  Future<void> _handleSignIn() async {
    isLoading.value = true;
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'profile',
      ],
    );
    await _googleSignIn.signOut();
    try {
      GoogleSignInAccount? google = await _googleSignIn.signIn();

      if (google == null) return;

      String email = google.email;
      String name = google.displayName ?? "";

      await Get.find<Service>().googleLogin(email, name).then((response) async {
        Print.green(response);
        String token = response.data["result"]["token"];
        Map<String, dynamic> data = response.data["result"]["user"];
        await Get.find<StorageController>().updateToken(token);
        await Get.find<StorageController>().updateUserData(data);
        Print.green(data);
        // Get.offAllNamed('/discover_hub');
        _getSetup();
      }).catchError((error) {
        Print.red(error);
      });
    } catch (error) {
      ErrorHandler(error).handle();
    } finally {
      isLoading.value = false;
    }
  }

  void _getSetup() async {
    Get.find<DashoardController>().getPendingNotification();
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
      ErrorHandler(error).handle().then((value) async {
        if(error.response.data["code"] == 401){
          await Get.find<StorageController>().logout();
          Get.offNamed('/login');
        }
        else{
        _getSetup();
        }
      });
    });
  }
}
