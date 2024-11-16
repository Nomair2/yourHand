import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yourhand/view/mother_side/mother_main_bottom_bar.dart';
import 'package:yourhand/view/select_account_screen.dart';
import 'package:yourhand/view/service_provider_side/service_applier_main_bottom_bar.dart';
import 'mybinding.dart';
import 'view/logIn & signUp/mother_singUp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyC5J7YCwow4vJalDHRbi8C9dkAEWwNEDbU',
          projectId: 'yourhand-18b08',
          messagingSenderId: '317191670846',
          appId: '1:317191670846:android:e172229f3487b9e3c5556f',
          storageBucket: 'yourhand-18b08.appspot.com'));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SelectAccount(),
      initialBinding: Mybindings(),
    );
  }
}
