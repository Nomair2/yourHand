// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../theme.dart';

class OrderTile extends StatelessWidget {
  OrderTile({
    super.key,
    required this.name,
    required this.onTap,
  });

  final String name;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                  color: ThemeColor.primary,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text(name,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                        Text(" لديك طلب من ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                      ],
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.task,
                      color: ThemeColor.primary,
                      size: 40,
                    ),
                  ],
                ),
              ],
            ),
            Divider(
                color: ThemeColor.black.withOpacity(0.2),
                indent: 50,
                endIndent: 50),
          ],
        ),
      ),
    );
  }
}
