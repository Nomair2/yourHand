import 'package:flutter/material.dart';

import '../theme.dart';

class CustomTextFieldArea extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextAlign titleAlign;
  final Widget icon;
  final bool obscureText;
  final String? Function(String?)? validate ;
  final VoidCallback onIconPressed;
  const CustomTextFieldArea(
      {super.key,
      required this.title,
      this.validate ,
      this.controller,
      this.titleAlign = TextAlign.left,
      required this.icon,
      this.keyboardType,
      this.obscureText = false,
      required this.onIconPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: ThemeColor.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        maxLines: 10,
        style:
            TextStyle(color: ThemeColor.black, decoration: TextDecoration.none),
        controller: controller,
        keyboardType: keyboardType,
        validator: validate ,
        obscureText: obscureText,
        textAlign: TextAlign.end,
        decoration: InputDecoration(
          hintText: title,
          hintStyle: TextStyle(color: ThemeColor.black),
          suffixIcon: GestureDetector(
            onTap: onIconPressed,
            child: icon,
          ),
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
