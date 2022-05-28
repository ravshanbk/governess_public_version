// import 'package:flutter/material.dart';
// import 'package:governess/consts/size_config.dart';
// import 'package:governess/models/tajriba_model.dart';
// import 'package:governess/services/supplier_service.dart';
// import 'package:governess/ui/widgets/future_builder_of_no_data_widget.dart';
// import 'package:governess/ui/widgets/indicator_widget.dart';

// class TajribaPage extends StatefulWidget {
//   const TajribaPage({Key? key}) : super(key: key);

//   @override
//   State<TajribaPage> createState() => _TajribaPageState();
// }

// class _TajribaPageState extends State<TajribaPage> {
//   @override
//   Widget build(BuildContext context) {
//     Tajriba a = Tajriba.fromJson({
//       "id": "68ad3f27-b496-4cf5-9992-5b2791bc5aa0",
//       "supplierName": "Ta`minotchi",
//       "productName": "Asal",
//       "productId": 28,
//       "companyId": 1,
//       "companyName": "Governess Business",
//       "orderId": 5,
//       "orderNumber": "17-05-2022",
//       "weight": 5.500000,
//       "successWeight": 0,
//       "numberPack": 5.500000,
//       "successNumberPack": 0,
//       "requestDate": 1653647485545,
//       "status": "YANGI",
//       "pack": 0.000000,
//       "measurementType": "kg"
//     });
//     debugPrint(a.successWeight.toString() + " successWeight");
//     debugPrint(a.companyId.toString() + " companyId");
//     debugPrint(a.companyName.toString() + " companyName");

//     debugPrint(a.id.toString() + " id");
//     debugPrint(a.measurementType.toString() + " measurementType");
//     debugPrint(a.numberPack.toString() + " numberPack");

//     debugPrint(a.orderId.toString() + " orderId");
//     debugPrint(a.orderNumber.toString() + " orderNumber");
//     debugPrint(a.pack.toString() + " pack");

//     debugPrint(a.productId.toString() + " productId");
//     debugPrint(a.productName.toString() + " productName");
//     debugPrint(a.requestDate.toString() + " requestDate");

//     debugPrint(a.status.toString() + " status");
//     debugPrint(a.successNumberPack.toString() + " successNumberPack");
//     debugPrint(a.supplierName.toString() + " supplierName");

//     debugPrint(a.weight.toString() + " weight");

//     SizeConfig().init(context);
//     return Scaffold(
//       appBar: AppBar(title: Text("fasdfasdfasdfasd")),
//       body: FutureBuilder<List<Tajriba>>(
//         future: SupplierService().getToBuyProductsT(),
//         builder: (context, AsyncSnapshot<List<Tajriba>> snap) {
//           if (snap.connectionState == ConnectionState.done) {
//             if (snap.hasData) {
//               List<Tajriba> d = snap.data!;
//               return Column(
//                 children: [],
//               );
//             } else {
//               return const NoDataWidgetForFutureBuilder(
//                   "Hozircha Harid Qilinadigan Mahsulotlar Mavjud Emas");
//             }
//           } else {
//             return IndicatorWidget(snap);
//           }
//         },
//       ),
//     );
//   }
// }
