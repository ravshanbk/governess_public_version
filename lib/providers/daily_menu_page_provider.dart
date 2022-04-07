import 'package:flutter/cupertino.dart';

class DailyMenuPageProvider extends ChangeNotifier {
  int current = -1;
  changeCurrent(v) {
    current = v;
    notifyListeners();
  }

 
}
