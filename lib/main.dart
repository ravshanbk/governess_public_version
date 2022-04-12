import 'package:flutter/material.dart';
import 'package:governess/models/hive_models/user_h_model.dart';
import 'package:governess/providers/apply_application_page_provider.dart';
import 'package:governess/providers/auth_page_provider.dart';
import 'package:governess/providers/daily_menu_page_provider.dart';
import 'package:governess/providers/editing_children_page_provider.dart';
import 'package:governess/providers/filter_to_buy_page_provider.dart';
import 'package:governess/providers/get_shipped_products_provider.dart';
import 'package:governess/providers/show_in_out_list_product_provider.dart';
import 'package:governess/providers/to_buy_products_page_provider.dart.dart';
import 'package:governess/ui/apply_application_page.dart';
import 'package:governess/ui/auth_page.dart';
import 'package:governess/ui/show/show_products_in_storage_page.dart';
import 'package:governess/ui/supplier/get_shipped_product_page.dart';
import 'package:governess/ui/supplier/to_buy_products_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
   await Hive.initFlutter();
  Hive.registerAdapter(UserHAdapter());
  await Hive.openBox<UserH>("user");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthPageProvider(),
        ),
         ChangeNotifierProvider(
          create: (context) => DailyMenuPageProvider(),
        ),
         ChangeNotifierProvider(
          create: (context) => EditingChildrenNumberPageProvider(),
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
          create: (context) => ApplyApplicationPageProvider(),
        ),
         ChangeNotifierProvider(
          create: (context) => ShowInOutListProductProvider(),
        ),
        
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
    const   ShowProductsInStoragePage()
    //  const  AuthPage()
      // ToBuyProductsPage(),
    //  ApplyAplicationPage()
// const GetShippedProductPage(),

      
    );
  }
}
