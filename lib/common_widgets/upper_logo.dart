// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../theme.dart';


class UpperLogo extends StatelessWidget {
  const UpperLogo({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width / 20, vertical: height / 20),
      height: height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ThemeColor.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(200),
          bottomRight: Radius.circular(200),
        ),
      ),
      child: Image(image: AssetImage("assets/img/logo.png")),
    );
  }
}
