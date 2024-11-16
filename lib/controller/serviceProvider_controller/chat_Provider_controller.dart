import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChatProviderController extends GetxController {
  final TextEditingController text = TextEditingController();
  RxString idChat = ''.obs;

  Stream<QuerySnapshot<Map<String, dynamic>>> getChats() {
    return FirebaseFirestore.instance
        .collection("chat")
        .where("idServiceProvider",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
      'sender': 'serviceProvider',
      'message': text.text,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
