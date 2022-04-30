import 'package:flutter/cupertino.dart';

class WasteProductCookerPageProvider extends ChangeNotifier {
  TextEditingController numberOfController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  

  clear() {
    numberOfController.clear();
    commentController.clear();
    notifyListeners();
  }
  notify(){
  notifyListeners();

  }
  int current = -1;
  changeCurrent(v) {
    current = v;
    notifyListeners();
  }
  
}
