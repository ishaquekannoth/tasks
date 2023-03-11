import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task/app/utils/app_colors.dart';
import 'package:task/presentation/pages/profile/widgets/title_widget.dart';

class NameNumberCard extends StatelessWidget {
  final String nameText;
  final String phone;
  final String? image;
  final void Function()? onTap;
  const NameNumberCard({
    this.onTap,
    this.image,
    required this.nameText,
    required this.phone,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Card(
          elevation: 5,
          color: CustomColors.whiteColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
            child: Row(
              children: [
                image == null
                    ? const CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.transparent,
                        backgroundImage:
                            AssetImage("assets/images/profile_dummy.jpg"),
                      )
                    : CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.transparent,
                        backgroundImage:
                            MemoryImage(const Base64Decoder().convert(image!)),
                      ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.5,
                      child: TitleWidget(
                        text: nameText,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TitleWidget(
                      text: phone,
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
