import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task/presentation/pages/categories/category_view.dart';
import 'package:task/presentation/pages/home_screen/home_view.dart';
import 'package:task/presentation/pages/profile/profile_view.dart';

class MainDisplayerController extends GetxController {
  RxInt selectedIndex = 0.obs;
  List<Widget> pages = [const HomeView(), const CategoryView(), ProfileView()];

  Widget get currentWidget => pages[selectedIndex.value];
  setIndex(index) {
    if (index != selectedIndex.value) {
      selectedIndex.value = index;
    } else {
      return;
    }
  }
}
