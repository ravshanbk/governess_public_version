import 'package:flutter/cupertino.dart';

class ApplyApplicationPageProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<StringedController> companyInfoControllers = List.generate(
    companyInfoControllerNames.length,
    (i) => StringedController(
      key: companyInfoControllerNames[i],
      controller: TextEditingController(),
      keyboardType: i > 2 ? TextInputType.phone : TextInputType.name,
      node: FocusNode(),
    ),
  );

  List<StringedController> leaderInfoControllers = List.generate(
    leaderInfoControllerNames.length,
    (index) => StringedController(
      key: leaderInfoControllerNames[index],
      controller: TextEditingController(),
      keyboardType: index == 4 ? TextInputType.phone : TextInputType.name,
      node: FocusNode(),
    ),
  );

  static List<String> companyInfoControllerNames = [
    "Kopmaniya nomi",
    "Ko'cha",
    "Tuman",
    "INN",
    "MFO",
    "Hisob raqami",
    "Telefon raqami",
  ];
  static List<String> leaderInfoControllerNames = [
    "Ismi",
    "Otasining Ismi",
    "Familiyasi",
    "Nick Name",
    "Telefon raqami",
    "Parol",
  ];
}
// "accountNumber": "20201122334455667788",
//   "companyName": "Bekorchi MCHJ",
//   "districtId": 14,
//   "inn": "123456789",
//   "mfo": "00278",
//   "street": "Tinchklik ko`chasi",
//   "phoneNumber": "123456789",

//   "leaderName": "XXX",
//   "leaderFatherName": "XXX",
//   "leaderPhoneNumber": "123456789",
//   "leaderSurname": "XXX",
//   "password": "123456789",
//   "userName": "taminottest"
class StringedController {
  final FocusNode node;
  final TextInputType keyboardType;
  final String key;
  final TextEditingController controller;
  StringedController(
      {required this.key,
      required this.controller,
      required this.keyboardType,
      required this.node});
}
