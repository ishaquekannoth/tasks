import 'package:flutter/material.dart';

class BuildDots extends StatelessWidget {
  final int currentIndex;
  final Color dotsColor;
  final int dotsCount;
  const BuildDots(
      {required this.currentIndex,
      super.key,
      required this.dotsCount,
      required this.dotsColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          dotsCount,
          (index) => Container(
                height: 10,
                width: currentIndex == index ? 30 : 10,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: dotsColor),
              )),
    );
  }
}
