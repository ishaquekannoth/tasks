import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/utils/decorations.dart';
import 'package:task/data/models/onBoard/onboarding_contents.dart';
import 'package:task/presentation/pages/on_boarding/controller/onboarding_controller.dart';

import 'widget/on_boarding_flexible_widget.dart';

class OnBoard extends GetView<OnBoardingController> {
  const OnBoard({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: PageView.builder(
          allowImplicitScrolling: true,
          controller: controller.controller.value,
          onPageChanged: (value) {
            controller.indexSetter(value);
          },
          itemCount: contents.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Flexible(
                  child: Container(
                    decoration: AllDecoration()
                        .constDecorationBottom10
                        .copyWith(
                            image: DecorationImage(
                                image: AssetImage(contents[index].image),
                                fit: BoxFit.contain)),
                    width: double.infinity,
                  ),
                ),
                OnboardingFlexibleWidget(
                  myController: controller,
                  index: index,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
