import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:governess/local_storage/boxes.dart';

class PinCodePageProvider extends ChangeNotifier {
  static Options? option;

  // static String localhost = "http://185.217.131.117:7788";
  static String localhost = "http://192.168.43.54:7788";

  initAuthorization() {
    option = Options(headers: {
      "Authorization": Boxes.getUser().values.first.token,
    });
    notifyListeners();
  }

  bool idf = false;
  changeIdf(bool v) {
    idf = v;
    notifyListeners();
  }

  TextEditingController pinCodeController = TextEditingController();
  TextEditingController savePinCodeController = TextEditingController();
  TextEditingController repeatePinCodeController = TextEditingController();
  clear() {
    pinCodeController.text = "";
    savePinCodeController.text = "";
    repeatePinCodeController.text = "";
    notifyListeners();
  }

  @override
  void dispose() {
    pinCodeController.dispose();
    savePinCodeController.dispose();
    repeatePinCodeController.dispose();
    super.dispose();
  }
}



