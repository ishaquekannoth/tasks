import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task/app/utils/app_colors.dart';

class ProfileCard extends StatelessWidget {
  ProfileCard({
    this.imageData,
    required this.name,
    required this.phoneNumber,
    this.onTap,
    this.style,
    super.key,
  }) {
    onTap ?? () => {};
    style ??
        const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            overflow: TextOverflow.ellipsis);
  }
  final String? imageData;
  final String name;
  final String phoneNumber;
  final TextStyle? style;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          height: size.height * 0.3,
          width: size.width * 0.9,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            gradient: LinearGradient(begin: Alignment.bottomCenter, colors: [
              CustomColors.blackColor,
              CustomColors.googleColor,
              CustomColors.facebookColor,
              CustomColors.instaColor
            ]),
            // color: CustomColors.whatsappColor
          ),
          child: LayoutBuilder(
              builder: (ctx, cstr) => Stack(
                    fit: StackFit.loose,
                    children: [
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          height: cstr.maxHeight * 0.5,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: Colors.white),
                        ),
                      ),
                      Center(
                        child: Stack(
                          children: [
                            imageData == null
                                ? const CircleAvatar(
                                    radius: 80,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: AssetImage(
                                        "assets/images/profile_dummy.jpg"),
                                  )
                                : CircleAvatar(
                                    radius: 80,
                                    backgroundImage: MemoryImage(
                                        const Base64Decoder()
                                            .convert(imageData!)),
                                  ),
                            Positioned(
                              right: 1,
                              bottom: 1,
                              child: IconButton(
                                  onPressed: () => {},
                                  icon: const Icon(
                                    Icons.cameraswitch_outlined,
                                    color: Color.fromARGB(255, 44, 243, 9),
                                    size: 30,
                                  )),
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: cstr.maxHeight * 0.2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: cstr.maxWidth * 0.4,
                                child: Text(
                                  name,
                                  style: style,
                                ),
                              ),
                              SizedBox(
                                width: cstr.maxWidth * 0.4,
                                child: Text(
                                  phoneNumber,
                                  style: style,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
        ),
      ),
    );
  }
}
