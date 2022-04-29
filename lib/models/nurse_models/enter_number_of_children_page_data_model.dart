import 'package:flutter/cupertino.dart';
import 'package:governess/models/nurse_models/age_group_id_and_number_model.dart';
import 'package:governess/models/nurse_models/age_group_model.dart';

class NurseEnterNumberChildrenPageData {
  
  AgeGroup ageGroupIdAndNumber;
  TextEditingController controller;
  FocusNode nodes;
  bool idf;
  NurseEnterNumberChildrenPageData(
      {required this.ageGroupIdAndNumber,
      required this.controller,
      required this.idf,
      required this.nodes});
}
