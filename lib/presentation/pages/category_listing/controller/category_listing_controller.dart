import 'dart:developer';

import 'package:get/get.dart';
import 'package:task/data/models/products/product_model.dart';
import 'package:task/domain/entities/push_notification/notifications.dart';
import 'package:task/domain/repositories/category_repo/category_repo.dart';
import 'package:task/domain/repositories/home_repo/home_repository.dart';

class CategoryListingController extends GetxController {
  @override
  void onInit() {
    log("OnInnit called");
    PushNotificationService().sendTransactionalPushNotification();
    super.onInit();
  }

  RxBool isListingLoading = true.obs;
  RxList<ProductsModel> selectedCategoryItemsList = <ProductsModel>[].obs;
  fetchProductCategoryWise(CategoryType category) async {
    selectedCategoryItemsList.clear();
    try {
      isListingLoading.value = true;
      selectedCategoryItemsList.value =
          await CategoryRepository.fetchAllProductsCategoryWise(category);
    } finally {
      isListingLoading.value = false;
    }
  }
}
