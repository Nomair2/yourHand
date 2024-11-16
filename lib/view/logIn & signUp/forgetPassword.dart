// ignore_for_file: prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourhand/controller/Auth_controller/forget_password_controller.dart';
import 'package:yourhand/controller/Auth_controller/login_controller.dart';
import 'package:yourhand/function/validinput.dart';

import '../../common_widgets/primary_button.dart';
import '../../common_widgets/textField.dart';
import '../../common_widgets/upper_logo.dart';
import '../../theme.dart';
import 'service_applier_info.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({
    super.key,
  });

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  ForgetPasswordController controller = Get.put(ForgetPasswordController());
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ThemeColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: FadeInDown(
            delay: Duration(milliseconds: 300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeInDown(
                    delay: Duration(milliseconds: 300),
                    child: UpperLogo(width: width, height: height)),
                SizedBox(height: height * 0.04),
                FadeInDown(
                  delay: Duration(milliseconds: 320),
                  child: Text(
                    "ادخل الايميل ",
                    style: TextStyle(
                        color: ThemeColor.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                SizedBox(height: 50),
                FadeInDown(
                  delay: Duration(milliseconds: 330),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                    child: Form(
                      key: controller.key,
                      child: Column(
                        children: [
                          CustomTextField(
                            validate: (val) => validInput(val!, 7, "email", ""),
                            icon: Icon(Icons.mail_outline),
                            onIconPressed: () {},
                            title: " البريد الإلكتروني",
                            controller: controller.email,
                            keyboardType: TextInputType.name,
                            obscureText: false,
                          ),
                          SizedBox(height: 50),
                          PrimaryButton(
                            height: 60,
                            width: width * 0.5,
                            text: "انشاء كلمة مرور جدبدة ",
                            onTap: () {
                              controller.forgetPassword();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
