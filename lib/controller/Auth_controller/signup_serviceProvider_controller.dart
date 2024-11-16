import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:random_string/random_string.dart';
import 'package:yourhand/function/validUser.dart';
import 'package:yourhand/sevices/database_methods.dart';
import 'package:yourhand/view/logIn%20&%20signUp/logIn.dart';
import 'package:yourhand/view/logIn%20&%20signUp/service_applier_info.dart';

class SignupServiceproviderController extends GetxController {
  late GlobalKey<FormState> key;
  late GlobalKey<FormState> key2;

  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController confirmPassword;

  late TextEditingController aboutYou;
  var serviceName = ''.obs;
  late RxList<String> services0 = <String>[].obs;
  getService() async {
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
    key = GlobalKey<FormState>();
    key2 = GlobalKey<FormState>();

    firstName = TextEditingController();
    lastName = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();

    aboutYou = TextEditingController();
    getService();
    super.onInit();
  }

  register() {
    if (key.currentState!.validate()) {
      Get.to(ServiceApplierInfo());
    }
  }

  register2() async {
    if (key2.currentState!.validate()) {
      try {
        UserCredential usercurrent =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        String idUser = FirebaseAuth.instance.currentUser!.uid;
        String idService = randomAlphaNumeric(10);
        GetStorage().write('userId', idUser);
        GetStorage().write('userName', "${firstName.text} ${lastName.text} ");

        Map<String, dynamic> infoUser = {
          "image": '',
          "type": "serviceProvider",
          "firstName": firstName.text,
          "lastName": lastName.text,
          "email": email.text,
          "password": password.text,
          "aboutyou": aboutYou.text,
          "serviceName": serviceName.value,
          "id": idUser,
          "status": "pending"
        };
        Map<String, dynamic> infoService = {
          "name": serviceName.value,
          "aboutYou": aboutYou.text,
          "idService": idService,
          "nameUser": "${firstName.text} ${lastName.text} ",
          "idUser": idUser,
          "eachHour": "15",
          "eachDay": "100",
        };
        await DatabaseMethods().addServiceProvider(infoUser, idUser);
        await DatabaseMethods().addService(infoService, idService);

        Get.showSnackbar(const GetSnackBar(
          message: "تم أنشاء حساب مقدم الخدمة ",
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM,
        ));
        Get.off(LogIn());
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
