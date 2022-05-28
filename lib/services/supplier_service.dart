import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:governess/local_storage/boxes.dart';
import 'package:governess/models/other/post_res_model.dart';
import 'package:governess/models/supplier/product_with_available_company_names_model.dart';
import 'package:governess/models/supplier/send_product_model.dart';
import 'package:governess/models/supplier/product_model.dart';
import 'package:governess/models/supplier/shipped_product_model.dart';
import 'package:governess/models/tajriba_model.dart';
import 'package:governess/services/auth_service.dart';

class SupplierService {
  Dio client = Dio();
  Future<ProductWithAvailableCompnayNames> getToBuyProducts() async {
    List<Map<String, dynamic>> hardData = [
      {
        "id": "68ad3f27-b496-4cf5-9992-5b2791bc5aa0",
        "supplierName": "Ta`minotchi",
        "productName": "Asal",
        "productId": 28,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 4.500000,
        "successWeight": 4.000000,
        "numberPack": 4.500000,
        "successNumberPack": 4.000000,
        "requestDate": 1653647485545,
        "status": "QISMAN YUBORILDI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "7c697969-05cd-4704-b6b2-f12485c3ab85",
        "supplierName": "Ta`minotchi",
        "productName": "Baliq (boshsiz, tozalangan)",
        "productId": 72,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 47.500000,
        "successWeight": 0,
        "numberPack": 47.500000,
        "successNumberPack": 0,
        "requestDate": 1653647485550,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "3a437a23-89ef-4bec-86bd-c2894260f607",
        "supplierName": "Ta`minotchi",
        "productName": "Banan",
        "productId": 73,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 40.000000,
        "successWeight": 9.000000,
        "numberPack": 40.000000,
        "successNumberPack": 9.000000,
        "requestDate": 1653647485600,
        "status": "QISMAN YUBORILDI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "4bf8b6f5-aff9-4837-9182-f43490ce43fe",
        "supplierName": "Ta`minotchi",
        "productName": "Bodring",
        "productId": 68,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 10.000000,
        "successWeight": 10.000000,
        "numberPack": 10.000000,
        "successNumberPack": 10.000000,
        "requestDate": 1653647485606,
        "status": "QISMAN YUBORILDI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "662323d0-c49b-4ddc-bbb7-f335e839a0d8",
        "supplierName": "Ta`minotchi",
        "productName": "Bulgʼor qalampiri",
        "productId": 69,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 10.000000,
        "successWeight": 10.000000,
        "numberPack": 10.000000,
        "successNumberPack": 10.000000,
        "requestDate": 1653647485601,
        "status": "QISMAN YUBORILDI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "5b26915b-197e-45b9-a9f8-42a27abcf1f2",
        "supplierName": "Ta`minotchi",
        "productName": "Choy (qora)",
        "productId": 6,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 1.000000,
        "successWeight": 0,
        "numberPack": 1.000000,
        "successNumberPack": 0,
        "requestDate": 1653647485543,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "40abb25c-884f-4c37-93a3-30366947948c",
        "supplierName": "Ta`minotchi",
        "productName": "Grechka",
        "productId": 7,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 9.000000,
        "successWeight": 0,
        "numberPack": 9.000000,
        "successNumberPack": 0,
        "requestDate": 1653647485573,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "d4471539-277d-479c-9e9d-0fd73349b4ab",
        "supplierName": "Ta`minotchi",
        "productName": "Gul karam",
        "productId": 8,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 4.000000,
        "successWeight": 0,
        "numberPack": 4.000000,
        "successNumberPack": 0,
        "requestDate": 1653647485614,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "9b9c7034-59be-4aec-8097-1f19258b3851",
        "supplierName": "Ta`minotchi",
        "productName": "Guruch",
        "productId": 67,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 32.500000,
        "successWeight": 0,
        "numberPack": 32.500000,
        "successNumberPack": 0,
        "requestDate": 1653647485593,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "a8a494d7-772a-48e8-a04b-70d3a4a58782",
        "supplierName": "Ta`minotchi",
        "productName": "Kakao-poroshok",
        "productId": 14,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 3.000000,
        "successWeight": 0,
        "numberPack": 3.000000,
        "successNumberPack": 0,
        "requestDate": 1653647485571,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "db9d01a5-0b94-4f19-a4fe-3f01ee149161",
        "supplierName": "Ta`minotchi",
        "productName": "Karam",
        "productId": 15,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 23.500000,
        "successWeight": 0,
        "numberPack": 23.500000,
        "successNumberPack": 0,
        "requestDate": 1653647485608,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "bf657904-8814-479c-9d50-8b044de64493",
        "supplierName": "Ta`minotchi",
        "productName": "Karam xitoy (basay)",
        "productId": 46,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 57.000000,
        "successWeight": 0,
        "numberPack": 57.000000,
        "successNumberPack": 0,
        "requestDate": 1653647485600,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "b86e5560-08a0-47aa-a33e-1a29688b45e5",
        "supplierName": "Ta`minotchi",
        "productName": "Kartoshka",
        "productId": 10,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 263.500000,
        "successWeight": 0,
        "numberPack": 263.500000,
        "successNumberPack": 0,
        "requestDate": 1653647485554,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "cb872e2d-952f-4328-b190-8721958ebbd5",
        "supplierName": "Ta`minotchi",
        "productName": "Kashnich doni",
        "productId": 11,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 1.000000,
        "successWeight": 0,
        "numberPack": 1.000000,
        "successNumberPack": 0,
        "requestDate": 1653647485603,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "cef455ef-48c6-4b65-a5ba-effc1b4c386f",
        "supplierName": "Ta`minotchi",
        "productName": "Koʼkat",
        "productId": 13,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 5.000000,
        "successWeight": 0,
        "numberPack": 5.000000,
        "successNumberPack": 0,
        "requestDate": 1653647485607,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "21a0412e-f55b-4b6d-b463-79ad3f035363",
        "supplierName": "Ta`minotchi",
        "productName": "Kraxmal kartoshka",
        "productId": 99,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 3.500000,
        "successWeight": 0,
        "numberPack": 3.500000,
        "successNumberPack": 0,
        "requestDate": 1653647485609,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "c8d0eb6b-222d-4d0c-bb4e-0b5f819ff63e",
        "supplierName": "Ta`minotchi",
        "productName": "Lavlagi",
        "productId": 51,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 30.500000,
        "successWeight": 0,
        "numberPack": 30.500000,
        "successNumberPack": 0,
        "requestDate": 1653647485546,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "3d2b103f-aed1-4bb7-b05a-cb114bec116e",
        "supplierName": "Ta`minotchi",
        "productName": "Limon",
        "productId": 94,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 4.000000,
        "successWeight": 0,
        "numberPack": 4.000000,
        "successNumberPack": 0,
        "requestDate": 1653647485602,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "e941b4c0-be61-4e68-91e4-7d7e939a7400",
        "supplierName": "Ta`minotchi",
        "productName": "Mandarin",
        "productId": 23,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 14.500000,
        "successWeight": 0,
        "numberPack": 14.500000,
        "successNumberPack": 0,
        "requestDate": 1653647485599,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "8d2ef107-0fbe-4e7f-be08-290d70c2741b",
        "supplierName": "Ta`minotchi",
        "productName": "Manka",
        "productId": 107,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 28.000000,
        "successWeight": 0,
        "numberPack": 28.000000,
        "successNumberPack": 0,
        "requestDate": 1653647485572,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "95e31b8e-fe9f-4a7f-b226-59e1b898fca6",
        "supplierName": "Ta`minotchi",
        "productName": "Mayiz",
        "productId": 1,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 9.500000,
        "successWeight": 0,
        "numberPack": 9.500000,
        "successNumberPack": 0,
        "requestDate": 1653647485611,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "5df97cca-d88b-4ed6-a6e9-58099a301b3d",
        "supplierName": "Ta`minotchi",
        "productName": "Mol go`shti",
        "productId": 76,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 19.000000,
        "successWeight": 100.000000,
        "numberPack": 19.000000,
        "successNumberPack": 100.000000,
        "requestDate": 1653647485542,
        "status": "QISMAN YUBORILDI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "b168c664-a175-4b80-a1b5-15113e6d000f",
        "supplierName": "Ta`minotchi",
        "productName": "Mosh",
        "productId": 102,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 2.500000,
        "successWeight": 0,
        "numberPack": 2.500000,
        "successNumberPack": 0,
        "requestDate": 1653647485622,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "302dbb6e-6665-4f8e-b3ad-dd14d2af7aca",
        "supplierName": "Ta`minotchi",
        "productName": "Murabbo (bexi)",
        "productId": 103,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 17.000000,
        "successWeight": 0.000000,
        "numberPack": 17.000000,
        "successNumberPack": 0.000000,
        "requestDate": 1653647485575,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "e7f1fbfa-d18f-49f7-8b2e-4bc0b9918b01",
        "supplierName": "Ta`minotchi",
        "productName": "Noʼxat (butun)",
        "productId": 39,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 5.000000,
        "successWeight": 0,
        "numberPack": 5.000000,
        "successNumberPack": 0,
        "requestDate": 1653647485556,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "c57f39bf-d388-40cb-9437-696c277822d5",
        "supplierName": "Ta`minotchi",
        "productName": "Noʼxat (yarimta, gorox)",
        "productId": 41,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 3.500000,
        "successWeight": 0,
        "numberPack": 3.500000,
        "successNumberPack": 0,
        "requestDate": 1653647485617,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "53e4762c-af43-4824-9061-91bb185972b6",
        "supplierName": "Ta`minotchi",
        "productName": "O`simlik moyi",
        "productId": 88,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 18.000000,
        "successWeight": 0,
        "numberPack": 18.000000,
        "successNumberPack": 0,
        "requestDate": 1653647485496,
        "status": "YANGI",
        "pack": 1.000000,
        "measurementType": "kg"
      },
      {
        "id": "59c5f846-8967-4d11-9eb5-3381a5a144ad",
        "supplierName": "Ta`minotchi",
        "productName": "Olma",
        "productId": 35,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 150.500000,
        "successWeight": 0,
        "numberPack": 150.500000,
        "successNumberPack": 0,
        "requestDate": 1653647485544,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "35d5822f-1208-4d8a-a1f6-61d9cde5cbb1",
        "supplierName": "Ta`minotchi",
        "productName": "Oq joʼxori",
        "productId": 37,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 4.000000,
        "successWeight": 0,
        "numberPack": 4.000000,
        "successNumberPack": 0,
        "requestDate": 1653647485612,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "46aa2178-36d7-43df-abbd-e45914b091ff",
        "supplierName": "Ta`minotchi",
        "productName": "Ovsyanka",
        "productId": 47,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 10.500000,
        "successWeight": 0,
        "numberPack": 10.500000,
        "successNumberPack": 0,
        "requestDate": 1653647485610,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "8d366751-bf58-483c-88ee-e1eb21765ce5",
        "supplierName": "Ta`minotchi",
        "productName": "Pishloq",
        "productId": 85,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 19.500000,
        "successWeight": 0,
        "numberPack": 19.500000,
        "successNumberPack": 0,
        "requestDate": 1653647485597,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "a1179afa-5dff-4428-b8b5-cf64f9e37841",
        "supplierName": "Ta`minotchi",
        "productName": "Piyoz",
        "productId": 20,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 48.000000,
        "successWeight": 0,
        "numberPack": 48.000000,
        "successNumberPack": 0,
        "requestDate": 1653647485537,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "6777c09c-2350-4e6e-9f7c-f0c4d50dda52",
        "supplierName": "Ta`minotchi",
        "productName": "Pomidor",
        "productId": 83,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 26.000000,
        "successWeight": 0,
        "numberPack": 26.000000,
        "successNumberPack": 0,
        "requestDate": 1653647485563,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "fe18edbd-474e-40db-93b0-a1bdedc5b7f7",
        "supplierName": "Ta`minotchi",
        "productName": "Povidlo",
        "productId": 91,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 2.500000,
        "successWeight": 0,
        "numberPack": 2.500000,
        "successNumberPack": 0,
        "requestDate": 1653647485598,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "b47fa459-f109-45fd-a0ae-75dd9abae9c0",
        "supplierName": "Ta`minotchi",
        "productName": "Psheno yormasi",
        "productId": 80,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 3.500000,
        "successWeight": 0,
        "numberPack": 3.500000,
        "successNumberPack": 0,
        "requestDate": 1653647485615,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "05f6f7da-5198-46f7-a0df-705ad6a43801",
        "supplierName": "Ta`minotchi",
        "productName": "Qizil karam",
        "productId": 50,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 3.000000,
        "successWeight": 0,
        "numberPack": 3.000000,
        "successNumberPack": 0,
        "requestDate": 1653647485613,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "cb32458d-cd43-436a-bdaa-c0912771e161",
        "supplierName": "Ta`minotchi",
        "productName": "Quruq meva",
        "productId": 33,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 7.000000,
        "successWeight": 0,
        "numberPack": 7.000000,
        "successNumberPack": 0,
        "requestDate": 1653647485548,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "4621b2fc-8192-49fe-8aed-2d6b5481ccde",
        "supplierName": "Ta`minotchi",
        "productName": "Rediska",
        "productId": 104,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 2.500000,
        "successWeight": 0,
        "numberPack": 2.500000,
        "successNumberPack": 0,
        "requestDate": 1653647485605,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "3492e5c8-80f1-47c3-8eef-b0a472e4be18",
        "supplierName": "Ta`minotchi",
        "productName": "Sabzi",
        "productId": 66,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 58.000000,
        "successWeight": 0,
        "numberPack": 58.000000,
        "successNumberPack": 0,
        "requestDate": 1653647485555,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "7c680cc3-908c-4110-9f27-5cb00d4c129c",
        "supplierName": "Ta`minotchi",
        "productName": "Sarimsoq piyoz",
        "productId": 29,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 1.500000,
        "successWeight": 0,
        "numberPack": 1.500000,
        "successNumberPack": 0,
        "requestDate": 1653647485549,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "89c84909-2846-4859-a985-251d465ea3e0",
        "supplierName": "Ta`minotchi",
        "productName": "Saryogʼ",
        "productId": 57,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 42.500000,
        "successWeight": 0,
        "numberPack": 42.500000,
        "successNumberPack": 0,
        "requestDate": 1653647485495,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "560fba5f-cc39-4376-a92b-545816e41c3d",
        "supplierName": "Ta`minotchi",
        "productName": "Saxarnaya pudra",
        "productId": 75,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 1.000000,
        "successWeight": 0,
        "numberPack": 1.000000,
        "successNumberPack": 0,
        "requestDate": 1653647485618,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "e81b5098-144f-44c8-9013-de38a70391b4",
        "supplierName": "Ta`minotchi",
        "productName": "Shakar",
        "productId": 58,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 50.500000,
        "successWeight": 0,
        "numberPack": 50.500000,
        "successNumberPack": 0,
        "requestDate": 1653647485569,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "b9bb02b5-0c00-4765-bb7c-59128d15fb18",
        "supplierName": "Ta`minotchi",
        "productName": "Shipovnik (quruq)",
        "productId": 59,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 3.000000,
        "successWeight": 0,
        "numberPack": 3.000000,
        "successNumberPack": 0,
        "requestDate": 1653647485616,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "05235e0c-1cdf-469a-8275-7efe985186c7",
        "supplierName": "Ta`minotchi",
        "productName": "Suxarik panirovochniy",
        "productId": 63,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 3.000000,
        "successWeight": 0,
        "numberPack": 3.000000,
        "successNumberPack": 0,
        "requestDate": 1653647485574,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "dea3752e-145f-4dd2-8a27-54c56022dd5e",
        "supplierName": "Ta`minotchi",
        "productName": "Tomat pastasi",
        "productId": 79,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 4.000000,
        "successWeight": 0,
        "numberPack": 4.000000,
        "successNumberPack": 0,
        "requestDate": 1653647485595,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "816aa2bd-7322-4809-9a8a-d0ec19198459",
        "supplierName": "Ta`minotchi",
        "productName": "Tovuq filesi",
        "productId": 90,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 19.500000,
        "successWeight": 0,
        "numberPack": 19.500000,
        "successNumberPack": 0,
        "requestDate": 1653647485594,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "194df144-0ed1-45cd-8b3a-3d98cceff089",
        "supplierName": "Ta`minotchi",
        "productName": "Tovuq go'shti",
        "productId": 24,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 11.000000,
        "successWeight": 0,
        "numberPack": 11.000000,
        "successNumberPack": 0,
        "requestDate": 1653647485619,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "9577326a-1944-45b0-97f5-83362cda9286",
        "supplierName": "Ta`minotchi",
        "productName": "Tuxum",
        "productId": 26,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 49.500000,
        "successWeight": 0,
        "numberPack": 825.000000,
        "successNumberPack": 0,
        "requestDate": 1653647485497,
        "status": "YANGI",
        "pack": 0.060000,
        "measurementType": "kg"
      },
      {
        "id": "a8b662a8-36c3-408e-99d3-5604204914dc",
        "supplierName": "Ta`minotchi",
        "productName": "Tuz",
        "productId": 78,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 11.000000,
        "successWeight": 0,
        "numberPack": 11.000000,
        "successNumberPack": 0,
        "requestDate": 1653647485529,
        "status": "YANGI",
        "pack": 1.000000,
        "measurementType": "kg"
      },
      {
        "id": "0a80bc9b-6637-4f42-aac6-a6ea00da1e53",
        "supplierName": "Ta`minotchi",
        "productName": "Un (1-sort)",
        "productId": 19,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 29.500000,
        "successWeight": 0,
        "numberPack": 29.500000,
        "successNumberPack": 0,
        "requestDate": 1653647485596,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "644dcc9b-e6f8-4472-8361-5af327c059d6",
        "supplierName": "Ta`minotchi",
        "productName": "Un (oliy sort)",
        "productId": 98,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 20.000000,
        "successWeight": 0,
        "numberPack": 20.000000,
        "successNumberPack": 0,
        "requestDate": 1653647485533,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "cee07216-3d6a-49e9-878e-95b43cb7f490",
        "supplierName": "Ta`minotchi",
        "productName": "Vanil",
        "productId": 21,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 0.145000,
        "successWeight": 0,
        "numberPack": 29.000000,
        "successNumberPack": 0,
        "requestDate": 1653647485575,
        "status": "YANGI",
        "pack": 0.005000,
        "measurementType": "kg"
      },
      {
        "id": "c12e9b12-3dc4-47ca-ab65-46103ec94aa6",
        "supplierName": "Ta`minotchi",
        "productName": "Xamirturush",
        "productId": 22,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 0.700000,
        "successWeight": 0,
        "numberPack": 7.000000,
        "successNumberPack": 0,
        "requestDate": 1653647485591,
        "status": "YANGI",
        "pack": 0.100000,
        "measurementType": "kg"
      },
      {
        "id": "486d6c20-c192-4674-850c-ee05852b47d4",
        "supplierName": "Ta`minotchi",
        "productName": "Yeryongʼoq",
        "productId": 25,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 3.000000,
        "successWeight": 0,
        "numberPack": 3.000000,
        "successNumberPack": 0,
        "requestDate": 1653647485547,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      },
      {
        "id": "2438b6fd-4f01-40e3-afd3-749e09b233fa",
        "supplierName": "Ta`minotchi",
        "productName": "Zira",
        "productId": 17,
        "companyId": 1,
        "companyName": "Governess Business",
        "orderId": 5,
        "orderNumber": "17-05-2022",
        "weight": 1.000000,
        "successWeight": 0,
        "numberPack": 1.000000,
        "successNumberPack": 0,
        "requestDate": 1653647485604,
        "status": "YANGI",
        "pack": 0.000000,
        "measurementType": "kg"
      }
    ];

    try {
      Response res = await Dio().get(
        // "http://192.168.68.115:7788/out/api/supplier/getRequiredProduct",
        "${AuthService.localhost}/out/api/supplier/getRequiredProduct",
        options: Options(
          headers: {
            "Authorization": Boxes.getUser().values.first.token,
          },
        ),
      );
      List<String> availables = <String>[];
      List<Product> product =
          (res.data as List).map((e) => Product.fromJson(e)).toList();
      for (int i = 0; i < product.length; i++) {
        if (!availables.contains(product[i].companyName)) {
          availables.add(product[i].companyName!);
        }
      }
      return ProductWithAvailableCompnayNames(
          availables: availables, product: product);
    } catch (e) {
      throw Exception("SupplierService / getToBuyProducts: " + e.toString());
    }
    // return ProductWithAvailableCompnayNames(
    //     availables: <String>[], product: <Product>[]);

    
  }

