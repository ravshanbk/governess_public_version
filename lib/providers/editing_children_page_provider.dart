import 'package:flutter/cupertino.dart';

class EditingChildrenNumberPageProvider extends ChangeNotifier {
  List<TextEditingController>? controllers;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  initControllers(List<int> v) {
    controllers = List.generate(
        v.length, (index) => TextEditingController(text: v[index].toString()));
    notifyListeners();
  }

  clearControllers() {
    for (int i = 0; i < controllers!.length; i++) {
      controllers![i].clear();
    }
    notifyListeners();
  }
}
