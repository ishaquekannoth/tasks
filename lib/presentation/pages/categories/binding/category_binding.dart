import 'package:get/get.dart';
import 'package:task/presentation/pages/categories/controller/category_controller.dart';
import 'package:task/presentation/pages/home_screen/controller/home_controller.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
    Get.put<CategoryController>(CategoryController());
  }
}
