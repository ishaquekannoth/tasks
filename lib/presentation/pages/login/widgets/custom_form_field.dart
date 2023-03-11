import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task/core/validation.dart';

enum FieldType { eMail, password, normalInputField, phoneNumber }

class CustomFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final double? borderRadius;
  final FieldType type;
  final String? hintText;
  final IconData? icon;
  final IconData? postFixIcon;
  final bool? obscureText;
  final EdgeInsetsGeometry padding;
  final TextEditingController? controller;
  final VoidCallback? toggleVisibility;
  const CustomFormField(
      {this.obscureText,
      this.borderRadius,
      this.toggleVisibility,
      this.postFixIcon,
      this.validator,
      this.padding = const EdgeInsets.all(5),
      this.controller,
      required this.type,
      this.hintText = "E-mail",
      super.key,
      this.icon = Icons.email});
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: padding,
      child: TextFormField(
          controller: controller,
          inputFormatters: [
            type == FieldType.eMail
                ? LengthLimitingTextInputFormatter(30)
                : type == FieldType.normalInputField
                    ? LengthLimitingTextInputFormatter(15)
                    : type == FieldType.phoneNumber
                        ? LengthLimitingTextInputFormatter(10)
                        : LengthLimitingTextInputFormatter(20),
            type == FieldType.normalInputField
                ? FilteringTextInputFormatter.allow(RegExp("[A-Z a-z]"))
                : type == FieldType.phoneNumber
                    ? FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                    : FilteringTextInputFormatter.deny(RegExp("")),
          ],
          keyboardType: type == FieldType.eMail
              ? TextInputType.emailAddress
              : type == FieldType.password
                  ? TextInputType.name
                  : type == FieldType.phoneNumber
                      ? TextInputType.phone
                      : TextInputType.name,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              prefixIcon: Icon(
                icon,
                color: Colors.deepPurple,
              ),
              suffixIcon: type == FieldType.password
                  ? IconButton(
                      icon: Icon(postFixIcon ?? Icons.visibility_off),
                      onPressed: toggleVisibility,
                      color: Colors.black,
                    )
                  : null,
              hintText: hintText,
              labelText: hintText,
              labelStyle: const TextStyle(color: Colors.deepPurple),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              errorStyle: const TextStyle(color: Colors.blue),
              enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(borderRadius ?? 10)),
                  borderSide: const BorderSide(color: Colors.deepPurple)),
              disabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(borderRadius ?? 10)),
                  borderSide: const BorderSide(color: Colors.deepPurple)),
              focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple)),
              errorBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(borderRadius ?? 10)),
                  borderSide: const BorderSide(
                      style: BorderStyle.solid, color: Colors.deepPurple)),
              contentPadding:
                  EdgeInsets.only(left: 0, top: 0, bottom: height * 0.02),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(borderRadius ?? 10)),
              )),
          validator: validator ??
              (type == FieldType.eMail
                  ? (value) {
                      if (value!.isEmpty) {
                        return "$hintText Cant be empty";
                      } else if (!value.isValidEmail) {
                        return "Invalid Email";
                      } else {
                        return null;
                      }
                    }
                  : type == FieldType.password
                      ? (value) {
                          if (value == '' || value == null) {
                            return "$hintText Cant be empty";
                          } else if (value.length < 8) {
                            return "Password Must be greater than 8 charactors";
                          } else if (!value.isValidPassword) {
                            return "Must contain an Uppercase,Lowercase,a special char & 1 digit";
                          } else {
                            return null;
                          }
                        }
                      : type == FieldType.normalInputField
                          ? (value) {
                              if (value == '' || value == null) {
                                return "$hintText Cant be empty";
                              } else if (value.length < 3 ||
                                  value.length > 16) {
                                return "$hintText must be 3-14 Charactors";
                              } else {
                                return null;
                              }
                            }
                          : (value) {
                              if (value == '' || value == null) {
                                return "$hintText Cant be empty";
                              } else if (value.length < 10) {
                                return "Phone number Invalid";
                              } else {
                                return null;
                              }
                            })),
    );
  }
}
