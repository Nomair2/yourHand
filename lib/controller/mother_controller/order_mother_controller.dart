import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:random_string/random_string.dart';
import 'package:yourhand/function/validUser.dart';
import 'package:yourhand/model/order_model.dart';
import 'package:yourhand/sevices/database_methods.dart';

class OrderMotherController extends GetxController {
  bool pay1 = false;
  bool pay2 = false;
  bool price1 = false;
  bool price2 = false;

  late TextEditingController cardNumber;

  late TextEditingController expiryDate;

  late TextEditingController cvv;

  late TextEditingController cardHolderName;

  late RxString idServiceProvider = ''.obs;
  late RxString nameService = ''.obs;

  late RxString nameServiceProvider = ''.obs;
  late RxList myOrders = [].obs;
  late Rx<OrderModel> order = OrderModel(
          token: "",
          imageMother: "",
          idServiceProvider: "",
          idOrder: "",
          nameService: "",
          nameUser: "",
          status: "",
          nameServiceProvider: "",
          idUser: "",
          startDate: "",
          endDate: "",
          startHour: "",
          endHour: "")
      .obs;
  late TextEditingController startDateCont = TextEditingController();
  late TextEditingController endDateCont = TextEditingController();
  late TextEditingController startHour = TextEditingController();
  late TextEditingController endHour = TextEditingController();

  final TextEditingController newStartDate = TextEditingController();
  final TextEditingController newEndDate = TextEditingController();
  final TextEditingController newStartHour = TextEditingController();
  final TextEditingController newEndHour = TextEditingController();

  String payType = "";
  String priceType = "";

  @override
  void onInit() {
    startDateCont = TextEditingController();
    endDateCont = TextEditingController();
    startHour = TextEditingController();
    endHour = TextEditingController();
    cardNumber = TextEditingController();
    expiryDate = TextEditingController();
    cvv = TextEditingController();
    cardHolderName = TextEditingController();
    getOrders();
    super.onInit();
  }

  payment1(String sID, String price, String serviceName) async {
    await FirebaseFirestore.instance.collection("Payment").doc().set({
      "userId": FirebaseAuth.instance.currentUser!.uid,
      "Price": price,
      "method": "بطاقة ائتمان",
      "serviceId": sID,
      "cardNumber": cardNumber.text,
      "expiryDate": expiryDate.text,
      "cvv": cvv.text,
      "cardHolderName": cardHolderName.text,
      "serviceName": serviceName
    });
    update();
  }

  payment2(String sID, String price, String serviceName) async {
    await FirebaseFirestore.instance.collection("Payment").doc().set({
      "userId": FirebaseAuth.instance.currentUser!.uid,
      "Price": price,
      "method": "كاش",
      "serviceId": sID,
      "serviceName": serviceName
    });
    update();
  }

  void onChanged1(String paymentMethod) {
    if (paymentMethod == "كاش") {
      pay1 = true;
      pay2 = false;
    } else if (paymentMethod == "بطاقة ائتمان") {
      pay1 = false;
      pay2 = true;
    }
    payType = paymentMethod;
    update();
  }

  void onChanged2(String priceMethod) {
    if (priceMethod == "ساعات") {
      price1 = true;
      price2 = false;
    } else if (priceMethod == "أيام") {
      price1 = false;
      price2 = true;
    }
    priceType = priceMethod;
    update();
  }

  Future<String> getImageUser(String collection, String id) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection(collection).doc(id).get();

    final data = doc.data() as Map<String, dynamic>;

    String? image = data['image'];

    return image ?? " ";
  }

  addOrder() async {
    String idUser = await GetStorage().read('userId');
    String nameUser = await GetStorage().read('userName');
    String imageMother = await getImageUser("mother", idUser);
    String idOrder = randomAlphaNumeric(10);
    await GetStorage().write('orderId', idOrder);
    // String token = await GetStorage().read('token');
    String token = " ";
    Map<String, dynamic> addOrder = {
      "token": token,
      "idOrder": idOrder,
      "imageMother": imageMother,
      "idServiceProvider": idServiceProvider.value,
      "nameServiceProvider": nameServiceProvider.value,
      "nameService": nameService.value,
      "status": "incoming",
      "nameUser": nameUser,
      "idUser": idUser,
      "startDate": startDateCont.text,
      "endDate": endDateCont.text,
      "startHour": startHour.text,
      "endHour": endHour.text,
      "payType": payType
    };
    await DatabaseMethods().addOrder(addOrder, idOrder);
    getOrders();
    Get.back();
    Get.back();
    Get.back();
    Get.showSnackbar(const GetSnackBar(
      message: "تم أنشاء الطلب ",
      duration: Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
    ));
  }

  getOrders() async {
    var idUser = await GetStorage().read('userId');
    await GetOrdersByUserid(
      idUser,
    ).then(
      (value) => myOrders.value = value,
    );
    myOrders.refresh();
  }

  getOrder() async {
    String orderId = await GetStorage().read('orderId');
    DocumentSnapshot result =
        await FirebaseFirestore.instance.collection('order').doc(orderId).get();

    order.value = OrderModel.fromMap(result.data() as Map<String, dynamic>);
    order.refresh();
  }

  updateOrder(orderId) async {
    // String orderId = await GetStorage().read('orderId');

    await FirebaseFirestore.instance.collection('order').doc(orderId).update({
      "startDate": newStartDate.text,
      "endDate": newEndDate.text,
      "startHour": newStartHour.text,
      "endHour": newEndHour.text
    });

    getOrder();
    Get.back();
  }

  deleteOrder(String orderId) async {
    FirebaseFirestore.instance.collection('order').doc(orderId).delete();
    getOrders();
  }
}
