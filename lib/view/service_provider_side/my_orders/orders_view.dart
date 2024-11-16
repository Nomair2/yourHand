// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourhand/controller/serviceProvider_controller/order_serviceProvider_controller.dart';

import '../../../theme.dart';
import 'order_details.dart';
import 'order_tile.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  OrderServiceproviderController controller =
      Get.put(OrderServiceproviderController());
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ThemeColor.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeColor.primary,
        title: ZoomIn(
          delay: Duration(milliseconds: 150),
          child: Text('طلباتي',
              style: TextStyle(color: ThemeColor.white, fontSize: 23)),
        ),
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              SizedBox(
                height: height,
                child: Obx(() => controller.loading.value
                    ? controller.incomingOrders.isNotEmpty
                        ? ListView.builder(
                            itemCount: controller.incomingOrders.value.length,
                            itemBuilder: (context, index) {
                              return FadeInDown(
                                delay: Duration(milliseconds: 200),
                                child: OrderTile(
                                  name: controller
                                      .incomingOrders.value[index].nameUser,
                                  onTap: () {
                                    Get.to(OrderDetailView(
                                      showDetail: false,
                                      order: controller
                                          .incomingOrders.value[index],
                                    ));
                                  },
                                ),
                              );
                            })
                        : Container()
                    : Center(
                        child: CircularProgressIndicator(),
                      )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
