import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/mother_controller/order_mother_controller.dart';
import '../../mother_side/mother_orders/mother_order_details_view.dart';
import 'notification_tile.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    OrderMotherController controller = Get.put(OrderMotherController());
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("order")
          .where("idUser", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No notifications to display."));
        }

        final notifications = snapshot.data!.docs;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              String title;
              String text = "انقر لعرض الطلب";
              if (notification["status"] == "incoming") {
                title = "طلبك قيد المعالجة";
              } else if (notification["status"] == "accepted") {
                title = "تم قبول طلبك من أجل ${notification["nameService"]}";
              } else if (notification["status"] == "done") {
                title = "تم الانتهاء من طلبك من أجل ${notification["nameService"]}";
              }
              else {
                title = "تم رفض طلبك من أجل ${notification["nameService"]}";
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: NotificationTile(title: title,text: text,onTap: (){Get.to(MotherOrderDetailView(order:controller.myOrders.value[index] ,));},),
              );
            },
          ),
        );
      },
    );
  }
}