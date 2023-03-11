import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/app/utils/app_colors.dart';
import 'package:task/app/utils/custom_strings.dart';
import 'package:task/core/routes.dart';
import 'package:task/data/models/user/user_model.dart';

class ProfileController extends GetxController {
  late SharedPreferences preferences;
  Rx<UserModel> userData = UserModel(
          phoneNumber: "phoneNumber",
          password: "password",
          email: "email",
          city: "city",
          state: "state")
      .obs;
  @override
  void onInit() async {
    preferences = await SharedPreferences.getInstance();
    final data = preferences.getString(CustomStrings.loggedInUserkey);
    userData.value = UserModel.fromJson(
        jsonDecode(preferences.getString(data.toString()).toString()));
    super.onInit();
  }

  onLogoutButtonClick() async {
    await Get.defaultDialog(
      confirmTextColor: CustomColors.whiteColor,
      textConfirm: "Confirm",
      radius: 10,
      middleText: "Do you want to log out?",
      title: "Logout !",
      onCancel: () => Get.back(),
      onConfirm: () {
        preferences.setBool(CustomStrings.isLoggedIn, false);

        Get.offNamedUntil(Routes.loginScreen, (route) => false);
      },
    );
    await FirebaseAuth.instance.signOut();
  }

  onResetButtonClick() async {
    await Get.defaultDialog(
      confirmTextColor: CustomColors.whiteColor,
      textConfirm: "Confirm!!",
      radius: 10,
      middleText: "Reset Everything? This cant be undone!",
      title: "Reset",
      onCancel: () => Get.back(),
      onConfirm: () {
        preferences
            .setBool(CustomStrings.isLoggedIn, false)
            .then((value) => FirebaseAuth.instance.signOut())
            .then((value) => preferences.clear())
            .then((value) =>
                Get.offNamedUntil(Routes.splashScreen, (route) => false));
      },
    );
  }
}
