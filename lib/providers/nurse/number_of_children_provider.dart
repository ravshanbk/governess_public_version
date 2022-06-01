import 'package:flutter/cupertino.dart';

class NurseNumberOfChildrenProvider extends ChangeNotifier {
  String? bytes;
  initBytes(String v) {
    bytes = v;
    notifyListeners();
  }

  clearBytes() {
    bytes = null;
    notifyListeners();
  }
}
