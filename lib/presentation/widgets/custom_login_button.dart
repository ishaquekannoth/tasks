import 'package:flutter/material.dart';

class CustomLoginSignUpButton extends StatelessWidget {
  final bool isEnabled;
  final String buttonName;
  final void Function()? onButtonClick;
  const CustomLoginSignUpButton(
      {Key? key,
      required this.buttonName,
      required this.isEnabled,
      this.onButtonClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            )),
        onPressed: isEnabled == true ? onButtonClick : null,
        child: Text(
          buttonName,
          style: const TextStyle(fontSize: 20),
        ));
  }
}
