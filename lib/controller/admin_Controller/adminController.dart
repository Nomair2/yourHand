import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';
import 'package:yourhand/view/logIn%20&%20signUp/logIn.dart';
import 'package:yourhand/view/select_account_screen.dart';
import '../../view/adminView/main_bottom_bar_admin.dart';
import '../../view/adminView/mothers.dart';
import '../../view/adminView/serviceProviders.dart';

class AdminController extends GetxController {
  late TextEditingController emailC;

  late TextEditingController userNameC;

  late TextEditingController passwordC;

  late TextEditingController serviceType;

  late TextEditingController pricePerHour;

  late TextEditingController pricePerDay;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? email;
  String? name;
  String? password;
  String? serviceName;
  String? priceperhour;
  String? priceperday;

  List<Widget> screens = <Widget>[
    const Mothers(),
    const ServiceProviders(),
  ];
  int selectedTab = 0;

  void goToTab(index) {
    selectedTab = index;
    update();
  }

  void goToLogin() {
    Get.offAll(SelectAccount());
    update();
  }

  Future<void> logout() async {
    await signOut();
    goToLogin();
    update();
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  delete(String collection, String doc, [email2, password2, userId]) async {
    print("Collection is ${collection}");
    print("Collection is ${doc}");
    print("Collection is ${email2}");
    print("Collection is ${password2}");
    print("Collection is ${userId}");
    if (collection == "service") {
      await FirebaseFirestore.instance.collection(collection).doc(doc).delete();
    } else if (collection == "Admin") {
      await FirebaseFirestore.instance.collection(collection).doc(doc).delete();
      FirebaseAuth.instance.currentUser!.delete();
      Get.offAll(SelectAccount());
    } else if (collection == "mother") {
      print("${email2}");
      print("${password2}");
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email2, password: password2);
      FirebaseAuth.instance.currentUser!.delete();
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
      await FirebaseFirestore.instance.collection(collection).doc(doc).delete();
    } else {
      print("${email2}");
      print("${password2}");
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email2, password: password2)
          .then(
              // (value) => FirebaseAuth.instance.currentUser!.delete(),
              (value) {
        print(
            "the id for providerId is ${FirebaseAuth.instance.currentUser!.uid}");
        FirebaseAuth.instance.currentUser!.delete();
        FirebaseAuth.instance.signOut();
      });
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("service")
          .where("idUser", isEqualTo: userId)
          .get();
      List data = querySnapshot.docs;
      print(data.length);
      for (var i in data) {
        print(i.data());
        print(i.data()['idService']);
        FirebaseFirestore.instance
            .collection('service')
            .doc(i.data()['idService'])
            .delete();
      }

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!)
          .then(
              // (value) => FirebaseAuth.instance.currentUser!.delete(),
              (value) {
        print(
            "the id for providerId is ${FirebaseAuth.instance.currentUser!.uid}");
      });
      await FirebaseFirestore.instance.collection(collection).doc(doc).delete();
    }
    Get.snackbar("Success", "account has been successfully deleted.");
    Get.back();
    update();
  }

  accept(String index) async {
    try {
      await FirebaseFirestore.instance
          .collection("serviceProvider")
          .doc(index)
          .update({"status": "enable"});
      Get.to(const MainNavBarAdmin());
      Get.snackbar("Success", "Accepted");
    } catch (e) {
      Get.snackbar("Error", "Failed to accept serviceProvider account: $e");
    }
    update();
  }

  reject(String index) async {
    try {
      await FirebaseFirestore.instance
          .collection("serviceProvider")
          .doc(index)
          .update({"status": "disable"});
      Get.to(const MainNavBarAdmin());
      Get.snackbar("Success", "Rejected");
    } catch (e) {
      Get.snackbar("Error", "Failed to reject serviceProvider account: $e");
    }

    update();
  }

  saveChangesService(String doc) {
    serviceName = serviceType.text;
    priceperday = pricePerDay.text;
    priceperhour = pricePerHour.text;

    FirebaseFirestore.instance.collection("service").doc(doc).update({
      "name": serviceName,
      "eachDay": priceperday,
      "eachHour": priceperhour
    });
    Get.back();
    Get.snackbar("Success", "service info has been successfully updated.");
    update();
  }

  saveChanges() {
    email = emailC.text;
    name = userNameC.text;
    password = passwordC.text;

    FirebaseFirestore.instance
        .collection("Admin")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"email": email, "name": name, "password": password});
    Get.snackbar("Success", "Your info has been successfully updated.");
    update();
  }

  addService() async {
    String idService = randomAlphaNumeric(10);
    await FirebaseFirestore.instance.collection("service").doc(idService).set({
      "name": serviceType.text,
      "aboutYou": "ADMIN",
      "idService": idService,
      "nameUser": name,
      "idUser": FirebaseAuth.instance.currentUser!.uid,
      "eachHour": pricePerHour.text,
      "eachDay": pricePerDay.text,
    });
    Get.back();
    Get.snackbar("Success", "The service has been added successfully");
  }

  Future<void> getUserInfo() async {
    try {
      FirebaseFirestore.instance
          .collection("Admin")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots()
          .listen((DocumentSnapshot<Map<String, dynamic>> value) {
        if (value.exists) {
          email = value.data()!["email"].toString();
          name = value.data()!["name"].toString();
          password = value.data()!["password"].toString();
          emailC.text = email ?? "";
          userNameC.text = name ?? "";
          passwordC.text = password ?? "";
          update();
        }
      });
    } catch (e) {
      Get.snackbar("Error", "Failed to load admin information: $e");
    }
  }

  @override
  void onInit() {
    emailC = TextEditingController();
    userNameC = TextEditingController();
    passwordC = TextEditingController();
    serviceType = TextEditingController();
    pricePerDay = TextEditingController();
    pricePerHour = TextEditingController();
    getUserInfo();
    super.onInit();
  }

  @override
  void onClose() {
    emailC.dispose();
    userNameC.dispose();
    passwordC.dispose();
    serviceType.dispose();
    pricePerHour.dispose();
    pricePerDay.dispose();
    super.onClose();
  }
}
