import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourhand/controller/admin_Controller/adminController.dart';
import 'package:yourhand/model/order_model.dart';
import 'package:yourhand/model/service_provider_model.dart';

Future<bool> ValidUser(email, collection) async {
  bool inCollection = false;
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection(collection).get();
  List data = querySnapshot.docs;
  for (var item in data) {
    if (item["email"] == email) {
      inCollection = true;
      break;
    }
  }
  return inCollection;
}

Future<bool> ServiceAvailable(idUser, nameService) async {
  bool inCollection = false;

  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection("service").get();

  List data = querySnapshot.docs;

  for (var item in data) {
    if (item['name'] == nameService) {
      inCollection = true;
      break;
    }
  }

  return inCollection;
}

Future<List<ServiceInfoModel>> GetServicesByUserid(idUser, collection) async {
  List<ServiceInfoModel> myservices = [];

  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection(collection).get();

  List data = querySnapshot.docs;

  for (var i in data) {}
  data.removeWhere(
    (element) {
      return element.data()['idUser'] != idUser;
    },
  );
  for (var i in data) {}

  myservices.addAll(data.map((doc) => ServiceInfoModel.fromJson(doc.data())));

  return myservices;
}

Future<Set> getServices() async {
  print("4");
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection("service").get();
  List data = querySnapshot.docs;
  Set set = {};
  for (var i in data) {
    print(i.data()['name']);
    set.add(i.data()['name']);
  }
  return set;
}

Future<List<ServiceInfoModel>> GetServicesByNameService(nameService) async {
  List<ServiceInfoModel> myservices = [];

  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('service')
      .where("nameUser", isNotEqualTo: "Admin")
      .get();

  List data = querySnapshot.docs;

  data.removeWhere(
    (element) {
      return element.data()['name'] != nameService;
    },
  );

  myservices.addAll(data.map((doc) => ServiceInfoModel.fromJson(doc.data())));

  return myservices;
}

Future<List<ServiceInfoModel>> GetServiceByUsername(userName) async {
  List<ServiceInfoModel> myservices = [];

  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('service').get();

  List data = querySnapshot.docs;

  data.removeWhere(
    (element) {
      return element.data()['name'] != userName;
    },
  );

  myservices.addAll(data.map((doc) => ServiceInfoModel.fromJson(doc.data())));

  return myservices;
}

Future<QueryDocumentSnapshot?> FindUser(email, collection) async {
  var user;
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection(collection).get();
  List<QueryDocumentSnapshot> data = querySnapshot.docs;
  for (var item in data) {
    if (item["email"] == email) {
      return item;
    }
  }
}

Future<bool?> FindChat(idmother, iduser) async {
  bool exist;
  QuerySnapshot data = await FirebaseFirestore.instance
      .collection("chat")
      .where("idMother", isEqualTo: idmother)
      .where("idServiceProvider", isEqualTo: iduser)
      .get();
  print(data.docs.length);
  print('are there chat before ');
  exist = data.docs.length == 1 ? true : false;
  data.docs.length == 1 ? print("yes") : print("no ");
  return exist;
}

Future<QueryDocumentSnapshot?> FindServices(name) async {
  var user;
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('service').get();
  List<QueryDocumentSnapshot> data = querySnapshot.docs;
  for (var item in data) {
    if (item["name"] == name) {
      return item;
    }
  }
}

Future<List<OrderModel>> GetOrdersByService(nameService, iduser) async {
  List<OrderModel> myservices = [];

  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('order')
      .where("nameService", isEqualTo: nameService)
      .get();

  List data = querySnapshot.docs;

  for (var i in data) {}
  data.removeWhere(
    (element) {
      return element.data()['idServiceProvider'] != iduser;
    },
  );
  for (var i in data) {}

  myservices.addAll(data.map((doc) => OrderModel.fromMap(doc.data())));

  return myservices;
}

Future<List<OrderModel>> GetOrdersByUserid(idUser) async {
  List<OrderModel> myservices = [];

  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('order')
      .where("status", isEqualTo: "incoming")
      .get();

  List data = querySnapshot.docs;

  data.removeWhere(
    (element) {
      return element.data()['idUser'] != idUser;
    },
  );

  myservices.addAll(data.map((doc) => OrderModel.fromMap(doc.data())));

  return myservices;
}

Future<List<OrderModel>> GetOrdersByServiceProviderid(idServiceProvider) async {
  List<OrderModel> myservices = [];

  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('order').get();

  List data = querySnapshot.docs;

  for (var i in data) {}
  data.removeWhere(
    (element) {
      return element.data()['idServiceProvider'] != idServiceProvider;
    },
  );
  for (var i in data) {}

  myservices.addAll(data.map((doc) => OrderModel.fromMap(doc.data())));

  return myservices;
}
