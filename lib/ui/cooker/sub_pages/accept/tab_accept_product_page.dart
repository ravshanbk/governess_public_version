import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/providers/cooker/accept_product_provider.dart';
import 'package:governess/ui/cooker/sub_pages/accept/arxiv.dart';
import 'package:governess/ui/cooker/sub_pages/accept/default.dart';
import 'package:provider/provider.dart';

class CookerAcceptProductPageTab extends StatefulWidget {
  const CookerAcceptProductPageTab({Key? key}) : super(key: key);

  @override
  _CookerAcceptProductPageTabState createState() =>
      _CookerAcceptProductPageTabState();
}

class _CookerAcceptProductPageTabState extends State<CookerAcceptProductPageTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Provider.of<CookerAcceptProductProvider>(context, listen: false)
            .changeCurrent(-1);
        Navigator.pop(context);
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  height: gH(45.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(
                      gH(25.0),
                    ),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        gH(25.0),
                      ),
                      color: Colors.green,
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: const [
                      Tab(
                        text: 'Qabul qilish',
                      ),
                      Tab(
                        text: 'Arxiv',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      CookerAcceptProductDefaultPage(),
                      CookerAcceptProductArxivPage(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
