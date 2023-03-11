import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:task/app/utils/app_colors.dart';
import 'package:task/app/utils/themes.dart';
import 'package:task/presentation/pages/main_displayer/controller/main_displayer_controller.dart';

class MainDisplayerView extends GetView<MainDisplayerController> {
  const MainDisplayerView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: PersistentTabView(
      context,
      screens: controller.pages,
      confineInSafeArea: true,
      backgroundColor: CustomColors.whiteColor,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      items: [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: ("Home"),
          textStyle: CustomStyle.style,
          activeColorPrimary: CustomColors.whatsappColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.category),
          title: ("Explore"),
          textStyle: CustomStyle.style,
          activeColorPrimary: CustomColors.whatsappColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          title: ("Profile"),
          textStyle: CustomStyle.style,
          activeColorPrimary: CustomColors.whatsappColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ],
      navBarStyle: NavBarStyle.style9,
    ));
  }
}
