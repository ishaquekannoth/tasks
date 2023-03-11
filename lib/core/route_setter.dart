import 'package:task/data/models/products/product_model.dart';

class RouteSetter {
  static bool? _navigateToPdp;
  static ProductsModel? _productsModel;
  bool get navigateToPdp => _navigateToPdp ?? false;
  set navigateToPdp(bool value) => _navigateToPdp = value;
  ProductsModel? get getProduct => _productsModel;
  set setProduct(ProductsModel value) => _productsModel = value;
}
