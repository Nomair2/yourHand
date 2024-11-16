import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourhand/view/logIn%20&%20signUp/logIn.dart';

class ForgetPasswordController extends GetxController {
  late GlobalKey<FormState> key;
  late TextEditingController email;

  @override
  void onInit() {
    key = GlobalKey<FormState>();
    email = TextEditingController();
    super.onInit();
  }

  forgetPassword() async {
    if (key.currentState!.validate()) {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);

      Get.showSnackbar(const GetSnackBar(
        message: "تم ارسال رابط انشاء كلمة مرور جدبدة الى بريدك الاكتروني",
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      ));
      await Future.delayed(Duration(seconds: 2));
      Get.off(LogIn());
    }
  }
}
