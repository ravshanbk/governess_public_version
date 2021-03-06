import 'package:flutter/cupertino.dart';

class CookerAcceptProductProvider extends ChangeNotifier {
  int current = -1;
  changeCurrent(int v) {
    current = v;
    notifyListeners();
  }

  TextEditingController numberController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  initNumberController(String v) {
    numberController.text = v;
    notifyListeners();
  }

  clearNumberController() {
    numberController.clear();
    notifyListeners();
  }

  clear() {
    numberController.clear();
    commentController.clear();
    priceController.clear();
    notifyListeners();
  }

  notify() {
    notifyListeners();
  }
}
