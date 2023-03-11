import 'package:get/get.dart';
import 'package:task/presentation/pages/category_listing/controller/category_listing_controller.dart';

class CategoryListingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryListingController());
  }
}
