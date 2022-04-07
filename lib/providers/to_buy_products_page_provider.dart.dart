import 'package:flutter/cupertino.dart';
import 'package:governess/models/supplier/product_model.dart';

class ToBuyProductPageProvider extends ChangeNotifier {
  TextEditingController numberController = TextEditingController();
  TextEditingController commentController = TextEditingController();

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
