import 'package:flutter/cupertino.dart';

class ToBuyProductPageProvider extends ChangeNotifier {
  TextEditingController numberController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  int current = -1;
  changeCurrent(int v) {
    current = v;
    notifyListeners();
  }

  bool isCashOnPayment = false;
  changeIsCashOnPayment(bool v) {
    isCashOnPayment = v;
    notifyListeners();
  }

  bool statusOfPayment = false;
  changeStatusOfPayment(bool v) {
    statusOfPayment = v;
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
    statusOfPayment = false;
    isCashOnPayment = false;
    
    notifyListeners();
  }
}
