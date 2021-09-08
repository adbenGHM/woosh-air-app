import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:woosh/DebugTool/DebugTool.dart';

class Storage {
  final FlutterSecureStorage storage = new FlutterSecureStorage();

  Future<bool> clearStorage() async {
    await storage.deleteAll();
    return true;
  }

  Future<bool> deleteUserData() async {
    await storage.delete(key: "USER");
    await storage.delete(key: "TOKEN");
    return true;
  }

  Future<bool> storeUser(Map user) async {
    await storage.write(key: "USER", value: jsonEncode(user));
    return true;
  }

  Future<Map?> getUser() async {
    String? user = await storage.read(key: "USER");
    Print.green(user);
    Map? decodeUser = user == null ? null : jsonDecode(user);
    return decodeUser;
  }

  Future<bool> storeToken(String token) async {
    await storage.write(key: "TOKEN", value: token);
    return true;
  }

  Future<String?> getToken() async {
    String? token = await storage.read(key: "TOKEN");
    return token;
  }
}
