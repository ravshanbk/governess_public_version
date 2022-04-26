import 'package:flutter/cupertino.dart';

class PinCodePageProvider extends ChangeNotifier {
  bool idf = false;
  changeIdf(bool v) {
    idf = v;
    notifyListeners();
  }

  TextEditingController pinCodeController = TextEditingController();
  TextEditingController savePinCodeController = TextEditingController();
  TextEditingController repeatePinCodeController = TextEditingController();
  clear() {
    pinCodeController.clear();
    savePinCodeController.clear();
    repeatePinCodeController.clear();
    notifyListeners();
  }
}
