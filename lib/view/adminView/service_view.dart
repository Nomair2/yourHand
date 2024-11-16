// ignore_for_file: prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:get/get.dart';
import 'package:yourhand/controller/admin_Controller/adminController.dart';

import '../../common_widgets/textField.dart';
import '../../theme.dart';

class ServiceView extends StatelessWidget {
  const ServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminController());
    return SingleChildScrollView(
        child: GetBuilder<AdminController>(
      builder: (controller) => Column(
        children: [
          SizedBox(height: 10),
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("service").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  final snap = snapshot.data!.docs;
                  return ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: snap.length,
                      itemBuilder: (context, index) {
                        return FadeInDown(
                          delay: Duration(milliseconds: 200),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            margin: EdgeInsets.only(bottom: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showPlatformDialog(
                                          context: context,
                                          builder: (context) =>
                                              BasicDialogAlert(
                                            title: Text(
                                                "هل تريد حذف هذه الخدمة؟ "),
                                            actions: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  BasicDialogAction(
                                                    title: Text("نعم"),
                                                    onPressed: () {
                                                      controller.delete(
                                                          "service",
                                                          snap[index].id);
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
                                      child: Icon(
                                        Icons.cancel_outlined,
                                        size: 30,
                                        color: ThemeColor.primary,
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    IconButton(
                                        onPressed: () {
                                          controller.serviceType.text=snap[index]["name"];
                                          controller.pricePerHour.text=snap[index]["eachHour"];
                                          controller.pricePerDay.text=snap[index]["eachDay"];
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return  AlertDialog(
                                                    content: Form(
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          CustomTextFieldWithoutIcon(
                                                            onIconPressed: () {},
                                                            title: "${snap[index]["name"]}",
                                                            controller: controller.serviceType,
                                                            keyboardType: TextInputType.name,
                                                            obscureText: false,
                                                          ),
                                                          const SizedBox(height: 10),
                                                          CustomTextFieldWithoutIcon(
                                                            onIconPressed: () {},
                                                            title: "${snap[index]["eachHour"]} per hour",
                                                            controller: controller.pricePerHour,
                                                            keyboardType: TextInputType.name,
                                                            obscureText: false,
                                                          ),
                                                          const SizedBox(height: 10),
                                                          CustomTextFieldWithoutIcon(
                                                            onIconPressed: () {},
                                                            title: "${snap[index]["eachDay"]} per day",
                                                            controller: controller.pricePerDay,
                                                            keyboardType: TextInputType.name,
                                                            obscureText: false,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          TextButton(
                                                            child: const Text('ألغاء'),
                                                            onPressed: () {
                                                              Get.back();
                                                            },
                                                          ),
                                                          TextButton(
                                                            child: const Text('حفظ'),
                                                            onPressed: () {
                                                              controller.saveChangesService(snap[index].id);
                                                            },
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  );
                                            },
                                          );
                                        },
                                        icon: Icon(
                                          Icons.mode_edit_outlined,
                                          size: 30,
                                          color: ThemeColor.primary,
                                        )),
                                  Spacer(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(snap[index]["name"],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700)),
                                        SizedBox(width: 8),
                                        Icon(
                                          CupertinoIcons.news,
                                          color: ThemeColor.primary,
                                          size: 40,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(snap[index]["eachDay"] + " per day",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700)),
                                    SizedBox(width: 50),
                                    Text(snap[index]["eachHour"] + " per hour",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700)),
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
                      });
                } else {
                  return CircularProgressIndicator();
                }
              })
        ],
      ),
    ));
  }

}
