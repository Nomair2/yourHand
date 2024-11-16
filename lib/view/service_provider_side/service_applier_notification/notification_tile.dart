// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../theme.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.title, required this.text,required this.onTap,
  });
  final String title;
  final String text;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(onTap:onTap,
              child: Text(text,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700,color: ThemeColor.primary)),
            ),
            SizedBox(width: 8),

            Text(title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),

            SizedBox(width: 8),
            Icon(
              Icons.notifications,
              color: ThemeColor.primary,
              size: 40,
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
