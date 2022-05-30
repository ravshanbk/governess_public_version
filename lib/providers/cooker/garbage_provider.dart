import 'package:flutter/cupertino.dart';

class GarbageProvider extends ChangeNotifier {
  int current = -1;
  changeCurrent(int v) {
    current = v;
    notifyListeners();
  }

  TextEditingController numberController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  clearNumberController() {
    numberController.clear();
    notifyListeners();
  }

  clear() {
    numberController.clear();
    commentController.clear();
    notifyListeners();
  }
}
