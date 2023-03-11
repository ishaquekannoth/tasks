import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/app/utils/app_colors.dart';
import 'package:task/app/utils/custom_strings.dart';
import 'package:task/app/utils/remote_config_utils.dart';
import 'package:task/core/routes.dart';
import 'package:task/data/models/user/user_model.dart';
import 'package:task/domain/entities/google_sign_in/google_sign_in.dart';
import 'package:task/domain/entities/push_notification/notifications.dart';

class LoginController extends GetxController {
  @override
  void onInit() async {
    preferences = await SharedPreferences.getInstance();
    super.onInit();
  }

  late SharedPreferences preferences;
  Rx<bool> isLoading = false.obs;
  final loginKey = GlobalKey<FormState>().obs;
  final Rx<TextEditingController> emailController = TextEditingController().obs;
  final Rx<TextEditingController> passwordController =
      TextEditingController().obs;
  final RxBool isObscured = true.obs;
  final RxBool isEnabled = false.obs;
  onLoginButtonPress() async {
    if (loginKey.value.currentState!.validate()) {
      String? dataOndisk = preferences.getString(emailController.value.text);
      if (dataOndisk != null) {
        UserModel user = UserModel.fromJson(jsonDecode(dataOndisk));
        if (user.email == emailController.value.text &&
            user.password == passwordController.value.text) {
          preferences.setBool(CustomStrings.isLoggedIn, true);
          preferences.setString(
              CustomStrings.loggedInUserkey, emailController.value.text);
          Get.snackbar(
              CustomStrings.validCredentials, CustomStrings.loginSuccess);
          Get.offNamed(Routes.mainDisplayer);
          if (RemoteConfigUtils().showBanner) {
            Get.showSnackbar(GetSnackBar(
              titleText: Text(RemoteConfigUtils().getServerString,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: CustomColors.whiteColor)),
              snackStyle: SnackStyle.GROUNDED,
              duration: const Duration(seconds: 5),
              dismissDirection: DismissDirection.endToStart,
              messageText: Text(
                "Please Update to the latest version V ${RemoteConfigUtils().getAppVersion}",
                textAlign: TextAlign.center,
                style: const TextStyle(color: CustomColors.whiteColor),
              ),
            ));
          }
          await PushNotificationService.getSetToken();
        } else {
          Get.snackbar(CustomStrings.invalidCredentials, "Try  again");
          return;
        }
      } else {
        Get.snackbar(CustomStrings.notRegistered, CustomStrings.registerPrompt);
        return;
      }
    }
  }

  togglePasswordVisibility() {
    isObscured.value = !isObscured.value;
    if (isObscured.value == false) {
      Timer(const Duration(seconds: 3), () {
        isObscured.value = !isObscured.value;
      });
    }
  }

  toggleLoginButton() {
    if (loginKey.value.currentState!.validate()) {
      isEnabled.value = true;
    } else {
      isEnabled.value = false;
    }
  }

  onLoginWithGoogle() async {
    try {
      isLoading.value = true;
      UserCredential? googleUser =
          await GoogleSignInRepo().signInWithGoogleAccount();
      if (googleUser == null) {
        return;
      } else {
        preferences.setString(
            googleUser.user!.email!,
            jsonEncode(UserModel(
              email: googleUser.user!.email.toString(),
              city: "",
              password: "",
              phoneNumber: "",
              state: "",
            ).toJson()));
        preferences.setBool(CustomStrings.isLoggedIn, true);
        preferences.setString(
            CustomStrings.loggedInUserkey, googleUser.user!.email!);
        Get.snackbar(
            CustomStrings.validCredentials, CustomStrings.loginSuccess);
        Get.offNamed(Routes.mainDisplayer);
        if (RemoteConfigUtils().showBanner) {
          Get.showSnackbar(GetSnackBar(
            titleText: Text(RemoteConfigUtils().getServerString,
                textAlign: TextAlign.center,
                style: const TextStyle(color: CustomColors.whiteColor)),
            snackStyle: SnackStyle.GROUNDED,
            duration: const Duration(seconds: 5),
            dismissDirection: DismissDirection.endToStart,
            messageText: Text(
              "Please Update to the latest version V ${RemoteConfigUtils().getAppVersion}",
              textAlign: TextAlign.center,
              style: const TextStyle(color: CustomColors.whiteColor),
            ),
          ));
        }
        await PushNotificationService.getSetToken();
      }
    } finally {
      isLoading.value = false;
    }
  }
}
