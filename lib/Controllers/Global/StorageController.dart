import 'dart:async';
import 'package:get/get.dart';
import 'package:woosh/DebugTool/DebugTool.dart';
import 'package:woosh/Storage/Storage.dart';
import 'package:woosh/Models/UserModal.dart';

class StorageController extends GetxController {
  var user = Rx<UserModel>(UserModel());
  String? token = "";

  final Storage storage = new Storage();

  @override
  void onInit() async {
    Print.yellow("STORAGE CONTROLLER INIT");
    await getUserData();
    await getToken();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    Print.yellow("STORAGE CONTROLLER ONREADY");
  }

  Future<UserModel> getUserData() async {
    return await storage.getUser().then((value) {
      user.value = UserModel.fromJSON(value ?? {});
      return user.value;
    });
  }

  Future<String?> getToken() async {
    return await storage.getToken().then((value) {
      token = value;
      return value;
    });
  }

  Future<bool> updateToken(String tkn) async {
    await storage.storeToken(tkn).then((value) {
      token = tkn;
    });
    return true;
  }

  Future<bool> updateUserData(Map<String, dynamic> usr) async {
    await storage.storeUser(usr).then((value) {
      user.value = UserModel.fromJSON(usr);
    });
    return true;
  }

  Future<bool> logout() async {
    return await storage.deleteUserData().then((value) {
      // user.value = null;
      token = "";
      Print.yellow("WARNING: USER DATA CLEARED FROM STORE");
      return value;
    });
  }
}
