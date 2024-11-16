// // ignore_for_file: prefer_const_constructors

// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../theme.dart';

// class MotherMessageView extends StatefulWidget {
//   const MotherMessageView({super.key});

//   @override
//   State<MotherMessageView> createState() => _MotherMessageViewState();
// }

// class _MotherMessageViewState extends State<MotherMessageView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ThemeColor.background,
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: ThemeColor.primary,
//         title: ZoomIn(
//           delay: Duration(milliseconds: 150),
//           child: Text('الدردشة',
//               style: TextStyle(color: ThemeColor.white, fontSize: 23)),
//         ),
//         toolbarHeight: 100,
//         actions: [
//           FadeInRight(
//             delay: Duration(milliseconds: 150),
//             child: IconButton(
//                 onPressed: () {
//                   Get.back();
//                 },
//                 icon: Icon(
//                   Icons.arrow_forward_ios,
//                   color: ThemeColor.white,
//                 )),
//           )
//         ],
//         automaticallyImplyLeading: false,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(25),
//               bottomRight: Radius.circular(25)),
//         ),
//       ),
//       body: Container(),
//     );
//   }
// }
