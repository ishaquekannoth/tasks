import 'dart:developer';

import 'package:get/get.dart';
import 'package:task/core/route_setter.dart';
import 'package:task/core/routes.dart';
import 'package:task/data/models/products/product_model.dart';
import 'package:task/domain/entities/push_notification/notifications.dart';
import 'package:task/domain/repositories/home_repo/home_repository.dart';

class HomeController extends GetxController {
  RxList<ProductsModel> productsList = <ProductsModel>[].obs;
  RxBool isLoading = true.obs;
  RxInt dotsIndex = 0.obs;

  @override
  void onInit() async {
    fetchAllitems();
    super.onInit();
    dotsChanger(0);
    PushNotificationService.requestPermission();
  }

  void fetchAllitems() async {
    try {
      isLoading.value = true;
      productsList.value = await HomeRepository.fetchAllProducts();
      productsList.shuffle();
    } finally {
      isLoading.value = false;
      pdpOnNotificationClick();
    }
  }

  dotsChanger(int index) async {
    dotsIndex.value = index;
  }

  pdpOnNotificationClick() async {
    log(RouteSetter().navigateToPdp.toString());
    if (RouteSetter().navigateToPdp && RouteSetter().getProduct != null) {
      await Get.toNamed(Routes.productDetails,
          arguments: RouteSetter().getProduct);
      RouteSetter().navigateToPdp = false;
    }
  }
}
