// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourhand/controller/mother_controller/order_mother_controller.dart';
import '../../../common_widgets/date_textField.dart';
import '../../../common_widgets/primary_button.dart';
import '../../../common_widgets/service_applier_navBar.dart';
import '../../../theme.dart';

class ReservationInfo extends StatefulWidget {
  ReservationInfo(
      {super.key,
      required this.aboutYou,
      required this.idServiceProvider,
      required this.nameService,
      required this.nameServiceProvider,
      required this.priceDay,
      required this.priceHour});

  String idServiceProvider;
  String aboutYou;
  String nameService;
  String nameServiceProvider;
  String priceDay;
  String priceHour;

  @override
  State<ReservationInfo> createState() => _ReservationInfoState();
}

class _ReservationInfoState extends State<ReservationInfo> {
  OrderMotherController controller = Get.put(OrderMotherController());

  @override
  Widget build(BuildContext context) {
    controller.idServiceProvider.value = widget.idServiceProvider;
    controller.nameService.value = widget.nameService;
    controller.nameServiceProvider.value = widget.nameServiceProvider;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ThemeColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: FadeInDown(
            delay: Duration(milliseconds: 300),
            child: Padding(
              padding: EdgeInsets.only(right: width * 0.03, left: width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  ServiceApplierNavBar(
                    title: widget.nameService,
                  ),
                  SizedBox(height: height * 0.08),
                  Text(
                    widget.aboutYou,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        color: ThemeColor.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Container(
                      width: double.infinity,
                      height: height,
                      decoration: BoxDecoration(
                        color: ThemeColor.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: GetBuilder<OrderMotherController>(
                        builder: (controller) => Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: 10),
                            Center(
                              child: Container(
                                width: 60,
                                height: 4,
                                decoration: BoxDecoration(
                                    color: ThemeColor.black.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            ),
                            SizedBox(height: 25),
                            Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "اختر تفاصيل الحجز",
                                    style: TextStyle(
                                        color: ThemeColor.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      DateTextField(
                                        controller: controller.endDateCont,
                                        onTap: showEndDate,
                                        width: 100,
                                      ),
                                      SizedBox(width: 3),
                                      Text(
                                        "إلى",
                                        style: TextStyle(
                                            color: ThemeColor.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(width: 5),
                                      DateTextField(
                                        onTap: showDate,
                                        controller: controller.startDateCont,
                                        width: 100,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "حجز أيام  من",
                                        style: TextStyle(
                                            color: ThemeColor.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(width: 5),
                                      InkWell(
                                        onTap: () {
                                          controller.onChanged2("أيام");
                                        },
                                        child: Container(
                                          width: 35,
                                          height: 25,
                                          decoration: BoxDecoration(
                                              color: controller.price2 == true
                                                  ? Colors.green
                                                  : ThemeColor.primary,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 25),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      DateTextField(
                                        controller: controller.endHour,
                                        onTap: showEndTimePicke,
                                        width: 85,
                                      ),
                                      SizedBox(width: 3),
                                      Text(
                                        "إلى",
                                        style: TextStyle(
                                            color: ThemeColor.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(width: 5),
                                      DateTextField(
                                        controller: controller.startHour,
                                        onTap: showTimePicke,
                                        width: 85,
                                      ),
                                      Text(
                                        "حجز ساعات  من",
                                        style: TextStyle(
                                            color: ThemeColor.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(width: 5),
                                      InkWell(
                                        onTap: () {
                                          controller.onChanged2("ساعات");
                                        },
                                        child: Container(
                                          width: 35,
                                          height: 25,
                                          decoration: BoxDecoration(
                                              color: controller.price1 == true
                                                  ? Colors.green
                                                  : ThemeColor.primary,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30),
                                  Text(
                                    "اختر طريقة الدفع",
                                    style: TextStyle(
                                        color: ThemeColor.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(height: 25),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        child: Text(
                                          "كاش",
                                          style: TextStyle(
                                              color: ThemeColor.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        onTap: () {
                                          controller.onChanged1("كاش");
                                          controller.payment2(
                                              widget.idServiceProvider,
                                              controller.priceType == "ساعات"
                                                  ? widget.priceHour
                                                  : widget.priceDay,
                                              widget.nameService);
                                        },
                                      ),
                                      SizedBox(width: 20),
                                      Container(
                                        width: 35,
                                        height: 25,
                                        decoration: BoxDecoration(
                                            color: controller.pay1 == true
                                                ? Colors.green
                                                : ThemeColor.primary,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.onChanged1("بطاقة ائتمان");
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                  child: Container(
                                                    color: Colors.white,
                                                    height: 350,
                                                    width: 500,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10),
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 180),
                                                            child: Text(
                                                              "Card Number",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          TextField(
                                                            controller:
                                                                controller
                                                                    .cardNumber,
                                                          ),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10),
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Column(
                                                                    children: [
                                                                      Padding(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              right:
                                                                                  20),
                                                                          child:
                                                                              Text(
                                                                            "Expiry date",
                                                                            style:
                                                                                TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                          )),
                                                                      TextField(
                                                                        controller:
                                                                            controller.expiryDate,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Expanded(
                                                                  child: Column(
                                                                    children: [
                                                                      Text(
                                                                        "CVV",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                            50,
                                                                        child:
                                                                            TextField(
                                                                          controller:
                                                                              controller.cvv,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 150),
                                                            child: Text(
                                                              "Card holder name",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10),
                                                            child: Container(
                                                                height: 50,
                                                                child:
                                                                    TextField(
                                                                  controller:
                                                                      controller
                                                                          .cardHolderName,
                                                                )),
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          MaterialButton(
                                                            onPressed:
                                                                () async {
                                                              controller.payment1(
                                                                  widget
                                                                      .idServiceProvider,
                                                                  controller.priceType ==
                                                                          "ساعات"
                                                                      ? widget
                                                                          .priceHour
                                                                      : widget
                                                                          .priceDay,
                                                                  widget
                                                                      .nameService);
                                                            },
                                                            color: Color(
                                                                0xFF3498C8),
                                                            child: Text(
                                                              "OK",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                        child: Text(
                                          "بطاقة ائتمان",
                                          style: TextStyle(
                                              color: ThemeColor.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Container(
                                        width: 35,
                                        height: 25,
                                        decoration: BoxDecoration(
                                            color: controller.pay2 == true
                                                ? Colors.green
                                                : ThemeColor.primary,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 50),
                            Center(
                              child: PrimaryButton(
                                height: 50,
                                width: 170,
                                onTap: () {
                                  controller.addOrder();
                                },
                                text: "حجز",
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
      barrierColor: Colors.grey,
    );
    if (picked != null) {
      controller.startDateCont.text = picked.toString().substring(0, 10);
    }
  }

  //================
  Future<void> showEndDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
      barrierColor: Colors.grey,
    );
    if (picked != null) {
      controller.endDateCont.text = picked.toString().substring(0, 10);
    }
  }

  //============
  Future<void> showTimePicke() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      controller.startHour.text = pickedTime.format(context).toString();
    }
  }

  //=====
  Future<void> showEndTimePicke() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      controller.endHour.text = pickedTime.format(context).toString();
    }
  }
}
