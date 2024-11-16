// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourhand/common_widgets/textField.dart';
import 'package:yourhand/controller/serviceProvider_controller/home_servcie_controller.dart';
import 'package:yourhand/controller/serviceProvider_controller/order_serviceProvider_controller.dart';
import 'package:yourhand/model/order_model.dart';
import 'package:yourhand/model/service_provider_model.dart';
import 'package:yourhand/theme.dart';
import 'package:yourhand/view/service_provider_side/my_orders/order_details.dart';

import '../../../common_widgets/primary_button.dart';
import '../../../common_widgets/secondary_button.dart';
import '../../../common_widgets/service_applier_navBar.dart';

class ServiceApplierPage extends StatefulWidget {
  ServiceApplierPage({super.key, required this.item});
  ServiceInfoModel item;

  @override
  State<ServiceApplierPage> createState() => _ServiceApplierPageState();
}

class _ServiceApplierPageState extends State<ServiceApplierPage> {
  HomeServiceController controller = Get.put(HomeServiceController());
  OrderServiceproviderController controller2 =
      Get.put(OrderServiceproviderController());
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ThemeColor.background,
      body: SafeArea(
        child: Obx(
          () => SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: FadeInDown(
              delay: Duration(milliseconds: 300),
              child: Padding(
                padding:
                    EdgeInsets.only(right: width * 0.05, left: width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: height * 0.05,
                    ),
                    ServiceApplierNavBar(
                      title: widget.item.name,
                    ),
                    SizedBox(height: 30),
                    Text(
                      widget.item.aboutYou,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: ThemeColor.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    SizedBox(height: 35),
                    Center(
                      // padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: !controller.loading.value
                          ? CircularProgressIndicator()
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //accepted
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(50),
                                              topRight: Radius.circular(50),
                                            ),
                                          ),
                                          context: context,
                                          builder: (BuildContext context) {
                                            return OneOrder(
                                                incoming: false,
                                                height: height,
                                                title: "طلبات قيد التنفيذ",
                                                orders: controller
                                                    .acceptedOrders.value);
                                          });
                                    },
                                    child: Container(
                                      width: 120,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        color: ThemeColor.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.05),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(height: 50),
                                            Text(
                                              "${controller.acceptedOrders.length}",
                                              style: TextStyle(
                                                color: ThemeColor.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(height: 30),
                                            Text(
                                              "طلبات قيد التنفيذ",
                                              style: TextStyle(
                                                color: ThemeColor.black,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Incoming
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(50),
                                              topRight: Radius.circular(50),
                                            ),
                                          ),
                                          context: context,
                                          builder: (BuildContext context) {
                                            return OneOrder(
                                                incoming: true,
                                                title: "طلبات واردة",
                                                height: height,
                                                orders: controller
                                                    .incomingOrders.value);
                                          });
                                    },
                                    child: Container(
                                      width: 120,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        color: ThemeColor.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.05),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(height: 50),
                                            Text(
                                              "${controller.incomingOrders.length}",
                                              style: TextStyle(
                                                color: ThemeColor.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(height: 30),
                                            Text(
                                              "طلبات واردة",
                                              style: TextStyle(
                                                color: ThemeColor.black,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      width: 120,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        color: ThemeColor.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.05),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(height: 50),
                                            //here the number of undergoinig requets
                                            Text(
                                              "${controller.doneOrders.length}",
                                              style: TextStyle(
                                                color: ThemeColor.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(height: 30),
                                            Text(
                                              "طلبات منفذة",
                                              style: TextStyle(
                                                color: ThemeColor.black,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            _showEditProfileDialog(context, "السعر لكل ساعة ",
                                controller.editEveryHour, false);
                          },
                          child: Text(
                            "تعديل",
                            style: TextStyle(
                                color: Color.fromARGB(255, 99, 157, 204),
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Text(
                          "ريال ${widget.item.eachHour}",
                          style: TextStyle(
                              color: ThemeColor.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: 20),
                        Text(
                          ":السعر لكل ساعة",
                          style: TextStyle(
                              color: ThemeColor.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            _showEditProfileDialog(context, "السعر لكل يوم ",
                                controller.editEveryday, true);
                          },
                          child: Text(
                            "تعديل",
                            style: TextStyle(
                                color: Color.fromARGB(255, 99, 157, 204),
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Text(
                          "ريال ${widget.item.eachDay}   ",
                          style: TextStyle(
                              color: ThemeColor.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: 20),
                        Text(
                          ":السعر لكل يوم",
                          style: TextStyle(
                              color: ThemeColor.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context, String hint,
      TextEditingController controllerText, bool day) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text(''),
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFieldWithoutIcon(
                  onIconPressed: () {},
                  controller: controllerText,
                  title: hint,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  child: Text('ألغاء'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('حفظ'),
                  onPressed: () {
                    !day
                        ? controller.editHour(widget.item.idService)
                        : controller.editDay(widget.item.idService);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    // Navigator.push(context, MaterialPageRoute(builder:  (context) => ,));
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }
}

class OneOrder extends StatelessWidget {
  const OneOrder(
      {super.key,
      required this.title,
      required this.height,
      required this.orders,
      required this.incoming});

  final double height;
  final bool incoming;
  final String title;
  final List<OrderModel> orders;

  @override
  Widget build(BuildContext context) {
    OrderServiceproviderController controller =
        Get.put(OrderServiceproviderController());

    log("from here ");
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40),
      height: height * 0.75,
      child: Padding(
        padding: EdgeInsets.only(
          right: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 40),
            Text(
              title,
              style: TextStyle(
                color: ThemeColor.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          //the name of the customer
                          orders[index].nameUser,
                          style: TextStyle(
                              color: ThemeColor.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              // the date of the reservation
                              orders[index].startHour,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: ThemeColor.black.withOpacity(0.5)),
                            ),
                            Text(
                              // the date of the reservation
                              " الساعة ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: ThemeColor.black.withOpacity(0.5)),
                            ),
                            Text(
                              // the date of the reservation
                              orders[index].startDate,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: ThemeColor.black.withOpacity(0.5)),
                            ),
                            Text(
                              // the date of the reservation
                              "الحجز في ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: ThemeColor.black.withOpacity(0.5)),
                            ),
                            SizedBox(width: 8),
                            CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(orders[index].imageMother),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SecondaryButton(
                              height: 50,
                              width: 90,
                              onTap: () {
                                Get.to(OrderDetailView(
                                  order: orders[index],
                                  showDetail: true,
                                ));
                              },
                              text: "التفاصيل",
                            ),
                            SizedBox(width: 8),
                            SecondaryButton(
                              height: 50,
                              width: 90,
                              onTap: () {
                                controller.deleteOrder(orders[index].idOrder,
                                    orders[index].nameService, true);
                              },
                              text: "رفض",
                            ),
                            SizedBox(width: 8),
                            incoming
                                ? PrimaryButton(
                                    onTap: () {
                                      controller.updateOrder(orders[index],
                                          true, orders[index].nameService);
                                    },
                                    text: "قبول",
                                    height: 50,
                                    width: 90,
                                  )
                                : PrimaryButton(
                                    onTap: () async {
                                      await FirebaseFirestore.instance
                                          .collection("order")
                                          .doc(orders[index].idOrder)
                                          .update({"status": "done"});
                                      Get.back();
                                    },
                                    text: "انهاء",
                                    height: 50,
                                    width: 90,
                                  )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

                                    // showModalBottomSheet(
                                    //     shape: RoundedRectangleBorder(
                                    //       borderRadius: BorderRadius.only(
                                    //         topLeft: Radius.circular(50),
                                    //         topRight: Radius.circular(50),
                                    //       ),
                                    //     ),
                                    //     context: context,
                                    //     builder: (BuildContext context) {
                                    //       return Container(
                                    //         width: double.infinity,
                                    //         margin: EdgeInsets.symmetric(
                                    //             horizontal: 40),
                                    //         height: height,
                                    //         child: Padding(
                                    //           padding: EdgeInsets.only(
                                    //             right: 10,
                                    //           ),
                                    //           child: SingleChildScrollView(
                                    //             child: Column(
                                    //               crossAxisAlignment:
                                    //                   CrossAxisAlignment.end,
                                    //               children: [
                                    //                 SizedBox(height: 40),
                                    //                 Text(
                                    //                   "طلبات واردة",
                                    //                   style: TextStyle(
                                    //                     color: ThemeColor.black,
                                    //                     fontSize: 20,
                                    //                     fontWeight:
                                    //                         FontWeight.w600,
                                    //                   ),
                                    //                 ),
                                    //                 SizedBox(height: 40),
                                    //                 Row(
                                    //                   mainAxisAlignment:
                                    //                       MainAxisAlignment.end,
                                    //                   children: [
                                    //                     Column(
                                    //                       crossAxisAlignment:
                                    //                           CrossAxisAlignment
                                    //                               .end,
                                    //                       children: [
                                    //                         Text(
                                    //                           //the name of the customer
                                    //                           "داليا",
                                    //                           style: TextStyle(
                                    //                               color: ThemeColor
                                    //                                   .primary,
                                    //                               fontWeight:
                                    //                                   FontWeight
                                    //                                       .bold,
                                    //                               fontSize: 15),
                                    //                         ),
                                    //                         SizedBox(
                                    //                             height: 10),
                                    //                         Text(
                                    //                           // the date of the reservation
                                    //                           "الحجز يوم الأربعار الساعة العاشرة",
                                    //                           style: TextStyle(
                                    //                               fontSize: 14,
                                    //                               color: ThemeColor
                                    //                                   .black
                                    //                                   .withOpacity(
                                    //                                       0.5)),
                                    //                         ),
                                    //                       ],
                                    //                     ),
                                    //                     SizedBox(width: 8),
                                    //                     CircleAvatar(
                                    //                       backgroundColor:
                                    //                           ThemeColor
                                    //                               .background,
                                    //                       radius: 30,
                                    //                     ),
                                    //                   ],
                                    //                 ),
                                    //                 SizedBox(height: 40),
                                    //                 Row(
                                    //                   mainAxisAlignment:
                                    //                       MainAxisAlignment
                                    //                           .center,
                                    //                   children: [
                                    //                     SecondaryButton(
                                    //                       height: 50,
                                    //                       width: 90,
                                    //                       onTap: () {},
                                    //                       text: "التفاصيل",
                                    //                     ),
                                    //                     SizedBox(width: 8),
                                    //                     SecondaryButton(
                                    //                       height: 50,
                                    //                       width: 90,
                                    //                       onTap: () {},
                                    //                       text: "رفض",
                                    //                     ),
                                    //                     SizedBox(width: 8),
                                    //                     PrimaryButton(
                                    //                       onTap: () {},
                                    //                       text: "قبول",
                                    //                       height: 50,
                                    //                       width: 90,
                                    //                     ),
                                    //                   ],
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       );
                                    //     });
                                  