import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/providers/nurse/enter_daily_children_page_provider.dart';
import 'package:provider/provider.dart';

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
                      height: gH(350),
                      width: gW(220.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(
                            context
                                .watch<NurseEnterChildrenNumberPageProvider>()
                                .file!,
                          ),
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
                    );
  }
}