// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../theme.dart';

class ServiceApplierNavBar extends StatelessWidget {
  const ServiceApplierNavBar({
    super.key, required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title,
          style: TextStyle(
              color: ThemeColor.black,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        SizedBox(width: 15),
        Container(
          width: 80,
          height: 90,
          decoration: BoxDecoration(
              color: ThemeColor.white, borderRadius: BorderRadius.circular(20)),
          child: Image(image: AssetImage("assets/img/logo.png")),
        ),
      ],
    );
  }
}
