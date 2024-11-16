// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourhand/model/service_provider_model.dart';
import 'package:yourhand/theme.dart';

import '../../../common_widgets/primary_button.dart';
import '../../../common_widgets/service_applier_navBar.dart';
import 'reservation_info.dart';

class ReservationView extends StatefulWidget {
  ReservationView({super.key, required this.item});

  ServiceInfoModel item;

  @override
  State<ReservationView> createState() => _ReservationViewState();
}

class _ReservationViewState extends State<ReservationView> {
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
            child: Padding(
              padding: EdgeInsets.only(right: width * 0.05, left: width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  ServiceApplierNavBar(
                    title: widget.item.name,
                  ),
                  SizedBox(height: height * 0.08),
                  Text(
                    widget.item.aboutYou,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        color: ThemeColor.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(height: height * 0.08),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                  SizedBox(height: height * 0.13),
                  Center(
                    child: PrimaryButton(
                      height: 50,
                      width: 170,
                      onTap: () {
                        Get.to(ReservationInfo(
                            aboutYou: widget.item.aboutYou,
                            priceDay: widget.item.eachDay,
                            priceHour: widget.item.eachHour,
                            idServiceProvider: widget.item.idUser,
                            nameService: widget.item.name,
                            nameServiceProvider: widget.item.nameUser
                            ));
                      },
                      text: "حجز",
                    ),
                  ),
                  SizedBox(height: height * 0.13),
                  SizedBox(height: height * 0.13),
                  SizedBox(height: height * 0.13),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
