import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/app/utils/custom_strings.dart';
import 'package:task/core/routes.dart';
import 'package:task/data/models/user/user_model.dart';

class SignUpcontroller extends GetxController {
  late SharedPreferences preferences;
  final RxBool isObscured = true.obs;
  final RxBool isEnabled = false.obs;
  var signUpKey = GlobalKey<FormState>().obs;
  final Rx<TextEditingController> emailController = TextEditingController().obs;
  final Rx<TextEditingController> passwordController =
      TextEditingController().obs;
  final Rx<TextEditingController> confirmPasswordController =
      TextEditingController().obs;
  final Rx<TextEditingController> phoneNumberController =
      TextEditingController().obs;
  final Rx<TextEditingController> addressController =
      TextEditingController().obs;
  final Rx<TextEditingController> stateController = TextEditingController().obs;
  final Rx<TextEditingController> cityController = TextEditingController().obs;
  @override
  void onInit() async {
    preferences = await SharedPreferences.getInstance();
    super.onInit();
  }

  clearControllers() {
    emailController.value.clear();
    passwordController.value.clear();
    confirmPasswordController.value.clear();
    phoneNumberController.value.clear();
    stateController.value.clear();
    cityController.value.clear();
  }

  togglePasswordVisibility() {
    isObscured.value = !isObscured.value;
    if (isObscured.value == false) {
      Timer(const Duration(seconds: 3), () {
        isObscured.value = !isObscured.value;
      });
    }
  }

  toggleSignUpButton() {
    if (signUpKey.value.currentState!.validate()) {
      isEnabled.value = true;
    } else {
      isEnabled.value = false;
    }
  }

  onSignUpButtonPress() async {
    if (signUpKey.value.currentState!.validate()) {
      UserModel model = UserModel(
          phoneNumber: phoneNumberController.value.text,
          password: passwordController.value.text,
          email: emailController.value.text,
          city: cityController.value.text,
          state: stateController.value.text);
      if (preferences.containsKey(model.email)) {
        Get.snackbar("OOPS ! ..", CustomStrings.emailAlreadyRegistered,
            colorText: Colors.black);

        return;
      } else {
        preferences.setString(model.email, jsonEncode(model.toJson()));
        Get.snackbar("Hooraaay", CustomStrings.registrationSuccess);
        Future.delayed(const Duration(seconds: 1))
            .then((value) => Get.offNamed(Routes.loginScreen));
      }
    }
  }
}
