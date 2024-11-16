import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yourhand/view/select_account_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ServiceproviderProfileController extends GetxController {
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
  // late User user;

  // late Map<String, dynamic> data;

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
      // Create a reference to the location where we want to upload the file
      Reference storageReference = FirebaseStorage.instance
          .ref('userProfilePictures/${uid}/profilePicture.jpg');

      // Upload the file
      UploadTask uploadTask = storageReference.putFile(profilePicture);

      // Wait for the upload to complete

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      // Get the download URL
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

    // final storage = FirebaseStorage.instance.ref('profile_images/${userId}');

    final file = File(pickedImage!.path);
    // await storage.putFile(file);

    // var downloadUrl = storage.getDownloadURL();
    var downloadUrl = await uploadProfilePicture(userId, file);

    await FirebaseFirestore.instance
        .collection('serviceProvider')
        .doc(userId)
        .update({"image": downloadUrl});

    imagePath.value = await getImageUser("serviceProvider", userId);
    imagePath.refresh();
    uploadimage.value = true;
    uploadimage.refresh();
  }

  Future<Map<String, dynamic>> getInfoUser() async {
    String userId = GetStorage().read("userId");
    String idUser = FirebaseAuth.instance.currentUser!.uid;

    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('serviceProvider')
        .doc(idUser)
        .get();

    final data = doc.data() as Map<String, dynamic>;
    name.value = data['firstName'] + " " + data['lastName'];
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
    await FirebaseFirestore.instance
        .collection('serviceProvider')
        .doc(userId)
        .update({
      "firstName": editFirstName.text,
      "lastName": editLastName.text,
    });
    // await user.updateEmail(editEmail.text);
    // await user.updatePassword(editEmail.text);
    getInfoUser();
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(SelectAccount());
  }

  Future deleteAccount() async {
    String userId = GetStorage().read("userId");
    print(userId);
    await FirebaseAuth.instance.currentUser!.delete();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("service")
        .where("idUser", isEqualTo: userId)
        .get();
    List data = querySnapshot.docs;
    print(data.length);
    for (var i in data) {
      print(i.data());
      print(i.data()['idService']);
      FirebaseFirestore.instance
          .collection('service')
          .doc(i.data()['idService'])
          .delete();
    }
    await FirebaseFirestore.instance
        .collection('serviceProvider')
        .doc(userId)
        .delete();

    Get.offAll(SelectAccount());
  }
}
