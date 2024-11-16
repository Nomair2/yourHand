// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourhand/controller/mother_controller/mother_services_controller.dart';
import 'package:yourhand/controller/serviceProvider_controller/home_servcie_controller.dart';
import 'package:yourhand/view/mother_side/mother_services/service_provider_list.dart';

import '../../../common_widgets/service_applier_navBar.dart';
import '../../../theme.dart';
import 'services_card.dart';

class MotherServices extends StatefulWidget {
  const MotherServices({super.key});

  @override
  State<MotherServices> createState() => _MotherServicesState();
}

class _MotherServicesState extends State<MotherServices> {
  // List<String> services = [
  //   "طبخ",
  //   "منسقة عزائم و حفلات",
  //   "جليسة أطفال",
  //   "مدبرة منزل"
  // ];
  MotherServicesController controller = Get.put(MotherServicesController());
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ThemeColor.background,
      body: SafeArea(
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: height / 15),
                FadeInDown(
                  delay: Duration(milliseconds: 150),
                  child: Padding(
                    padding: EdgeInsets.only(right: width * 0.05),
                    child: ServiceApplierNavBar(title: ""),
                  ),
                ),
                SizedBox(height: height / 10),
                FadeInDown(
                  delay: Duration(milliseconds: 250),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 130,
                    ),
                    child: Text(
                      "ما الخدمة التي تبحث عنها؟",
                      style: TextStyle(
                          color: ThemeColor.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(height: height / 18),
                FadeInDown(
                  delay: Duration(milliseconds: 300),
                  child: controller.loadingServices.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: width / (height * 0.5),
                          shrinkWrap: true,
                          children: List.generate(controller.services0.length,
                              (index) {
                            return ServicesCardMother(
                              onTap: () {
                                print("1");
                                controller
                                    .getServicer(controller.services0[index]);
                                Get.to(ServiceProviderList(
                                  appBarTitle: controller.services0[index],
                                ));
                              },
                              title: controller.services0[index],
                            );
                          })),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
