import 'package:flutter/material.dart';

import '../../../theme.dart';

class OrderInfoTile extends StatelessWidget {
  final String value;
  final String title;

  OrderInfoTile({
    super.key,
    required this.value,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textDirection: TextDirection.rtl,
        children: [
          Text(title,
              style: TextStyle(
                color: ThemeColor.white,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              )),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Text(value,
                  style: TextStyle(
                    color: ThemeColor.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
