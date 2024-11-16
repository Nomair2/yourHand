import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourhand/controller/admin_Controller/adminController.dart';

import '../../theme.dart';
import 'order_info_tile.dart';

class Mothers extends StatelessWidget {
  const Mothers({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminController());
    return Scaffold(
      backgroundColor: ThemeColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: FadeInDown(
            delay: const Duration(milliseconds: 250),
            child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("mother").snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    final snap = snapshot.data!.docs;
                    return ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: snap.length,
                        itemBuilder: (context, index) {
                          return GetBuilder<AdminController>(
                              builder: (controller) => Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Card(
                                        color:
                                            ThemeColor.primary.withOpacity(0.4),
                                        elevation: 10,
                                        shadowColor:
                                            ThemeColor.primary.withOpacity(0.4),
                                        shape: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                                color: ThemeColor.primary)),
                                        child: Column(
                                          children: [
                                            ServiceProviderInfoTile(
                                              title: " : الاسم",
                                              value: snap[index]["firstName"] +
                                                  " " +
                                                  snap[index]["lastName"],
                                            ),
                                            ServiceProviderInfoTile(
                                              title: ": الإيميل",
                                              value: snap[index]["email"],
                                            ),
                                            const SizedBox(height: 10),
                                            IconButton(
                                                onPressed: () {
                                                  final data = snap[index]
                                                          .data()
                                                      as Map<String, dynamic>;
                                                  controller.delete(
                                                      "mother",
                                                      snap[index].id,
                                                      data["email"] as String,
                                                      data["password"]
                                                          as String);
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]));
                        });
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
          ),
        ),
      ),
    );
  }
}
