import 'package:get/get.dart';
import 'package:task/presentation/pages/edit_profile/controller/edit_profile_controller.dart';
import 'package:task/presentation/pages/profile/controller/profile_controller.dart';

class EditProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ProfileController>(ProfileController());
    Get.put<EditProfileController>(EditProfileController());
  }
}
