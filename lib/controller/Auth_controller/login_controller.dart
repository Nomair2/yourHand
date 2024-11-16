import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yourhand/view/mother_side/mother_main_bottom_bar.dart';
import 'package:yourhand/view/service_provider_side/service_applier_main_bottom_bar.dart';

import '../../view/adminView/main_bottom_bar_admin.dart';

class LoginController extends GetxController {
  late GlobalKey<FormState> key;
  late TextEditingController email;
  late TextEditingController password;
  GetStorage getStorage = new GetStorage();

  @override
  void onInit() {
    key = GlobalKey<FormState>();

    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  Future Login() async {
    try {
      print(email.text);
      print(password.text);
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text, password: password.text)
          .then(
            (value) => null,
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("no user found for that email");
      } else if (e.code == "wrong-password") {
        print("wrong password provided for that user");
      }
    } catch (e) {
      print(e);
    }
  }

  Future checkEmail() async {
    print(1);
    await Login().then((value) {
      if (value == null) {
        print(2);
        print(FirebaseAuth.instance.currentUser!.uid);
        FirebaseFirestore.instance
            .collection("mother")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((val) {
          if (val.exists) {
            print(3);
            if (val.data()!["email"] == email.text &&
                val.data()!["password"] == password.text) {
              GetStorage().write("userId", val.data()!["id"]);
              Get.offAll(const MotherMainBottomBar());
            } else {
              Get.snackbar(
                "Faild Login",
                "Wrong password or email, please try again",
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 3),
              );
            }
          } else {
            FirebaseFirestore.instance
                .collection("serviceProvider")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .get()
                .then((val) {
              if (val.exists) {
                if (val.data()!["email"] == email.text &&
                    val.data()!["password"] == password.text) {
                  var userStatus = val.data()!["status"];
                  if (userStatus == "enable") {
                    GetStorage().write("userId", val.data()!["id"]);
                    Get.offAll(const MainBottomBar());
                  } else {
                    Get.snackbar("Alert", "Your account is not activated yet");
                  }
                } else {
                  Get.snackbar(
                    "Faild Login",
                    "Wrong password or email, please try again",
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 3),
                  );
                }
              } else {
                FirebaseFirestore.instance
                    .collection("Admin")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get()
                    .then((val) {
                  if (val.exists) {
                    if (val.data()!["email"] == email.text &&
                        val.data()!["password"] == password.text) {
                      GetStorage().write("userId", val.data()!["id"]);
                      Get.offAll(const MainNavBarAdmin());
                    } else {
                      Get.snackbar(
                        "Faild Login",
                        "Wrong password or email, please try again",
                        snackPosition: SnackPosition.BOTTOM,
                        duration: const Duration(seconds: 3),
                      );
                    }
                  } else {
                    Get.snackbar(
                      "Faild Login",
                      "User Not Found",
                      snackPosition: SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 1),
                    );
                  }
                });
              }
            });
          }
        });
      }
    });
  }
}
