import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:random_string/random_string.dart';
import 'package:yourhand/sevices/database_methods.dart';
import 'package:yourhand/view/logIn%20&%20signUp/logIn.dart';
import 'package:yourhand/view/mother_side/mother_main_bottom_bar.dart';

class SignupMotherController extends GetxController {
  late GlobalKey<FormState> key;

  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController confirmPassword;

  @override
  void onInit() {
    key = GlobalKey<FormState>();

    firstName = TextEditingController();
    lastName = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    super.onInit();
  }

  register() async {
    if (key.currentState!.validate()) {
      try {
        UserCredential usercurrent =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );

        String idUser = FirebaseAuth.instance.currentUser!.uid;
        String idService = randomAlphaNumeric(10);
        GetStorage().write('userId', idUser);

        Map<String, dynamic> infoUser = {
          "image": '',
          "type": "mother",
          "firstName": firstName.text,
          "lastName": lastName.text,
          "email": email.text,
          "password": password.text,
          "id": idUser,
        };
        await DatabaseMethods().addMother(infoUser, idUser);
        Get.showSnackbar(const GetSnackBar(
          message: "تم أنشاء حساب الأم  ",
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM,
        ));
        Get.offAll(LogIn());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'network-request-failed') {
          Get.showSnackbar(const GetSnackBar(
            message: "خطأ الاتصال في الانترنت",
            duration: Duration(seconds: 2),
            snackPosition: SnackPosition.BOTTOM,
          ));
        } else if (e.code == 'weak-password') {
          Get.showSnackbar(const GetSnackBar(
            message: "كلمة السر صعيفة ",
            duration: Duration(seconds: 2),
            snackPosition: SnackPosition.BOTTOM,
          ));
        } else if (e.code == 'email-already-in-use') {
          Get.showSnackbar(const GetSnackBar(
            message: "الحساب موجود مسبقا ",
            duration: Duration(seconds: 2),
            snackPosition: SnackPosition.BOTTOM,
          ));
        }
      }
    }
  }
}
