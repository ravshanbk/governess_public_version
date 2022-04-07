import 'package:flutter/cupertino.dart';

class AuthPageProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController loginController = TextEditingController(text: "hamshira");
  TextEditingController passwordController = TextEditingController(text: "123456789");
  
  
}
