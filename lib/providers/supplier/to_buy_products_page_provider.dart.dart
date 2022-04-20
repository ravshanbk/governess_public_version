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

  clear() {
    numberController.clear();
    commentController.clear();
    notifyListeners();
  }
}
