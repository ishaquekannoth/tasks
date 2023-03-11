import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/app/utils/custom_strings.dart';
import 'package:task/app/utils/image_encode_decode.dart';
import 'package:task/data/models/user/user_model.dart';
import 'package:task/presentation/pages/profile/controller/profile_controller.dart';

class EditProfileController extends GetxController {
  late SharedPreferences preferences;
  Rx<UserModel> model = UserModel(
          phoneNumber: "phoneNumber",
          password: "password",
          email: "email",
          city: "city",
          state: "state")
      .obs;
  var editKey = GlobalKey<FormState>().obs;
  RxBool isEnabled = false.obs;
  final RxBool isObscured = true.obs;
  ProfileController profileController = Get.put(ProfileController());
  Rx<TextEditingController> stateController = TextEditingController().obs;
  Rx<TextEditingController> cityController = TextEditingController().obs;

  @override
  void onInit() async {
    preferences = await SharedPreferences.getInstance();
    var data = preferences.getString(CustomStrings.loggedInUserkey);
    model.value = UserModel.fromJson(
        jsonDecode(preferences.getString(data.toString()).toString()));
    log(model.value.toString());
    stateController.value = TextEditingController(text: model.value.state);
    cityController.value = TextEditingController(text: model.value.city);
    super.onInit();
  }

  toggleUpdateButton() {
    if (editKey.value.currentState!.validate()) {
      isEnabled.value = true;
    } else {
      isEnabled.value = false;
    }
  }

  onUpdateButtonPressed() {
    if (editKey.value.currentState!.validate()) {
      model.value = UserModel(
          email: model.value.email,
          city: cityController.value.text,
          state: stateController.value.text,
          phoneNumber: model.value.phoneNumber,
          password: model.value.password,
          image: model.value.image);
      var data = preferences.getString(CustomStrings.loggedInUserkey);
      preferences.setString(data.toString(), jsonEncode(model.toJson()));
      profileController.userData.value = model.value;
      Get.back();
    } else {
      return null;
    }
  }

  onPickImage() async {
    XFile? imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile == null) {
      return null;
    } else {
      String pickedImage =
          await ImageManipulator.imageStringFromFile(File(imageFile.path));
      model.value = UserModel(
          email: model.value.email,
          city: cityController.value.text,
          state: stateController.value.text,
          phoneNumber: model.value.phoneNumber,
          password: model.value.password,
          image: pickedImage);
      isEnabled.value = true;
    }
  }
}
