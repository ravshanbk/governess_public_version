import 'package:governess/models/supplier/product_model.dart';

class ProductWithAvailableCompnayNames {
  List<Product> product;
  List<String> availables;
  ProductWithAvailableCompnayNames(
      {required this.availables, required this.product});
}
