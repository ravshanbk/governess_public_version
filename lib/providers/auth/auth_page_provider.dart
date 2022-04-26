import 'package:flutter/cupertino.dart';

class AuthPageProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retwritePasswordController = TextEditingController();

  bool isInProgress = false;
  changeIsInProgress(bool v) {
    isInProgress = v;
    notifyListeners();
  }

  clear() {
    loginController.clear();
    passwordController.clear();
    notifyListeners();
  }
}
