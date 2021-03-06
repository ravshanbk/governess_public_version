import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/consts/strings.dart';
import 'package:governess/models/nurse_models/number_of_children_model.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/providers/nurse/editing_children_page_provider.dart';
import 'package:governess/providers/nurse/number_of_children_provider.dart';
import 'package:governess/providers/nurse/enter_daily_children_page_provider.dart';
import 'package:governess/services/network.dart';
import 'package:governess/ui/nurse/nurse_home_page.dart';
import 'package:governess/ui/nurse/sub_pages/camera_page.dart';
import 'package:governess/ui/nurse/sub_pages/edit_daily_childred_page.dart';
import 'package:governess/ui/nurse/sub_pages/enter_daily_children_page.dart';
import 'package:governess/ui/nurse/sub_pages/global_photo_widget.dart';
import 'package:governess/ui/nurse/sub_pages/media/hero_page.dart';
import 'package:governess/ui/nurse/sub_pages/photo_widget_local.dart';
import 'package:governess/ui/widgets/date_time_show_button_widget.dart';
import 'package:governess/ui/widgets/indicator_widget.dart';
import 'package:governess/services/nurse_service.dart';
import 'package:governess/ui/widgets/number_of_children_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NurseShowNumberOfChildrenPage extends StatefulWidget {
  NurseShowNumberOfChildrenPage({Key? key}) : super(key: key);

  @override
  State<NurseShowNumberOfChildrenPage> createState() =>
      _NurseShowNumberOfChildrenPageState();
}

