import 'package:dio/dio.dart';
import 'package:governess/consts/print_my.dart';
import 'package:governess/models/other/post_res_model.dart';
import 'package:governess/models/supplier/product_with_available_company_names_model.dart';
import 'package:governess/models/supplier/send_product_model.dart';
import 'package:governess/models/supplier/product_model.dart';
import 'package:governess/services/auth_service.dart';

class SupplierService {
  
  Future<ProductWithAvailableCompnayNames> getToBuyProducts() async {
    List<Product> data;
    try {
      Response res = await Dio().get(
        "${AuthService.localhost}/out/api/supplier/getRequiredProduct",
        options: AuthService.option,
      );
      p(res.data);
      List<String> container = [];
      data = (res.data as List).map((e) => Product.fromJson(e)).toList();

      for (var item in data) {
        if (!container.contains(item.companyName)) {
          container.add(item.companyName!);
        }
      }

      return ProductWithAvailableCompnayNames(
          availables: container, product: data);
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
          "comment": v.comment,
          "companyId": v.companyId,
          "measurementType": v.measurementType,
          "numberPack": v.numberPack,
          "orderNumber": v.orderNumber,
          "pack": v.pack,
          "price": v.price,
          "productId": v.productId,
          "weightPack": v.weightPack,
          "typeOfPayment": v.typeOfPayment,
          "paymentStatus": v.paymentStatus,
        },
        options: AuthService.option,
      );
      return ResModel.fromJson(res.data);
    } on DioError catch (e) {
      return ResModel.fromJson(e.response!.data);
    }
  }

  Future<List<Product>> getShippedProduct() async {
    try {
      Response res = await Dio().get(
        "${AuthService.localhost}/out/api/supplier/getShippedProduct",
        options: AuthService.option,
      );

      return (res.data as List).map((e) => Product.fromJson(e)).toList();
    } catch (e) {
      throw Exception("SupplierService / getShippedProduct: " + e.toString());
    }
  }
}
