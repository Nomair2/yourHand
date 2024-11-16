// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:get/get.dart';
import 'package:yourhand/controller/serviceProvider_controller/home_servcie_controller.dart';

import '../../../theme.dart';

class ServicesCardProvider extends StatelessWidget {
  ServicesCardProvider(
      {super.key, required this.title, required this.onTap, required this.id});
  final String title;
  void Function()? onTap;
  final String id;
  @override
  Widget build(BuildContext context) {
    HomeServiceController controller = Get.find<HomeServiceController>();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(children: [
      Positioned(
        right: 5,
        top: 0,
        child: IconButton(
            onPressed: () {
              showPlatformDialog(
                context: context,
                builder: (context) => BasicDialogAlert(
                  title: Center(child: Text("هل تريد حذف الخدمة ")),
                  actions: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BasicDialogAction(
                          title: Text("نعم"),
                          onPressed: () {
                            controller.delelateService(id);
                            Get.back();
                          },
                        ),
                        BasicDialogAction(
                          title: Text("لا"),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
            icon: Icon(
              Icons.delete,
              color: Colors.grey[200],
            )),
      ),
      Positioned(
        right: 20,
        top: 0,
        left: 0,
        bottom: 50,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          width: width * 0.25,
          height: 70,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: ThemeColor.black, blurRadius: 5),
            ],
            color: ThemeColor.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: InkWell(
            onTap: onTap,
            child: Column(
              children: [
                Container(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    decoration: BoxDecoration(
                      color: ThemeColor.primary.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Image(
                        image: AssetImage(
                          "assets/img/logo.png",
                        ),
                        height: 70,
                        width: 70,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                      color: ThemeColor.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}

class ServicesCardMother extends StatelessWidget {
  ServicesCardMother({super.key, required this.title, required this.onTap});
  final String title;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      width: width * 0.25,
      height: 70,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: ThemeColor.black, blurRadius: 5),
        ],
        color: ThemeColor.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                  color: ThemeColor.primary.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Image(
                    image: AssetImage(
                      "assets/img/logo.png",
                    ),
                    height: 70,
                    width: 70,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                  color: ThemeColor.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
