import 'package:dio/dio.dart';
import 'package:task/app/utils/custom_strings.dart';
import 'package:task/data/models/products/product_model.dart';
import 'package:task/domain/repositories/home_repo/home_repository.dart';
import 'package:task/network/dio_services.dart';

class CategoryRepository {
  static Future<List<String>> fetchAllCategoryHeads() async {
    Response response =
        await DioService.getMethod(url: CustomStrings.allCategoriesUrl);
    if (response.statusCode == 200) {
      return List<String>.from(response.data);
    }
    return [];
  }

  static Future<List<ProductsModel>> fetchAllProductsCategoryWise(
      CategoryType categoryType) async {
    Response response;
    switch (categoryType) {
      case CategoryType.jewelery:
        response = await DioService.getMethod(url: CustomStrings.jeweleryUrl);
        break;
      case CategoryType.electronics:
        response =
            await DioService.getMethod(url: CustomStrings.electronicsUrl);
        break;
      case CategoryType.mensClothing:
        response =
            await DioService.getMethod(url: CustomStrings.mensClothingUrl);
        break;
      case CategoryType.womensClothing:
        response =
            await DioService.getMethod(url: CustomStrings.womensClothingUrl);
    }
    if (response.statusCode == 200) {
      return productsModelFromJson(response.data);
    } else {
      return [];
    }
  }
}
