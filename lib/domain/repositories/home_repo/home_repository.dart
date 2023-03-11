import 'package:dio/dio.dart';
import 'package:task/app/utils/custom_strings.dart';
import 'package:task/data/models/products/product_model.dart';
import 'package:task/network/dio_services.dart';

enum CategoryType { jewelery, electronics, mensClothing, womensClothing }

class HomeRepository {
  static Future<List<ProductsModel>> fetchAllProducts() async {
    try {
      Response response =
          await DioService.getMethod(url: CustomStrings.allProductsUrl);
      if (response.statusCode == 200) {
        return productsModelFromJson(response.data);
      }
    } on DioError {
      return [];
    }
    return [];
  }
}
