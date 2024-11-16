import 'package:flutter/material.dart';

import '../theme.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextAlign titleAlign;
  final Widget icon;
  final String? Function(String?)? validate ;
  final bool obscureText;
  final VoidCallback onIconPressed;
  const CustomTextField(
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
      height: 60,
      margin: EdgeInsets.only(top: 8),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: ThemeColor.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: TextFormField(
          validator: validate, 
          style:
              TextStyle(color: ThemeColor.black, ),
          controller: controller,
          keyboardType: keyboardType,
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
            // errorBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}


class CustomTextFieldWithoutIcon extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextAlign titleAlign; 
  final bool obscureText;
  final VoidCallback onIconPressed;
  const CustomTextFieldWithoutIcon(
      {super.key,
      required this.title,
      this.controller,
      this.titleAlign = TextAlign.left, 
      this.keyboardType,
      this.obscureText = false,
      required this.onIconPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: ThemeColor.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField( 
        style:
            TextStyle(color: ThemeColor.black, decoration: TextDecoration.none),
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        textAlign: TextAlign.end,
        decoration: InputDecoration(
          hintText: title,
          hintStyle: TextStyle(color: ThemeColor.black), 
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
