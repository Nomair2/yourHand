import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourhand/function/validUser.dart';

class DatabaseMethods {
  FirebaseFirestore db = FirebaseFirestore.instance;
  Future addMother(Map<String, dynamic> infoMother, String id) async {
    return await FirebaseFirestore.instance
        .collection("mother")
        .doc(id)
        .set(infoMother);
  }

  Future addServiceProvider(
      Map<String, dynamic> infoSreviceProvider, String id) async {
    return await FirebaseFirestore.instance
        .collection("serviceProvider")
        .doc(id)
        .set(infoSreviceProvider);
  }

  Future addService(Map<String, dynamic> infoService, String id) async {
    await FirebaseFirestore.instance
        .collection("service")
        .doc(id)
        .set(infoService);
  }

  Future addOrder(Map<String, dynamic> inforOrder, String id) async {
    await FirebaseFirestore.instance
        .collection("order")
        .doc(id)
        .set(inforOrder);
  }


  Future addChat(Map<String, dynamic> infoChat, String id) async {
    await FirebaseFirestore.instance.collection("chat").doc(id).set(infoChat);
  }
}
