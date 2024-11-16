// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../theme.dart';

class ServiceTile extends StatelessWidget {
  const ServiceTile({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            SizedBox(width: 8),
            Image(
              image: AssetImage("assets/img/logo.png"),
              width: 50,
              height: 50,
            ),
          ],
        ),
        Divider(
            color: ThemeColor.black.withOpacity(0.2),
            indent: 50,
            endIndent: 50),
      ],
    );
  }
}
