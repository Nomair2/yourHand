// ignore_for_file: prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourhand/controller/Auth_controller/signup_serviceProvider_controller.dart';
import 'package:yourhand/function/validinput.dart';

import '../../common_widgets/primary_button.dart';
import '../../common_widgets/textField.dart';
import '../../common_widgets/textField_area.dart';
import '../../common_widgets/upper_logo.dart';
import '../../controller/service_apllier.dart';
import '../../theme.dart';
import '../service_provider_side/service_applier_main_bottom_bar.dart';
import '../service_provider_side/service_applier_homePage/service_applier_home.dart';
import 'logIn.dart';

class ServiceApplierInfo extends StatefulWidget {
  const ServiceApplierInfo({super.key});

  @override
  State<ServiceApplierInfo> createState() => _ServiceApplierInfoState();
}

class _ServiceApplierInfoState extends State<ServiceApplierInfo> {
  SignupServiceproviderController controller =
      Get.find<SignupServiceproviderController>();
  // List<String> services = [
  //   "جليسة أطفال",
  //   "طبخ",
  //   "مدبرة منزل",
  //   "منسقة عزائم و حفلات",
  // ];
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
            child: Form(
              key: controller.key2,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: CustomTextFieldArea(
                      validate: (val) => validInput(val!, 1, "text", ""),
                      icon: Text(""),
                      onIconPressed: () {},
                      title: "نبذة عنك",
                      controller: controller.aboutYou,
                    ),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: Text(
                          "اختر نوع الخدمة التي تقدمها",
                          style: TextStyle(
                              color: ThemeColor.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Obx(
                    () => Container(
                      decoration: BoxDecoration(
                          color: ThemeColor.white,
                          borderRadius: BorderRadius.circular(15)),
                      width: 240,
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(25),
                        alignment: Alignment.centerRight,
                        hint: Obx(() => controller.serviceName.value.isEmpty
                            ? Text(
                                "اختر خدمة",
                                style: TextStyle(color: ThemeColor.black),
                              )
                            : Text(controller.serviceName.value,
                                style: TextStyle(color: ThemeColor.black))),
                        items: controller.services0.map((String service) {
                          return DropdownMenuItem<String>(
                            value: service,
                            child: Row(
                              children: [
                                Text(
                                  service,
                                  style: TextStyle(color: ThemeColor.black),
                                ),
                              ],
                            ), // Display the category name
                          );
                        }).toList(),
                        iconEnabledColor: Colors.pink,
                        iconSize: 50,
                        isExpanded: true,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        underline: Text(
                          "",
                          style: TextStyle(color: ThemeColor.white),
                        ),
                        onChanged: (String? val) {
                          if (val != null) {
                            controller.serviceName.value = val;
                          }
                        }, //o Implement your logic here when a selection changes
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  PrimaryButton(
                    text: "إكمال",
                    onTap: () {
                      controller.register2();
                    },
                    height: 50,
                    width: 190,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
