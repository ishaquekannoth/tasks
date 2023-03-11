import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/utils/themes.dart';
import 'package:task/presentation/pages/edit_profile/controller/edit_profile_controller.dart';
import 'package:task/presentation/pages/edit_profile/widgets/profile_with_name.dart';
import 'package:task/presentation/pages/login/widgets/custom_form_field.dart';
import 'package:task/presentation/widgets/custom_login_button.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Edit Profile Data"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() => ProfileCard(
                    style: CustomStyle.style,
                    imageData: controller.model.value.image,
                    name: controller.model.value.email,
                    phoneNumber: controller.model.value.phoneNumber,
                    onTap: controller.onPickImage,
                  )),
              Form(
                key: controller.editKey.value,
                onChanged: () => {controller.toggleUpdateButton()},
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SizedBox(
                  height: size.height * 0.45,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Obx(() => CustomFormField(
                                  controller: controller.stateController.value,
                                  icon: Icons.flag,
                                  type: FieldType.normalInputField,
                                  hintText: "State",
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                )),
                            Obx(() => CustomFormField(
                                  controller: controller.cityController.value,
                                  icon: Icons.location_city,
                                  type: FieldType.normalInputField,
                                  hintText: "City",
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: SizedBox(
                                height: 50,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Obx((() => CustomLoginSignUpButton(
                                      buttonName: "Update",
                                      isEnabled: controller.isEnabled.value,
                                      onButtonClick: () => {
                                            controller.onUpdateButtonPressed()
                                          }))),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
