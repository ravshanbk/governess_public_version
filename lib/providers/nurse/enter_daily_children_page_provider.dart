import 'package:flutter/material.dart';

class NurseEnterChildrenNumberPageProvider extends ChangeNotifier {
  int? length;
  DateTime when = DateTime.now();
  changeWhen(DateTime date) {
    when = date;
    notifyListeners();
  }

  //////////////////////////
  bool idf = false;

  List<bool> idfs = [];
  List<FocusNode>? nodes;
  List<TextEditingController>? controllers;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  initControllersAndNodes(int v) {
    when = DateTime.now();
    length = v;
    idf = true;
    nodes = List.generate(v, (index) => FocusNode());
    idfs = List.generate(v, (index) => false);

    controllers = List.generate(v, (index) => TextEditingController());
    notifyListeners();
  }

  clearOneController(int n) {
    controllers![n].clear();
    notifyListeners();
  }

  clearControllers() {
    idf = false;
    for (int i = 0; i < controllers!.length; i++) {
      controllers![i].clear();
    }
    notifyListeners();
  }

  regenerateIdfs(int v) {
    idfs = List.generate(length!, (index) => v == index);

    notifyListeners();
  }
}
