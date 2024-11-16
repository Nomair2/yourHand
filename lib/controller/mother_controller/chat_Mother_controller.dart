import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChatMotherController extends GetxController {
  final TextEditingController text = TextEditingController();
  // late Rx<Stream<QuerySnapshot<Map<String, dynamic>>>> stream = ;
  // late Rx<AsyncSnapshot<QuerySnapshot<Object?>>> snapshot = ().obs;
  RxString idChat = ''.obs;

  Stream<QuerySnapshot<Map<String, dynamic>>> getChats() {
    var idUser = GetStorage().read('userId');
    return FirebaseFirestore.instance
        .collection("chat")
        .where("idMother", isEqualTo: idUser)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages() {
    return FirebaseFirestore.instance
        .collection('chat')
        .doc(idChat.value)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
    //  return stream.value;
  }

  sendMessage(String idChat) async {
    await FirebaseFirestore.instance
        .collection('chat')
        .doc(idChat)
        .collection('messages')
        .add({
      'sender': 'mother',
      'message': text.text,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
