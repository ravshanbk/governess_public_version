import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';

class CookerWastedProductsPage extends StatelessWidget {
  const CookerWastedProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        title: const Text("Chiqindilar"),
      ),
      body: const Center(
        child: Text("Chiqindilar Page"),
      ),
    );
  }
}
