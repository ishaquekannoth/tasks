import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:task/app/utils/app_colors.dart';
import 'package:task/app/utils/dimensions.dart';
import 'package:task/app/utils/themes.dart';
import 'package:task/core/routes.dart';
import 'package:task/presentation/pages/login/controller/login_controller.dart';
import 'package:task/presentation/pages/login/widgets/custom_form_field.dart';

import 'widgets/custom_social_button.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
          child: Obx(
        () => controller.isLoading.value
            ? SizedBox(
                height: size.height,
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                      Text("Please wait while connecting to Google"),
                      SizedBox(
                        height: 50,
                      ),
                      CircularProgressIndicator()
                    ])))
            : Form(
                key: controller.loginKey.value,
                onChanged: () => controller.toggleLoginButton(),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(children: [
                    Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/login.jpg"),
                              fit: BoxFit.cover)),
                      height: size.height * 0.4,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CustomFormField(
                          type: FieldType.eMail,
                          controller: controller.emailController.value,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Obx(() => CustomFormField(
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
                            ))),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: SizedBox(
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Obx((() => ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    )),
                                onPressed: controller.isEnabled.value == true
                                    ? () {
                                        controller.onLoginButtonPress();
                                      }
                                    : null,
                                child: const Text(
                                  "Login",
                                  style: TextStyle(fontSize: 20),
                                )))),
                          ),
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "OR",
                      style: CustomStyle.style,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomWidgets.socialButtonCircle(
                            CustomColors.googleColor,
                            FontAwesomeIcons.googlePlusG,
                            iconColor: Colors.white, onTap: () async {
                          controller.onLoginWithGoogle();
                        }),
                        CustomWidgets.socialButtonCircle(
                            CustomColors.facebookColor,
                            FontAwesomeIcons.facebookF,
                            iconColor: Colors.white,
                            onTap: () {}),
                      ],
                    ),
                    const SizedBox(height: CustomDimensions.height20),
                    TextButton(
                        onPressed: () {
                          Get.offNamed(Routes.signUpScreen);
                        },
                        child: const Text("Dont have an Account? SignUp here."))
                  ]),
                ),
              ),
      )),
    ));
  }
}
