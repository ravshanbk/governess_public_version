import 'package:flutter/material.dart';
import 'package:governess/models/hive_models/user_h_model.dart';
import 'package:governess/providers/auth/apply_application_page_provider.dart';
import 'package:governess/providers/auth/auth_page_provider.dart';
import 'package:governess/providers/cooker/accept_product_provider.dart';
import 'package:governess/providers/cooker/cooker_products_page_provider.dart';
import 'package:governess/providers/nurse/daily_menu_page_provider.dart';
import 'package:governess/providers/nurse/editing_children_page_provider.dart';
import 'package:governess/providers/supplier/filter_to_buy_page_provider.dart';
import 'package:governess/providers/supplier/get_shipped_products_provider.dart';
import 'package:governess/providers/cooker/show_in_out_list_product_provider.dart';
import 'package:governess/providers/supplier/to_buy_products_page_provider.dart.dart';
import 'package:governess/providers/cooker/waste_product_cooker_page_provider.dart';
import 'package:governess/ui/apply_application_page.dart';
import 'package:governess/ui/auth_page.dart';
import 'package:governess/ui/cooker/home_cooker_page.dart';
import 'package:governess/ui/cooker/sub_pages/show_products_in_storage_page.dart';
import 'package:governess/ui/manager/home_manager_page.dart';
import 'package:governess/ui/supplier/get_shipped_product_page.dart';
import 'package:governess/ui/supplier/to_buy_products_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
// 192.168.68.124  ofisdagi birinchi berilgani
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
         ChangeNotifierProvider(
          create: (context) => CookerProductsPageProvider(),
        ),
        
          ChangeNotifierProvider(
          create: (context) => WasteProductCookerPageProvider(),
        ),
           ChangeNotifierProvider(
          create: (context) => CookerAcceptProductProvider(),
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
    const  

    // ManagerHomePage()
    // HomePageCookerPage()
    //  ShowProductsInStoragePage()
      AuthPage()
      // ToBuyProductsPage(),
    //  ApplyAplicationPage()
// const GetShippedProductPage(),

      
    );
  }
}

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {

//  late FocusNode fname;
//   late FocusNode lname;
//  late FocusNode age;
//   late FocusNode email;
//   late FocusNode submit;


//  @override
//   void initState() {

//     super.initState();
//     fname = FocusNode();
//     lname = FocusNode();
//     age = FocusNode();
//     email = FocusNode();
//     submit = FocusNode();
//   }

//   @override
//   void dispose() {
//     fname.dispose();
//     lname.dispose();
//     age.dispose();
//     email.dispose();
//     submit.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Focus Node',
//       home: Scaffold(
//        appBar: AppBar(
//        title: Text('Focus Bro!'),
//        centerTitle: true, 
//        ),
//        body:Padding(
//          padding: const EdgeInsets.all(16.0),
//          child: SingleChildScrollView(
//                     child: Column(
//             children: [
//               Text('Personal',
//               style: TextStyle(
//                fontSize: 40.0,
//                fontWeight: FontWeight.w800,
//                color: Colors.indigoAccent, 
//               ),
//               ),
//               TextFormField(
//                 autofocus: true,
//                 focusNode: fname,
//                 keyboardType: TextInputType.text,
//                 enabled: true,
//                 textInputAction: TextInputAction.next,
//                 decoration: InputDecoration(
//                  labelText: 'First Name',
//                  hintText: 'Enter your first name',
//                  border: OutlineInputBorder(
//                  borderSide: BorderSide(color:Colors.teal),
//                  ),
//                 ),
//                 onFieldSubmitted: (term){
//                   fname.unfocus();
//                   FocusScope.of(context).requestFocus(lname);
//                 },
//               ),
//               SizedBox(height: 10,),
//               TextFormField(
//                 focusNode: lname,
//                 enabled: true,
//                 keyboardType: TextInputType.text,
//                 textInputAction: TextInputAction.next,
//                 decoration: InputDecoration(
//                  labelText: 'Last Name',
//                  hintText: 'Enter your last name',
//                  border: OutlineInputBorder(
//                  borderSide: BorderSide(color:Colors.teal),
//                  ),
//                 ),
//                 onFieldSubmitted: (term){
//                   lname.unfocus();
//                   FocusScope.of(context).requestFocus(email);
//                 },
//               ),
//               SizedBox(height: 10,),
//               TextFormField(
//                 focusNode: email,
//                 enabled: true,
//                 keyboardType: TextInputType.emailAddress,
//                 textInputAction: TextInputAction.next,
//                 decoration: InputDecoration(
//                  labelText: 'Email',
//                  hintText: 'Enter your email',
//                  border: OutlineInputBorder(
//                  borderSide: BorderSide(color:Colors.teal),
//                  ),
//                 ),
//                 onFieldSubmitted: (term){
//                   email.unfocus();
//                   FocusScope.of(context).requestFocus(age);
//                 },
//               ),

//               SizedBox(height: 10,),
//               TextFormField(
//                 focusNode: age,
//                 enabled: true,
//                 keyboardType: TextInputType.text,
//                 textInputAction: TextInputAction.done,
//                 decoration: InputDecoration(
//                  labelText: 'Age',
//                  hintText: 'Enter your age',
//                  border: OutlineInputBorder(
//                  borderSide: BorderSide(color:Colors.teal),
//                  ),
//                 ),
//                 onFieldSubmitted: (term){
//                   age.unfocus();
//                   FocusScope.of(context).requestFocus(submit);
//                 },
//               ),
//               SizedBox(height: 10,),
//              ElevatedButton(
//                 focusNode: submit,
//                 onPressed: (){},
//                 child: Text('Submit'),
//                 ),
//             ], 
//            ),
//          ),
//        ) 
//       ),
//     );
//   }
// }