import 'dart:async';
// flutter build apk --build-name=1.14 --build-number=14
import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/local_storage/boxes.dart';
import 'package:governess/models/hive_models/user_h_model.dart';
import 'package:governess/models/hive_models/pin_hive_model.dart';
import 'package:governess/providers/auth/pin_code_page_provider.dart';
import 'package:governess/providers/cooker/accept_product_provider.dart';
import 'package:governess/providers/cooker/cooker_products_page_provider.dart';
import 'package:governess/providers/nurse/daily_menu_page_provider.dart';
import 'package:governess/providers/nurse/editing_children_page_provider.dart';
import 'package:governess/providers/nurse/enter_daily_children_page_provider.dart';
import 'package:governess/providers/supplier/filter_to_buy_page_provider.dart';
import 'package:governess/providers/supplier/get_shipped_products_provider.dart';
import 'package:governess/providers/cooker/show_in_out_list_product_provider.dart';
import 'package:governess/providers/supplier/to_buy_products_page_provider.dart.dart';
import 'package:governess/providers/cooker/waste_product_cooker_page_provider.dart';
import 'package:governess/ui/auth/auth_page.dart';
import 'package:governess/ui/auth/check_pincode_page.dart';
import 'package:governess/ui/widgets/governess_app_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final bool hasNet = await InternetConnectionChecker().hasConnection;

  Hive.registerAdapter(UserHAdapter());
  await Hive.openBox<UserH>("user");
  Hive.registerAdapter(PinHiveAdapter());
  await Hive.openBox<PinHive>("pinUser");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DailyMenuPageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NurseChangeChildrenNumberPageProvider(),
        ),
          ChangeNotifierProvider(
          create: (context) => NurseEnterChildrenNumberPageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ToBuyProductPageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetShippedProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ToBuyProductPageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FilterToBuyPageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ShowInOutListProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CookerProductsPageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WasteProductCookerPageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CookerAcceptProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PinCodePageProvider(),
        ),
      ],
      child: MyApp(hasNet),
    ),
  );
}
@immutable
// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  bool hasInternet;
  MyApp(this.hasInternet, {Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<InternetConnectionStatus> listener;

  @override
  Widget build(BuildContext context) {
    listener = InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            // ignore: avoid_print
            print('Data connection is available.');
            widget.hasInternet = true;
            setState(() {});
            break;
          case InternetConnectionStatus.disconnected:
            // ignore: avoid_print
            print('You are disconnected from the internet.');
            widget.hasInternet = false;
            setState(() {});
            break;
        }
      },
    );

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: widget.hasInternet ? _body() : const NoInternetConnectionPage());
  }

  _body() {
    return Boxes.getUser().values.isEmpty || Boxes.getPinUser().values.isEmpty
        ? AuthPage()
        : CheckingPinCodePage();
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }
}

class NoInternetConnectionPage extends StatelessWidget {
  const NoInternetConnectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: governessAppBar,
      body: Center(
        child: Column(
          children: [
            const Image(image: AssetImage("assets/images/peas-nointernet.gif")),
            Divider(
              indent: gW(50.0),
              endIndent: gW(50.0),
              color: mainColor,
              thickness: gW(1.5),
            ),
            Divider(
              indent: gW(100.0),
              endIndent: gW(100.0),
              color: mainColor,
              thickness: gW(1.5),
            ),
            Divider(
              indent: gW(150.0),
              endIndent: gW(150.0),
              color: mainColor,
              thickness: gW(1.5),
            ),
            Text(
              "Qurilma Internet Tarmog'iga Ulanmagan !!!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: gW(20.0),
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
