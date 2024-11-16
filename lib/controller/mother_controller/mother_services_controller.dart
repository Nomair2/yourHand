import 'package:get/get.dart';
import 'package:yourhand/function/validUser.dart';
import 'package:yourhand/model/service_provider_model.dart';

class MotherServicesController extends GetxController {
  RxString nameService = ''.obs;
  late RxList services = [].obs;
  late RxList services0 = [].obs;
  RxBool loading = true.obs;
  RxBool loadingServices = true.obs;

  @override
  void onInit() {
    getService();
    super.onInit();
  }

  getService() async {
    loadingServices.value = true;
    print("3");
    Set set = await getServices();
    for (var i in set) {
      services0.add(i);
    }
    loadingServices.value = false;
    loadingServices.refresh();
  }

  getServicer(String name) async {
    print("2");
    loading.value = false;
    services.value = await GetServicesByNameService(name);
    for (var i in services) {}
    loading.value = true;
    loading.refresh();
  }
}