class _NurseShowNumberOfChildrenPageState
    extends State<NurseShowNumberOfChildrenPage> {
  dynamic _pickImageError;
  bool hasData = false;
  final ImagePicker _picker = ImagePicker();

  void _setImageFileListFromFile(XFile? value) {
    Provider.of<NurseEnterChildrenNumberPageProvider>(context, listen: false)
        .intitFile(File(value!.path));
  }

  Future<void> _onImageButtonPressed({BuildContext? context}) async {
    await _displayPickImageDialog(context!, (ImageSource source) async {
      try {
        final XFile? pickedFile = await _picker.pickImage(
          source: source,
        );
        setState(() {
          _setImageFileListFromFile(pickedFile);
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const NurseHomePage(),
            ),
            (route) => false);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: mainColor,
          actions: [
            _dateTimeShowButton(context),
          ],
        ),
        body: FutureBuilder<NumberOfChildren>(
          future: NurseService().getDailyChildrenNumber(
              Provider.of<NurseEnterChildrenNumberPageProvider>(context,
                      listen: false)
                  .when),
          builder: (context, AsyncSnapshot<NumberOfChildren> snap) {
            if (snap.connectionState == ConnectionState.done && snap.hasData) {
              hasData = true;
              return _body(snap.data!, context);
            } else if (snap.connectionState == ConnectionState.done &&
                !snap.hasData) {
              hasData = false;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.refresh,
                      )),
                  Text(
                    "Bu Kunga Hali Bolalar Soni Kiritilmagan!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: mainColor,
                      fontSize: gW(20.0),
                    ),
                  ),
                ],
              );
            } else {
              return IndicatorWidget(snap);
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: mainColor,
          onPressed: () {
            _onImageButtonPressed(context: context);
          },
          child: Icon(
            Icons.camera_alt_outlined,
            size: gW(30.0),
          ),
        ),
      ),
    );
  }

  _body(NumberOfChildren data, BuildContext context) {
    bool isSubmitted = data.perDayList![0].status.toString() == 'TASDIQLANDI' ||
        data.perDayList![0].id == null;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.only(
          left: gW(20.0),
          right: gW(20.0),
          top: gH(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NumberOfChildrenWidget(data: data),
            SizedBox(height: gH(20.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  child: _buttonChild("O'zgartirish"),
                  style: _buttonStyle(),
                  onPressed: isSubmitted ||
                          Provider.of<NurseEnterChildrenNumberPageProvider>(
                                      context,
                                      listen: false)
                                  .file ==
                              null
                      ? null
                      : () async {
                          bool isEnabledInternet = await checkConnectivity();

                          await Future.delayed(
                              const Duration(microseconds: 200), () {
                            return List.generate(
                                data.perDayList![0].numberOfChildrenDtoList!
                                    .length,
                                (index) => data
                                            .perDayList![0]
                                            .numberOfChildrenDtoList![index]
                                            .number
                                            .toString() ==
                                        "null"
                                    ? ""
                                    : data.perDayList![0]
                                        .numberOfChildrenDtoList![index].number
                                        .toString());
                          }).then(
                            (value) => Provider.of<
                                        NurseChangeChildrenNumberPageProvider>(
                                    context,
                                    listen: false)
                                .initControllersAndNodes(value),
                          );
                          if (isEnabledInternet &&
                              Provider.of<NurseEnterChildrenNumberPageProvider>(
                                          context,
                                          listen: false)
                                      .file !=
                                  null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NurseEditDailyChildrenPage(
                                  data,
                                ),
                              ),
                            ).then((value) {
                              setState(() {});
                            });
                          } else {
                            showToast(
                              "Qurilma Internet Tarmog'iga Ulanmagan",
                              false,
                              true,
                            );
                          }
                        },
                ),
              ],
            ),
            SizedBox(height: gH(10.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  child: _buttonChild("Kiritish"),
                  style: _buttonStyle(),
                  onPressed: !isSubmitted ||
                          context
                                  .watch<NurseEnterChildrenNumberPageProvider>()
                                  .file ==
                              null
                      ? null
                      : () async {
                          bool isEnabledInternet = await checkConnectivity();
                          if (isEnabledInternet) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NurseEnterDailyChildrenPage(
                                  kGId: data.perDayList![0].kindergartenId!,
                                ),
                              ),
                            ).then((value) {
                              setState(() {});
                            });
                          } else {
                            showNoNetToast(false);
                          }
                        },
                ),
              ],
            ),
            SizedBox(
              height: gH(20.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      if (Provider.of<NurseEnterChildrenNumberPageProvider>(
                                  context,
                                  listen: false)
                              .file !=
                          null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HeroPage(
                              image: Image.file(
                                context
                                    .watch<
                                        NurseEnterChildrenNumberPageProvider>()
                                    .file!,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    child: _imageBoxLocal(context)),
                TextButton(
                  onPressed: () {
                    if (Provider.of<NurseNumberOfChildrenProvider>(context,
                                listen: false)
                            .bytes !=
                        null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HeroPage(
                            image: Image.memory(
                              base64.decode(
                                  Provider.of<NurseNumberOfChildrenProvider>(
                                          context,
                                          listen: false)
                                      .bytes!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: data.perDayList[0].attachmentId != null
                      ? GlobalPhotoWidget(data.perDayList[0].attachmentId)
                      : const Text(" "),
                ),
              ],
            ),
            Container(
              width: gW(250.0),
              margin: EdgeInsets.only(top: gH(30.0)),
              height: gH(50.0),
              child:
                  context.watch<NurseEnterChildrenNumberPageProvider>().file ==
                          null
                      ? const Text(
                          "Bolalar sonini o'zgartirish yoki kiritish uchun rasm kiriting ????????",
                          style: TextStyle(color: Colors.red),
                        )
                      : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _imageBoxLocal(BuildContext context) {
    return SizedBox(
      height: gH(250),
      width: gW(150.0),
      child: context.watch<NurseEnterChildrenNumberPageProvider>().file == null
          ? Ink(
              height: gH(250),
              width: gW(150.0),
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage("assets/images/placeholder.jpeg"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(gW(5.0)),
                border: Border.all(
                  color: mainColor,
                  width: gW(
                    2.0,
                  ),
                ),
              ),
              child: const Text(
                "Rasm mavjud emas",
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
            )
          : const PhotoWidget(),
    );
  }

  Text _buttonChild(String title) {
    return Text(
      title,
      style: TextStyle(
        letterSpacing: gW(2.0),
        fontSize: gW(20.0),
      ),
    );
  }

  _buttonStyle() {
    return ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          gW(10.0),
        ),
      ),
      primary: mainColor,
      elevation: 0,
      fixedSize: Size(
        gW(180.0),
        gH(52.0),
      ),
    );
  }

  DateTimeShowButton _dateTimeShowButton(BuildContext context) {
    return DateTimeShowButton(
      DTFM.maker(Provider.of<NurseEnterChildrenNumberPageProvider>(context,
              listen: false)
          .when
          .millisecondsSinceEpoch),
      () {
        showDataPicker(
          context,
        );
      },
    );
  }

  showDataPicker(
    BuildContext context,
  ) {
    DatePicker.showPicker(
      context,
      showTitleActions: true,
      theme: DatePickerTheme(
        backgroundColor: lightGreyColor,
        containerHeight: gH(380.0),
        headerColor: mainColor,
        itemStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        doneStyle: TextStyle(
          color: whiteColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: gW(1.5),
          decoration: TextDecoration.underline,
        ),
      ),
      onConfirm: (date) {
        Provider.of<NurseEnterChildrenNumberPageProvider>(context,
                listen: false)
            .changeWhen(date);
        Provider.of<NurseEnterChildrenNumberPageProvider>(context,
                listen: false)
            .clearFile();

        Provider.of<NurseNumberOfChildrenProvider>(context, listen: false)
            .clearBytes();
        setState(() {});
      },
      locale: LocaleType.uz,
    );
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Add optional parameters'),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.grey,
                      size: 30,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Kamera',
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Color.fromRGBO(66, 66, 66, 1),
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CameraPage(),
                      ),
                      (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(250.0, 62),
                  primary: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.image_outlined,
                      color: Colors.grey,
                      size: 30,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Galereya',
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Color.fromRGBO(66, 66, 66, 1),
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  onPick(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(250.0, 62),
                  primary: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('BEKOR QILISH'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

typedef OnPickImageCallback = void Function(ImageSource source);
