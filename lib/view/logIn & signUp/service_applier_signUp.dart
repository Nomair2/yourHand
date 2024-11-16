// ignore_for_file: prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourhand/controller/Auth_controller/signup_serviceProvider_controller.dart';
import 'package:yourhand/function/validinput.dart';

import '../../common_widgets/primary_button.dart';
import '../../common_widgets/textField.dart';
import '../../common_widgets/upper_logo.dart';
import '../../theme.dart';
import 'service_applier_info.dart';

class ServiceApplierSignUp extends StatefulWidget {
  const ServiceApplierSignUp({super.key});

  @override
  State<ServiceApplierSignUp> createState() =>
      _ServiceApplierSignUpSignUpState();
}

class _ServiceApplierSignUpSignUpState extends State<ServiceApplierSignUp> {
  SignupServiceproviderController controller = Get.find<SignupServiceproviderController>();
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
              SizedBox(height: height * 0.04),
              FadeInDown(
                delay: Duration(milliseconds: 320),
                child: Text(
                  "إنشاء حساب مقدم الخدمة",
                  style: TextStyle(
                      color: ThemeColor.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              SizedBox(height: 15),
              FadeInDown(
                delay: Duration(milliseconds: 330),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                  child: Form(
                    key: controller.key,
                    child: Column(
                      children: [
                        CustomTextField(
                          validate: (val)=>validInput(val!, 1, "firstName", ""),
                          icon: Icon(Icons.person_3_outlined),
                          onIconPressed: () {},
                          title: "الاسم الاول",
                          controller: controller.firstName,
                          keyboardType: TextInputType.name,
                          obscureText: false,
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          validate: (val)=>validInput(val!, 1, "lastName", ""),
                          controller: controller.lastName,
                          icon: Icon(Icons.person_3_outlined),
                          onIconPressed: () {},
                          title: "الاسم الاخير", 
                          keyboardType: TextInputType.name,
                          obscureText: false,
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          validate: (val)=>validInput(val!, 7, "email", ""),
                          icon: Icon(Icons.mail_outline),
                          onIconPressed: () {},
                          title: " البريد الإلكتروني",
                          controller: controller.email,
                          keyboardType: TextInputType.name,
                          obscureText: false,
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          validate: (val)=>validInput(val!, 1, "password", ""),
                          icon: Icon(Icons.lock_outline),
                          onIconPressed: () {},
                          title: "كلمة المرور",
                          controller: controller.password,
                          keyboardType: TextInputType.name,
                          obscureText: false,
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          validate: (val)=>validInput(val!, 1, "confirmPassword", controller.password.text),
                          icon: Icon(Icons.lock_outline),
                          onIconPressed: () {},
                          title: "تأكيد كلمة المرور", 
                          controller: controller.confirmPassword,
                          keyboardType: TextInputType.name,
                          obscureText: false,
                        ),
                        SizedBox(height: 30),
                        PrimaryButton(
                          height: 50,
                          width: 170,
                          text: 'إنشاء حساب',
                          onTap: () {
                            controller.register();
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
    );
  }
}
