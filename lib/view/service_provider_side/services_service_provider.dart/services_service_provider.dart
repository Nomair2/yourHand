// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourhand/controller/serviceProvider_controller/home_servcie_controller.dart';
import 'package:yourhand/view/mother_side/mother_services/service_provider_list.dart';
import 'package:yourhand/view/mother_side/mother_services/services_card.dart';
import 'package:yourhand/view/service_provider_side/service_applier_homePage/service_applier_home.dart';

import '../../../common_widgets/service_applier_navBar.dart';
import '../../../theme.dart';

class ServiceProviderServices extends StatefulWidget {
  const ServiceProviderServices({super.key});

  @override
  State<ServiceProviderServices> createState() =>
      _ServiceProviderServicesState();
}

class _ServiceProviderServicesState extends State<ServiceProviderServices> {
  HomeServiceController controller = Get.put(HomeServiceController());
  @override
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ThemeColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: height / 15),
                SizedBox(height: height / 10),
                FadeInDown(
                  delay: Duration(milliseconds: 250),
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 20,
                    ),
                    child: Text(
                      "خدماتي ",
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
                  child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: width / (height * 0.5),
                      shrinkWrap: true,
                      children:
                          List.generate(controller.myServices.length, (index) {
                        return ServicesCardProvider(
                          onTap: () {
                            controller.getOrdersForservice(
                                controller.myServices.value[index].name);
                            Get.to(ServiceApplierPage(
                                item: controller.myServices.value[index]));
                          },
                          id: controller.myServices.value[index].idService,
                          title: controller.myServices.value[index].name,
                        );
                      })),
                  // GridView.builder(
                  //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //       crossAxisCount: 2),
                  //   itemCount: 2,
                  //   itemBuilder: (context, index) => ServicesCard(
                  //       onTap: () {
                  //         Get.to(ServiceApplierPage(
                  //           title: "طبخ",
                  //         ));
                  //       },
                  //       title: "طبخ"),
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     Column(
                  //       children: [
                  //         ServicesCard(
                  //             onTap: () {
                  //               Get.to(ServiceApplierPage(
                  //                 title: "طبخ",
                  //               ));
                  //             },
                  //             title: "طبخ"),
                  //         SizedBox(height: 20),
                  //         ServicesCard(
                  //             onTap: () {
                  //               Get.to(ServiceApplierPage(
                  //                 title: "منسقة عزائم و حفلات",
                  //               ));
                  //             },
                  //             title: "منسقة عزائم و حفلات"),
                  //       ],
                  //     ),
                  //     Column(
                  //       children: [
                  //         ServicesCard(
                  //             onTap: () {
                  //               Get.to(ServiceApplierPage(
                  //                 title: "جليسة أطفال",
                  //               ));
                  //             },
                  //             title: "جليسة أطفال"),
                  //         SizedBox(height: 20),
                  //         ServicesCard(
                  //             onTap: () {
                  //               Get.to(ServiceApplierPage(
                  //                 title: "مدبرة منزل",
                  //               ));
                  //             },
                  //             title: "مدبرة منزل"),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
