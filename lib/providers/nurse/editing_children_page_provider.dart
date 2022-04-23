import 'package:flutter/cupertino.dart';

class NurseEditingChildrenNumberPageProvider extends ChangeNotifier {
 

  /////////////////////
  List<FocusNode>? nodes;
  /////////////////////
  List<TextEditingController>? controllers;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  initControllersAndNodes(List<String> v) {
    nodes = List.generate(v.length, (index) => FocusNode());

    controllers = List.generate(
        v.length, (index) => TextEditingController(text: v[index]));
    notifyListeners();
  }

  clearControllers() {
    for (int i = 0; i < controllers!.length; i++) {
      controllers![i].clear();
    }
    notifyListeners();
  }
}
