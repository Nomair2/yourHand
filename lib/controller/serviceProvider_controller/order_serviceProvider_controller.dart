import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:random_string/random_string.dart';
import 'package:yourhand/controller/serviceProvider_controller/home_servcie_controller.dart';
import 'package:yourhand/function/validUser.dart';
import 'package:yourhand/model/order_model.dart';
import 'package:yourhand/sevices/database_methods.dart';

class OrderServiceproviderController extends GetxController {
  late RxList<OrderModel> myOrders = <OrderModel>[].obs;
  RxList<OrderModel> acceptedOrders = <OrderModel>[].obs;
  RxList<OrderModel> incomingOrders = <OrderModel>[].obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    getOrders();
    super.onInit();
  }

  getOrders() async {
    loading.value = false;
    await GetOrdersByServiceProviderid(
      FirebaseAuth.instance.currentUser!.uid,
    ).then(
      (value) => myOrders.value = value,
    );
    incomingOrders.value = [];
    acceptedOrders.value = [];
    myOrders.refresh();
    for (OrderModel order in myOrders.value) {
      if (order.status == 'incoming') {
        incomingOrders.add(order);
      } else if (order.status == "accepted") {
        acceptedOrders.add(order);
      }
    }
    for (OrderModel order in incomingOrders.value) {}
    acceptedOrders.refresh();
    incomingOrders.refresh();
    loading.value = true;
    loading.refresh();
  }

  deleteOrder(String orderId, String nameService, bool getSrvice) async {
    FirebaseFirestore.instance.collection('order').doc(orderId).delete();
    getOrders();

    if (getSrvice) {
      HomeServiceController cont = Get.find<HomeServiceController>();
      cont.getOrdersForservice(nameService);
    }
    Get.back();
  }

  Future<String> getImageUser(String collection, String id) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection(collection).doc(id).get();

    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>?; // Use nullable type
      return data != null && data['image'] != null ? data['image'] : "";
    } else {
      // Handle the case where the document does not exist
      return ""; // Return a default value or an empty string
    }
  }

  updateOrder(OrderModel order, bool detail, String nameService) async {
    await FirebaseFirestore.instance
        .collection('order')
        .doc(order.idOrder)
        .update({
      "status": "accepted",
    });
    Get.back();
    String idChat = randomAlphaNumeric(10);
    String imageMother = await getImageUser("mother", order.idUser);
    String imageProvider =
        await getImageUser("serviceProvider", order.idServiceProvider);
    Map<String, dynamic> infoChat = {
      "idChat": idChat,
      "imageMother": imageMother,
      "imageServiceProvider": imageProvider,
      "nameServiceProvider": order.nameServiceProvider,
      "nameMother": order.nameUser,
      "idMother": order.idUser,
      "idServiceProvider": FirebaseAuth.instance.currentUser!.uid
    };
    print("${order.idUser}, ${order.idUser}");
    bool? exist =
        await FindChat(order.idUser, FirebaseAuth.instance.currentUser!.uid);
    if (exist == false) {
      await DatabaseMethods().addChat(infoChat, idChat);
    }

    getOrders();
    if (!detail) {
      Get.back();
    } else {
      HomeServiceController cont = Get.find<HomeServiceController>();
      cont.getOrdersForservice(nameService);
    }

    Get.back();
  }
}
