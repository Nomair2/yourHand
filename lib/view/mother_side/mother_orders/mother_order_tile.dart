// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../theme.dart';

class MotherOrderTile extends StatelessWidget {
  MotherOrderTile(
      {super.key,
      required this.service,
      required this.onTap,
      required this.nameServiceProvider});

  final String service;
  void Function()? onTap;
  String nameServiceProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.only(bottom: 18),
      child: InkWell(
        onTap: onTap, 
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Text("طلب ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700)),
                      Text("${nameServiceProvider} ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700)),
                      Text("${service} ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700)),
                    ],
                  ),
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
