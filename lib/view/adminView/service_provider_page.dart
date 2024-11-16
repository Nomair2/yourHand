import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:get/get.dart';
import 'package:yourhand/controller/admin_Controller/adminController.dart';
import '../../theme.dart';
import 'order_info_tile.dart';

class ServiceProviderPage extends GetView<AdminController> {
  final String serviceName;
  final String name;
  final String email;
  final String index;
  const ServiceProviderPage({super.key,required this.index, required this.serviceName, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminController());
    return Scaffold(
      backgroundColor: ThemeColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: FadeInDown(
              delay: const Duration(milliseconds: 250),
              child: GetBuilder<AdminController>(builder: (controller)=>
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      ZoomIn(
                        delay: const Duration(milliseconds: 350),
                        child: const Image(
                          image: AssetImage("assets/img/logo.png"),
                          width: 160,
                          height: 160,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 10, left: 20, right: 20, bottom: 20),
                        child: Column(children: [
                          Container(
                            padding: const EdgeInsets.only(
                                top: 15, right: 15, bottom: 15, left: 2.5),
                            decoration: BoxDecoration(
                              color: ThemeColor.primary.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Column(
                              children: [
                                ServiceProviderInfoTile(
                                  title: " : الخدمة المقدمة",
                                  value: serviceName,
                                ),
                                const SizedBox(height: 5),
                                ServiceProviderInfoTile(
                                  title: ": اسم مقدم الخدمة",
                                  value: name,
                                ),
                                const SizedBox(height: 5),
                                ServiceProviderInfoTile(
                                  title: ": الإيميل",
                                  value: email,
                                ),

                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _cancelOrder(
                                          context,
                                              () {
                                            controller.reject(index);
                                          },
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 15),
                                        decoration: BoxDecoration(
                                            color:
                                            ThemeColor.primary.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(15),
                                            border: Border.all(
                                                color: ThemeColor.primary
                                                    .withOpacity(0.15))),
                                        child: Text(
                                          " رفض الطلب",
                                          style: TextStyle(
                                              color: ThemeColor.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    InkWell(
                                      onTap: () {
                                        controller.accept(index);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 15),
                                        decoration: BoxDecoration(
                                            color:
                                            ThemeColor.primary.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(15),
                                            border: Border.all(
                                                color: ThemeColor.primary
                                                    .withOpacity(0.15))),
                                        child: Text(
                                          "قبول الطلب",
                                          style: TextStyle(
                                              color: ThemeColor.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
              )
            ),
          ),
        ),
      ),
    );
  }

  _cancelOrder(BuildContext context, void Function() onPressed) async {
    await showPlatformDialog(
      context: context,
      builder: (context) => BasicDialogAlert(
        title: const Center(child: Text("هل تريد رفض الطلب؟")),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BasicDialogAction(
                  title: Text(
                    "نعم",
                    style: TextStyle(color: ThemeColor.primary),
                  ),
                  onPressed: onPressed),
              BasicDialogAction(
                title: Text(
                  "لا",
                  style: TextStyle(color: ThemeColor.primary),
                ),
                onPressed: () {
                 Get.back();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
