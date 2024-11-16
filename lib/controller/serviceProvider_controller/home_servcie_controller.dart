import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:random_string/random_string.dart';
import 'package:yourhand/controller/serviceProvider_controller/order_serviceProvider_controller.dart';
import 'package:yourhand/controller/serviceProvider_controller/serviceProvider_profile_controller.dart';
import 'package:yourhand/function/validUser.dart';
import 'package:yourhand/model/order_model.dart';
import 'package:yourhand/model/service_provider_model.dart';
import 'package:yourhand/sevices/database_methods.dart';

class HomeServiceController extends GetxController {
  var serviceName = ''.obs;
  late RxList myServices = [].obs;
  late RxBool load = false.obs;

  RxList<OrderModel> acceptedOrders = <OrderModel>[].obs;
  RxList<OrderModel> incomingOrders = <OrderModel>[].obs;
  RxList<OrderModel> doneOrders = <OrderModel>[].obs;

  RxBool loading = false.obs;

  late TextEditingController aboutYou;
  late TextEditingController everyHour;
  late TextEditingController everyday;
  late TextEditingController editEveryHour;
  late TextEditingController editEveryday;

  late RxList<String> services0 = <String>[].obs;
  getService2() async {
    // loadingServices.value = true;
    print("3");
    Set set = await getServices();
    for (var i in set) {
      services0.add(i);
    }
    // loadingServices.value = false;
    // loadingServices.refresh();
  }

  @override
  void onInit() {
    aboutYou = TextEditingController();
    everyHour = TextEditingController();
    everyday = TextEditingController();
    editEveryHour = TextEditingController();
    editEveryday = TextEditingController();
    getService2();
    getService();
    super.onInit();
  }

  getOrdersForservice(nameService) async {
    loading.value = false;

    List<OrderModel> orders = await GetOrdersByService(
        nameService, FirebaseAuth.instance.currentUser!.uid);

    //
    incomingOrders.value = [];
    acceptedOrders.value = [];
    doneOrders.value = [];
    for (OrderModel order in orders) {
      if (order.status == "incoming") {
        incomingOrders.add(order);
      } else if (order.status == "done") {
        doneOrders.add(order);
      } else {
        acceptedOrders.add(order);
      }
    }

    loading.value = true;
    loading.refresh();
    OrderServiceproviderController cont =
        Get.find<OrderServiceproviderController>();
    cont.getOrders();
  }

  Future<void> getService() async {
    load.value = true;

    await GetServicesByUserid(FirebaseAuth.instance.currentUser!.uid, "service")
        .then(
      (value) => myServices.value = value,
    );
    myServices.refresh();
  }

  adddService() async {
    List<String> names = [];
    for (var i in myServices) {
      names.add(i.name);
    }
    if (!names.contains(serviceName.value)) {
      String idService = randomAlphaNumeric(10);
      Map<String, dynamic> infoService = {
        "name": serviceName.value,
        "aboutYou": aboutYou.text,
        "idService": idService,
        "nameUser": Get.find<ServiceproviderProfileController>().name.value,
        "idUser": FirebaseAuth.instance.currentUser!.uid,
        "eachHour": everyHour.text,
        "eachDay": everyday.text,
      };
      await DatabaseMethods().addService(infoService, idService);
      await getService();
      Get.showSnackbar(const GetSnackBar(
        message: "تم أنشاء الخدمة ",
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      ));
    }
    if (names.contains(serviceName.value)) {
      Get.showSnackbar(const GetSnackBar(
        message: "الخدمة موجودة مسبقا ",
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      ));
    }
  }

  Future editDay(String serviceId) async {
    await FirebaseFirestore.instance
        .collection('service')
        .doc(serviceId)
        .update({
      "eachDay": editEveryday.text,
    });
    getService();
    // await user.updateEmail(editEmail.text);
    // await user.updatePassword(editEmail.text);
  }

  Future editHour(String serviceId) async {
    await FirebaseFirestore.instance
        .collection('service')
        .doc(serviceId)
        .update({
      "eachHour": editEveryHour.text,
    });
    getService();
  }

  Future delelateService(String id) async {
    await FirebaseFirestore.instance.collection('service').doc(id).delete();
    getService();
  }
}
