import 'package:get/get.dart';
import 'package:yourhand/controller/serviceProvider_controller/serviceProvider_profile_controller.dart';

import 'controller/Auth_controller/login_controller.dart';
import 'controller/Auth_controller/signup_mother_controller.dart';
import 'controller/Auth_controller/signup_serviceProvider_controller.dart';

class Mybindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(LoginController(), permanent: true);
    Get.put(SignupMotherController(), permanent: true);
    Get.put(SignupServiceproviderController(), permanent: true);
    // Get.put(ServiceproviderProfileController(), permanent: true);
  }
}
