import 'package:get/get.dart';
import 'package:woosh/AppMeta/metaData.dart';
import 'package:dio/dio.dart';
import 'package:woosh/Controllers/Global/StorageController.dart';
import 'package:woosh/DebugTool/DebugTool.dart';

class Service extends GetxService {
  final Dio dio = new Dio();

  @override
  void onInit() {
    super.onInit();
    Print.yellow("SERVICE INIT");
    initilize();
  }

  void initilize() {
    dio.options.baseUrl = baseUrl;
  }

  Future<dynamic> login(String email, String password) async {
    return await dio.post(
      '/user/login',
      data: {
        'email': email,
        'password': password,
      },
    );
  }

  Future<dynamic> stepSetup() async {
    final String? token = Get.find<StorageController>().token;
    return await dio.get(
      '/user/setup-status',
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );
  }

  Future<dynamic> signup(String name, String email, String password) async {
    return await dio.post(
      '/user/register',
      data: {
        'name': name,
        'email': email,
        'password': password,
      },
    );
  }

  Future<dynamic> googleLogin(String email, String name) async {
    return await dio.post(
      '/user/google-login',
      data: {
        'name': name,
        'email': email,
      },
    );
  }

  Future<dynamic> linkUser(String deviceId) async {
    final String? token = Get.find<StorageController>().token;
    return await dio.post('/hub/link-user',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
        data: {"device_id": deviceId});
  }

  Future<dynamic> linkNode(String nodeId, String name) async {
    final String? token = Get.find<StorageController>().token;
    return await dio.post('/hub/link-node',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
        data: {
          "node_id": nodeId,
          "name": name,
        });
  }

  Future<dynamic> unlinkNode(String nodeId) async {
    final String? token = Get.find<StorageController>().token;
    return await dio.post('/hub/unlink-node',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
        data: {
          "node_id": nodeId,
        });
  }

  Future<dynamic> getHubs() async {
    final String? token = Get.find<StorageController>().token;
    return await dio.get(
      '/hub',
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );
  }

  Future<dynamic> validateFilter(String filter) async {
    final String? token = Get.find<StorageController>().token;
    return await dio.get(
      '/node/available/$filter',
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );
  }

  Future<dynamic> getNotification() async {
    final String? token = Get.find<StorageController>().token;
    return await dio.get(
      '/notification/all',
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );
  }

  Future<dynamic> readAllNotification() async {
    final String? token = Get.find<StorageController>().token;
    return await dio.get(
      '/notification/read-all',
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );
  }

  Future<dynamic> getPendingNotification() async {
    final String? token = Get.find<StorageController>().token;
    return await dio.get(
      '/notification/pending',
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );
  }

  Future<dynamic> deleteNotification(String id) async {
    final String? token = Get.find<StorageController>().token;
    return await dio.post(
      '/notification/delete',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
      data: {
        "notification_id": id,
      },
    );
  }

  Future<dynamic> unlinkHub(bool isFullReset) async {
    final String? token = Get.find<StorageController>().token;
    return await dio.post(
      '/hub/unlink-user',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
      data: {
        "full_reset": isFullReset,
      },
    );
  }

  Future<dynamic> getHubStatus() async {
    final String? token = Get.find<StorageController>().token;
    return await dio.get(
      '/hub/online',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<dynamic> getIndoorAirQuality() async {
    final String? token = Get.find<StorageController>().token;
    return await dio.get(
      '/util/get-aqi-chart',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<dynamic> getOutdoorAirQuality(String pincode) async {
    final String? token = Get.find<StorageController>().token;
    return await dio.get(
      '/util/get-aqi-chart/$pincode',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<dynamic> getPincode() async {
    final String? token = Get.find<StorageController>().token;
    return await dio.get(
      '/user/zipcode',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<dynamic> setPincode(String pincode) async {
    final String? token = Get.find<StorageController>().token;
    return await dio.post(
      '/user/zipcode',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
      data: {
        "zipcode": pincode,
      },
    );
  }

  Future<dynamic> changeFilterName(String name, String id ) async {
    final String? token = Get.find<StorageController>().token;
    return await dio.post(
      '/node/change-name',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
      data: {
        "node_id": id,
        "name": name,
      },
    );
  }
}
