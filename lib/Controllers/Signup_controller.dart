
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woosh/DebugTool/DebugTool.dart';
import 'package:woosh/Service/Service.dart';

class SignupController extends GetxController {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    Print.yellow("SIGNUP CONTROLLER INIT");
  }

  void signup() async {
    if (isLoading.value) return;
    isLoading.value = true;

    Print.yellow('Name: ${nameController.text}');
    Print.yellow('Email: ${emailController.text}');
    Print.yellow('Password: ${passwordController.text}');

    await Get.find<Service>().signup(
      nameController.text,
      emailController.text,
      passwordController.text,
    )
    .then((response) async {
      Get.offAllNamed('/login');
      Get.snackbar("Successfully Register",
      "Welcome, ${nameController.text} please check your email to validate",
      snackPosition: SnackPosition.BOTTOM);
    }).catchError((error) {
      if(error.response.statusCode == 400)
        Get.snackbar("Error",
         "User exists with this email, please try to login",
        snackPosition: SnackPosition.BOTTOM);
      else{
         Get.snackbar("Server Error",
         "Ops, something went wrong !",
          snackPosition: SnackPosition.BOTTOM);
      }
      Print.red(error);
    });

    isLoading.value = false;
  }
}
