import 'package:get/get.dart';
import 'package:task/presentation/pages/sign_up/controller/sign_up_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignUpcontroller());
  }
}
