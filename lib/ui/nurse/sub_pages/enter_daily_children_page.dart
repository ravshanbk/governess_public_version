import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';

class NurseEnterDailyChildrenPage extends StatelessWidget {
  const NurseEnterDailyChildrenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Yosh Toifalar"),
        backgroundColor: mainColor,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(gW(20)),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, __) {
          return _groupButton(context, __);
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: gH(20.0),
          );
        },
        itemCount: 4,
      ),
    );
  }

  ElevatedButton _groupButton(BuildContext context, int __) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            gW(10.0),
          ),
        ),
        primary: mainColor,
        elevation: 0,
        fixedSize: Size(
          gW(335.0),
          gH(60.0),
        ),
      ),
      onPressed: () {},
      child: Text("$__"),
    );
  }

  Future<dynamic> _showDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Material(
          type: MaterialType.transparency,
          child: Container(
            height: gH(300.0),
            padding: EdgeInsets.all(gW(20.0)),
            margin: EdgeInsets.only(
              top: gH(200.0),
              left: gW(20.0),
              right: gW(20.0),
              bottom: gH(300.0),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                gW(20.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _textField(context),
                SizedBox(
                  height: gH(20.0),
                ),
                _addButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  ElevatedButton _addButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            gW(20.0),
          ),
        ),
        primary: mainColor,
        elevation: 0,
        fixedSize: Size(
          gW(200.0),
          gH(62.0),
        ),
      ),
      onPressed: () async {},
      child: Text(
        "Qo'shish",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: gW(3.0),
          fontSize: gW(20.0),
        ),
      ),
    );
  }

  TextFormField _textField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: gW(18.0)),
      cursorColor: mainColor,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelStyle: TextStyle(color: mainColor),
          label: const Text("Nechta...?"),
          border: _inputBorder(),
          focusedBorder: _inputBorder(),
          enabledBorder: _inputBorder()),
    );
  }

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: mainColor),
      borderRadius: BorderRadius.circular(
        gW(10.0),
      ),
    );
  }
}
