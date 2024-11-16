import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yourhand/view/select_account_screen.dart';

class ProfileMotherController extends GetxController {
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxString imagePath = ''.obs;
  final imagePicker = ImagePicker();
  RxBool uploadimage = true.obs;

  late TextEditingController editFirstName;
  late TextEditingController editLastName;
  late TextEditingController editEmail;
  late TextEditingController editepassword;

  @override
  void onInit() {
    editFirstName = TextEditingController();
    editLastName = TextEditingController();
    editEmail = TextEditingController();
    editepassword = TextEditingController();
    // user = FirebaseAuth.instance.currentUser!;
    //

    getInfoUser();
  }

  Future<String> getImageUser(String collection, String id) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection(collection).doc(id).get();

    final data = doc.data() as Map<String, dynamic>;

    String image = data['image'] != null ? data['image'] : "";

    return image;
  }

  Future uploadProfilePicture(String uid, File profilePicture) async {
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref('userProfilePictures/${uid}/profilePicture.jpg');
      UploadTask uploadTask = storageReference.putFile(profilePicture);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      rethrow; // Re-throw the exception so it can be handled by the caller
    }
  }
  uploadPhoto() async {
    XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    uploadimage.value = false;
    uploadimage.refresh();
    if (pickedImage != null) {
      imagePath.value = pickedImage.path;
      imagePath.refresh();
    }
    String userId = GetStorage().read("userId");
    final file = File(pickedImage!.path);
    var downloadUrl = await uploadProfilePicture(userId, file);
    await FirebaseFirestore.instance
        .collection('mother') .doc(userId)
        .update({"image": downloadUrl});
    imagePath.value = await getImageUser("mother", userId);
    imagePath.refresh();
    uploadimage.value = true;
    uploadimage.refresh();
  }
  Future<Map<String, dynamic>> getInfoUser() async {
    String userId = GetStorage().read("userId");
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('mother').doc(userId).get();
    final data = doc.data() as Map<String, dynamic>;
    name.value = data['firstName'] + " " + data['lastName'];
    GetStorage().write('userName', name.value);
    editFirstName.text = data['firstName'];
    editLastName.text = data['lastName'];
    email.value = data['email'];
    editEmail.text = email.value;
    password.value = data['password'];
    editepassword.text = password.value;
    return data;
  }
  Future updataInfor() async {
    String userId = GetStorage().read("userId");
    await FirebaseFirestore.instance.collection('mother').doc(userId).update({
      "firstName": editFirstName.text,
      "lastName": editLastName.text,
    });
    getInfoUser();
  }
  Future logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(SelectAccount());
  }
  Future deleteAccount() async {
    String userId = GetStorage().read("userId");
    await FirebaseFirestore.instance.collection('mother').doc(userId).delete();
    await FirebaseAuth.instance.currentUser!.delete();
    Get.offAll(SelectAccount());
  }
}
