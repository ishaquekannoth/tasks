import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/core/routes.dart';
import 'package:task/data/models/onBoard/onboarding_contents.dart';
import 'package:task/presentation/pages/on_boarding/controller/onboarding_controller.dart';

import 'build_dots.dart';

class OnboardingFlexibleWidget extends StatelessWidget {
  const OnboardingFlexibleWidget(
      {Key? key, required this.myController, required this.index})
      : super(key: key);
  final OnBoardingController myController;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Text(
            contents[index].title,
            style: const TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                contents[index].description,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
          Obx(() => BuildDots(
                currentIndex: myController.currentIndex.value,
                dotsCount: contents.length,
                dotsColor: Colors.deepOrange,
              )),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                height: 60,
                width: double.infinity,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        myController.currentIndex.value == contents.length - 1
                            ? const SizedBox(
                                width: 25,
                              )
                            : TextButton(
                                onPressed: () {
                                  Get.offNamed(Routes.loginScreen);
                                },
                                child: const Text(
                                  "Skip",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                        TextButton(
                            onPressed: () async {
                              if (myController.currentIndex.value ==
                                  contents.length - 1) {
                                Get.offNamed(Routes.loginScreen);
                              }

                              await myController.controller.value.nextPage(
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeIn);
                            },
                            child: Text(
                              myController.currentIndex.value ==
                                      contents.length - 1
                                  ? "Continue"
                                  : "Next",
                              style: const TextStyle(fontSize: 20),
                            )),
                      ],
                    ))),
          )
        ],
      ),
    ));
  }
}
