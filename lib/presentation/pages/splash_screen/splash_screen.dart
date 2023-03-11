import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/app/utils/app_colors.dart';
import 'package:task/app/utils/custom_strings.dart';
import 'package:task/app/utils/remote_config_utils.dart';
import 'package:task/domain/entities/firebase/remote_config.dart';

import '../../../core/routes.dart';
import 'widget/splash_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkIsloggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/images/splash_image.jpg",
                      ),
                      fit: BoxFit.cover)),
            ),
            Positioned(
                bottom: size.height * 0.05,
                left: size.width * 0.28,
                child: Column(
                  children: const [
                    SplashText(text: "Welcome to awesome", fontSize: 20),
                    SplashText(
                        text: "Where we meet expectation with reality!",
                        fontSize: 10),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

checkIsloggedIn() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  log(fcmToken.toString());
  preferences.setString(CustomStrings.fcmTokenKey, fcmToken.toString());
  await RemoteConfigServices.fetchRemoteConfigData();
  RemoteConfigUtils().checkPackageVersion();
  bool isLogged = preferences.getBool(CustomStrings.isLoggedIn) ?? false;
  if (isLogged) {
    Timer(
        const Duration(seconds: 1),
        () async => {
              await Get.offNamed(
                Routes.mainDisplayer,
              ),
              if (RemoteConfigUtils().showBanner)
                {
                  Get.showSnackbar(GetSnackBar(
                    titleText: Text(RemoteConfigUtils().getServerString,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: CustomColors.whiteColor)),
                    snackStyle: SnackStyle.GROUNDED,
                    duration: const Duration(seconds: 5),
                    dismissDirection: DismissDirection.endToStart,
                    messageText: Text(
                      "Please Update to the latest version V${RemoteConfigUtils().getAppVersion}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: CustomColors.whiteColor),
                    ),
                  ))
                },
            });
  } else {
    Timer(const Duration(seconds: 2), () => {Get.offNamed(Routes.onBoard)});
  }
}