  Future<List<Tajriba>> getToBuyProductsT() async {
    try {
      Response res = await client.get(
        // "http://192.168.68.115:7788/out/api/supplier/getRequiredProduct",
        "${AuthService.localhost}/out/api/supplier/getRequiredProduct",
        options: Options(
          headers: {
            "Authorization": Boxes.getUser().values.first.token,
          },
        ),
      );

      return List.generate(
          12,
          (index) => Tajriba.fromJson({
                "id": "68ad3f27-b496-4cf5-9992-5b2791bc5aa0",
                "supplierName": "Ta`minotchi",
                "productName": "Asal",
                "productId": 28,
                "companyId": 1,
                "companyName": "Governess Business",
                "orderId": 5,
                "orderNumber": "17-05-2022",
                "weight": 4.5,
                "successWeight": 4.0,
                "numberPack": 4.5,
                "successNumberPack": 4.0,
                "requestDate": 1653629485545,
                "status": "QISMAN YUBORILDI",
                "pack": 0.0,
                "measurementType": "kg"
              }));
    } catch (e) {
      throw Exception("SupplierService / getToBuyProducts: " + e.toString());
    }
  }

  Future<ResModel> sendProduct(
      {required SendProduct v, required String id}) async {
    try {
      var res = await Dio().post(
        "${AuthService.localhost}/out/api/supplier/addShippedProduct/$id",
        data: {
          "price": v.price,
          "numberPack": v.numberPack,
          "weight": v.weight,
          "comment": v.comment,
          "paymentStatus": v.paymentStatus,
          "typeOfPayment": v.typeOfPayment,
        },
        options: Options(headers: {
          "Authorization": Boxes.getUser().values.first.token,
        }),
      );
      return ResModel.fromJson(res.data);
    } on DioError catch (e) {
      return ResModel(
          object: {}, success: false, text: e.response!.data.toString());
    }
  }

  Future<List<ShippedProduct>> getShippedProduct() async {
    // p("Serveice ga kirdi: ");
    try {
      Response res = await Dio().get(
        "${AuthService.localhost}/out/api/supplier/getShippedProduct",
        options: Options(headers: {
          "Authorization": Boxes.getUser().values.first.token,
        }),
      );
      // p(res.data);
      return (res.data as List).map((e) => ShippedProduct.fromJson(e)).toList();
    } catch (e) {
      throw Exception("SupplierService / getShippedProduct: " + e.toString());
    }
  }
}

class Myy {
  String? id;
  Myy({this.id});
  factory Myy.fromJson(Map<String, dynamic> n) {
    return Myy(id: n['id']);
  }
}
