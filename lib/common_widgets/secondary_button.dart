// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../theme.dart';

class SecondaryButton extends StatelessWidget {
  SecondaryButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.width,
      required this.height});
  void Function()? onTap;
  final String text;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: ThemeColor.white,
          border: Border.all(color:ThemeColor.primary),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
            child: Text(text,
                style: TextStyle(
                    color: ThemeColor.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w500))),
      ),
    );
  }
}
