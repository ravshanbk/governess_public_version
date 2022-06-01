import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/local_storage/boxes.dart';
import 'package:governess/models/nurse_models/photo_model.dart';
import 'package:governess/providers/nurse/number_of_children_provider.dart';
import 'package:provider/provider.dart';

class GlobalPhotoWidget extends StatefulWidget {
  final int id;
  const GlobalPhotoWidget(this.id, {Key? key}) : super(key: key);

  @override
  State<GlobalPhotoWidget> createState() => _GlobalPhotoWidgetState();
}

class _GlobalPhotoWidgetState extends State<GlobalPhotoWidget> {
  Future<PhotoNumerOfChildren> getPhotoOfNumberOfChildren(int? id) async {
    try {
      if(id == null ){
         return PhotoNumerOfChildren(bytes: null, id: null);
      }else{
         Response res = await Dio().get(
            "http://185.217.131.117:7788/out/api/meal/getAttachment/$id",
            options: Options(headers: {
              "Authorization": Boxes.getUser().values.first.token
            }));
        PhotoNumerOfChildren a = PhotoNumerOfChildren.fromJson(res.data);
        initProvider(context: context, bytes: a.bytes!);

        return a;
      }
     
    } catch (e) {
      return PhotoNumerOfChildren(bytes: null, id: null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PhotoNumerOfChildren>(
      future: getPhotoOfNumberOfChildren(widget.id),
      builder: (context, AsyncSnapshot<PhotoNumerOfChildren> snap) {
        String text;
        switch (snap.connectionState) {
          case ConnectionState.none:

          case ConnectionState.waiting:

          case ConnectionState.active:
            text = "Kuting...";
            break;
          case ConnectionState.done:
            if (snap.hasData) {}
            text = "Bajarildi...";
            break;
        }
        if (snap.connectionState == ConnectionState.done) {
          return _body(snap, context);
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(text),
                CupertinoActivityIndicator(
                  radius: gW(50.0),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Container _body(
      AsyncSnapshot<PhotoNumerOfChildren> snap, BuildContext context) {
    return Container(
      height: gH(250.0),
      width: gW(150.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: mainColor,
          width: gW(
            2.0,
          ),
        ),
        borderRadius: BorderRadius.circular(gW(5.0)),
        image: const DecorationImage(
            image: AssetImage(
              "assets/images/placeholder.jpeg",
            ),
            fit: BoxFit.cover),
      ),
      child: snap.data!.bytes == null
          ? const Text(
              "Rasm mavjud emas",
              textAlign: TextAlign.center,
            )
          : Image.memory(
              base64.decode(snap.data!.bytes!),
              fit: BoxFit.cover,
            ),
    );
  }

  initProvider({required BuildContext context, required String bytes}) {
    Provider.of<NurseNumberOfChildrenProvider>(context, listen: false)
        .initBytes(bytes);
  }
}
