// ignore_for_file: prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourhand/controller/Auth_controller/login_controller.dart';
import 'package:yourhand/function/validinput.dart';
import 'package:yourhand/view/logIn%20&%20signUp/forgetPassword.dart';

import '../../common_widgets/primary_button.dart';
import '../../common_widgets/textField.dart';
import '../../common_widgets/upper_logo.dart';
import '../../theme.dart';
import 'service_applier_info.dart';

class LogIn extends StatefulWidget {
  LogIn({
    super.key,
  });

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  LoginController controller = Get.find<LoginController>();
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
                    "تسجيل دخول",
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
                          SizedBox(height: 10),
                          CustomTextField(
                            icon: Icon(Icons.lock_outline),
                            onIconPressed: () {},
                            title: "كلمة المرور",
                            validate: (val) =>
                                validInput(val!, 1, "password", ""),
                            controller: controller.password,
                            keyboardType: TextInputType.name,
                            obscureText: false,
                          ),
                          SizedBox(height: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                child: Text(
                                  "انقر هنا",
                                  style: TextStyle(
                                      color:
                                          const Color.fromARGB(255, 25, 70, 107)
                                              .withOpacity(0.5),
                                      fontSize: 14),
                                ),
                                onPressed: () {
                                  Get.to(ForgetPassword());
                                },
                              ),
                              Text(
                                "نسيت كلمة المرور ؟",
                                style: TextStyle(
                                    color: ThemeColor.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 50),
                          PrimaryButton(
                            height: 60,
                            width: 180,
                            text: 'تسجيل الدخول',
                            onTap: () {
                              controller.checkEmail();
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
