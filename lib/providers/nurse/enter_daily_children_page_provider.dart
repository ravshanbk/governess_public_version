import 'package:flutter/material.dart';
import 'package:governess/consts/print_my.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';

class NurseEnterChildrenNumberPageProvider extends ChangeNotifier {
  int? length;
  DateTime? when;
  changeWhen(DateTime date) {
    p("ChangeWhen: "+DTFM.maker(date.millisecondsSinceEpoch));
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
