import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  RxInt currentIndex = 0.obs;
  Rx<PageController> controller = PageController().obs;

  indexSetter(int newIndex) {
    currentIndex.value = newIndex;
  }
}
