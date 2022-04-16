import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/providers/auth/apply_application_page_provider.dart';
import 'package:governess/services/auth_service.dart';
import 'package:provider/provider.dart';

class ApplyAplicationPage extends StatefulWidget {
  const ApplyAplicationPage({Key? key}) : super(key: key);

  @override
  State<ApplyAplicationPage> createState() => _ApplyAplicationPageState();
}

class _ApplyAplicationPageState extends State<ApplyAplicationPage> {
  int which = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<List<StringedController>> data = [
      Provider.of<ApplyApplicationPageProvider>(context, listen: false)
          .leaderInfoControllers,
      Provider.of<ApplyApplicationPageProvider>(context, listen: false)
          .companyInfoControllers
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Governess"),
        actions: [
          Padding(
            padding:
                EdgeInsets.only(top: gH(8), right: gW(15.0), bottom: gH(8)),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(gW(100.0), gH(50.0)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(gW(15.0)),
                      side: const BorderSide(color: Colors.black)),
                  primary: Colors.white,
                ),
                onPressed: () async {
                  if (Provider.of<ApplyApplicationPageProvider>(context,
                              listen: false)
                          .formKey
                          .currentState!
                          .validate() &&
                      which == 0) {
                    which = 1;
                    setState(() {});
                  } else if (Provider.of<ApplyApplicationPageProvider>(context,
                              listen: false)
                          .formKey
                          .currentState!
                          .validate() &&
                      which == 1) {
                    await AuthService().signUpUser(true).then((value) {
                      if (value.success!) {
                        _showToast(value.text!, value.success!);
                        Navigator.pushAndRemoveUntil(
                            context, MaterialPageRoute(builder: (context)=>const EntryPage()), (route) => false);
                      }
                    },);
                  }
                },
                child: Text(
                  "Submit",
                  style:
                      TextStyle(color: mainColor, fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),
      body: _body(context, data[which]),
    );
  }

  Form _body(BuildContext context, List<StringedController> data) {
    return Form(
      key: Provider.of<ApplyApplicationPageProvider>(context, listen: false)
          .formKey,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: gW(20.0)),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, __) {
          return TextFormField(
            keyboardType: data[__].keyboardType,
            validator: (v) {
              if (v!.isEmpty) {
                return data[__].key + " kiritilishi lozim";
              }
            },
            controller: data[__].controller,
            decoration: InputDecoration(
                label: Text(
              data[__].key,
              style: TextStyle(
                color: mainColor,
              ),
            )),
          );
        },
        itemCount:
            Provider.of<ApplyApplicationPageProvider>(context, listen: false)
                .leaderInfoControllers
                .length,
      ),
    );
  }

  _showToast(String text, bool success) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: success ? Colors.green : Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}class EntryPage extends StatelessWidget {
  const EntryPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Entry Page"),),);
  }
}
