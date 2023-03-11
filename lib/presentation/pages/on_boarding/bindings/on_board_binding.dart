import 'package:get/get.dart';
import 'package:task/presentation/pages/on_boarding/controller/onboarding_controller.dart';

class OnBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OnBoardingController>(OnBoardingController());
  }
}
