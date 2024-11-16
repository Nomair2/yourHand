// ignore_for_file: prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourhand/controller/Auth_controller/signup_mother_controller.dart';
import 'package:yourhand/function/validinput.dart';
import 'package:yourhand/view/logIn%20&%20signUp/logIn.dart';

import '../../common_widgets/primary_button.dart';
import '../../common_widgets/textField.dart';
import '../../common_widgets/upper_logo.dart';
import '../mother_side/mother_main_bottom_bar.dart';
import '../../theme.dart';

class MotherSignUp extends StatefulWidget {
  const MotherSignUp({super.key});

  @override
  State<MotherSignUp> createState() => _MotherSignUpState();
}

class _MotherSignUpState extends State<MotherSignUp> { 
  SignupMotherController controller = Get.find<SignupMotherController>();
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
                  "إنشاء حساب أم",
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
                          controller: controller.firstName,
                          validate: (val)=>validInput(val!, 1, "firstName", ""),
                          icon: Icon(Icons.person_3_outlined),
                          onIconPressed: () {},
                          title: "الاسم الاول",
                          // controller: nameCont,  
                          keyboardType: TextInputType.name,
                          obscureText: false,
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          validate: (val)=>validInput(val!, 1, "lastName", ""),
                          icon: Icon(Icons.person_3_outlined),
                          onIconPressed: () {},
                          title: "الاسم الاخير",
                          controller: controller.lastName,
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
                            // Get.to(LogIn(
                            //   onTap: () {
                            //     Get.to(MotherMainBottomBar());
                            //   },
                            // ),
                            // );
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
