// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

import '../theme.dart';

class DateTextField extends StatelessWidget {
  DateTextField(
      {super.key,
      required this.onTap,
      required this.controller,
      required this.width});
  void Function()? onTap;
  TextEditingController controller;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 2),
      // height: 27,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: TextField(
          onTap: onTap,
          readOnly: true,
          style: TextStyle(
              color: ThemeColor.black.withOpacity(0.6),
              decoration: TextDecoration.none),
          controller: controller,
          obscureText: false,
          decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
