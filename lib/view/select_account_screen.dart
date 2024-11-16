// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourhand/view/logIn%20&%20signUp/logIn.dart';

import '../common_widgets/primary_button.dart';
import '../common_widgets/upper_logo.dart';
import '../theme.dart';
import 'logIn & signUp/mother_singUp.dart';
import 'logIn & signUp/service_applier_signUp.dart';

class SelectAccount extends StatelessWidget {
  const SelectAccount({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ThemeColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeInDown(
                  delay: Duration(milliseconds: 300),
                  child: UpperLogo(width: width, height: height)),
              SizedBox(height: height * 0.08),
              FadeInDown(
                delay: Duration(milliseconds: 320),
                child: Text(
                  "اختر نوع المستخدم",
                  style: TextStyle(
                      color: ThemeColor.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              SizedBox(height: 15),
              FadeInDown(
                  delay: Duration(milliseconds: 340),
                  child: PrimaryButton(
                      width: 150,
                      height: 50,
                      onTap: () {
                        Get.to(MotherSignUp());
                      },
                      text: "أم")),
              SizedBox(height: 15),
              FadeInDown(
                  delay: Duration(milliseconds: 360),
                  child: PrimaryButton(
                      height: 50,
                      width: 150,
                      onTap: () {
                        Get.to(ServiceApplierSignUp());
                      },
                      text: "مقدم خدمة")),
              FadeInDown(
                delay: Duration(milliseconds: 370),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: Text(
                        "تسجيل دخول",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 25, 70, 107)
                                .withOpacity(0.5),
                            fontSize: 12),
                      ),
                      onPressed: () {
                        Get.to(LogIn());
                      },
                    ),
                    Text(
                      "تمتلك حساب بالغعل",
                      style: TextStyle(
                          color: ThemeColor.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
