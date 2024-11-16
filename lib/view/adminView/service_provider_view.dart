import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourhand/view/adminView/service_provider_page.dart';
import '../../theme.dart';

class ServiceProviderView extends StatelessWidget {
  const ServiceProviderView({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),
          SizedBox(
              height: height,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("serviceProvider")
                      .where("status", isEqualTo: "pending")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      final snap = snapshot.data!.docs;
                      return ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: snap.length,
                          itemBuilder: (context, index) {
                            return FadeInDown(
                              delay: const Duration(milliseconds: 200),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(ServiceProviderPage(
                                          serviceName: snap[index]
                                              ["serviceName"],
                                          email: snap[index]["email"],
                                          name: snap[index]["firstName"] +" "
                                              +snap[index]["lastName"],
                                          index:snap[index].id
                                        ));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.arrow_back_ios,
                                            size: 25,
                                            color: ThemeColor.primary,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                  " مقدم الخدمة ${snap[index]["firstName"]} ${snap[index]["lastName"]}",
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                              const SizedBox(width: 8),
                                              Icon(
                                                Icons
                                                    .accessibility_new_outlined,
                                                color: ThemeColor.primary,
                                                size: 40,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                        color:
                                            ThemeColor.black.withOpacity(0.2),
                                        indent: 50,
                                        endIndent: 50),
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      return const Text("No service provider requests found");
                    }
                  })),
        ],
      ),
    );
  }
}
