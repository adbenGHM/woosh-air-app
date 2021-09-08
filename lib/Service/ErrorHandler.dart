import 'package:woosh/Components/Components.dart';

class ErrorHandler {
  dynamic error;
  ErrorHandler(this.error);

  Future handle() async {
    String message = "";
    try {
      message = error.response.data["message"];
    } catch (e) {
      message = "Please check your internet connectivity";
    }

    await CustomDialog(
      title: "Alert",
      message: message,
    ).show();
  }

  void showCustomError(){
    String message = "";
    try {
      message = error;
    } catch (e) {
      message = "Please check your internet connectivity";
    }
    CustomDialog(
      title: "Alert",
      message: message,
    ).show();
  }
}
