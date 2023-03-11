import 'package:flutter/material.dart';
import 'package:task/app/utils/app_colors.dart';
import 'package:task/presentation/pages/profile/widgets/title_widget.dart';

class AccountGridItem extends StatelessWidget {
  const AccountGridItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: CustomColors.whiteColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 54,
              width: 60,
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(20),
                  color: CustomColors.whiteColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 5.0,
                        spreadRadius: 1,
                        offset: const Offset(0, 6)),
                  ]),
              child: Icon(icon, color: CustomColors.themeColor),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TitleWidget(text: title, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
