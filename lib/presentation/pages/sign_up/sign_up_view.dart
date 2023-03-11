import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/core/routes.dart';
import 'package:task/presentation/pages/login/widgets/custom_form_field.dart';
import 'package:task/presentation/pages/sign_up/controller/sign_up_controller.dart';

import '../../widgets/custom_login_button.dart';

class SignUpScreen extends GetView<SignUpcontroller> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Form(
          key: controller.signUpKey.value,
          onChanged: () => controller.toggleSignUpButton(),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(children: [
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/sign_up.jpg"),
                        fit: BoxFit.cover)),
                height: size.height * 0.4,
              ),
              const SizedBox(
                height: 15,
              ),
              CustomFormField(
                controller: controller.emailController.value,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                type: FieldType.eMail,
              ),
              CustomFormField(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                hintText: "Phone number",
                type: FieldType.phoneNumber,
                icon: Icons.phone,
                controller: controller.phoneNumberController.value,
              ),
              Obx(() => CustomFormField(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    obscureText: controller.isObscured.value,
                    hintText: "Password",
                    type: FieldType.password,
                    icon: Icons.password,
                    controller: controller.passwordController.value,
                    postFixIcon: controller.isObscured.value == true
                        ? null
                        : Icons.visibility,
                    toggleVisibility: () =>
                        controller.togglePasswordVisibility(),
                  )),
              Obx(() => CustomFormField(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    obscureText: controller.isObscured.value,
                    hintText: "Confirm Password",
                    type: FieldType.password,
                    icon: Icons.password,
                    controller: controller.confirmPasswordController.value,
                    validator: (value) =>
                        value == controller.passwordController.value.text
                            ? null
                            : "oops..Passwords does not match",
                    postFixIcon: controller.isObscured.value == true
                        ? null
                        : Icons.visibility,
                    toggleVisibility: () =>
                        controller.togglePasswordVisibility(),
                  )),
              CustomFormField(
                controller: controller.stateController.value,
                icon: Icons.flag,
                type: FieldType.normalInputField,
                hintText: "State",
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
              CustomFormField(
                controller: controller.cityController.value,
                icon: Icons.location_city,
                type: FieldType.normalInputField,
                hintText: "City",
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
              Row(
                children: [
                  Expanded(
                      child: SizedBox(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Obx((() => CustomLoginSignUpButton(
                            buttonName: "SignUp",
                            isEnabled: controller.isEnabled.value,
                            onButtonClick: () =>
                                controller.onSignUpButtonPress(),
                          ))),
                    ),
                  )),
                ],
              ),
              TextButton(
                  onPressed: () => {Get.offNamed(Routes.loginScreen)},
                  child: const Text("Got an Account?Try Loggng in here"))
            ]),
          ),
        ),
      )),
    );
  }
}
