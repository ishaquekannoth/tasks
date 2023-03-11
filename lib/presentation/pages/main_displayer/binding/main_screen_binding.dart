import 'package:get/get.dart';
import 'package:task/presentation/pages/categories/controller/category_controller.dart';
import 'package:task/presentation/pages/home_screen/controller/home_controller.dart';
import 'package:task/presentation/pages/main_displayer/controller/main_displayer_controller.dart';
import 'package:task/presentation/pages/profile/controller/profile_controller.dart';

class MainDisplayerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<MainDisplayerController>(MainDisplayerController());
    Get.lazyPut<HomeController>(() => (HomeController()));
    Get.lazyPut<CategoryController>(() => (CategoryController()));
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
