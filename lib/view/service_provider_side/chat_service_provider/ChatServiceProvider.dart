import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourhand/controller/serviceProvider_controller/chat_Provider_controller.dart';
import 'package:yourhand/model/chat_model.dart';
import 'package:yourhand/theme.dart';
import 'package:yourhand/view/service_provider_side/service_applier_homePage/chatServiceApplierScreen.dart';

class Chatserviceprovider extends StatefulWidget {
  const Chatserviceprovider({super.key});

  @override
  State<Chatserviceprovider> createState() => _ChatserviceproviderState();
}

class _ChatserviceproviderState extends State<Chatserviceprovider> {

  @override
  Widget build(BuildContext context) {
    Get.put(ChatProviderController());
    return Scaffold(
      backgroundColor: ThemeColor.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeColor.primary,
        title: ZoomIn(
          delay: Duration(milliseconds: 150),
          child: Text('رسائل',
              style: TextStyle(color: ThemeColor.white, fontSize: 23)),
        ),
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: GetBuilder<ChatProviderController>(builder: (controller)=>
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: controller.getChats(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    ChatModel chat = ChatModel.fromJson(
                        snapshot.data?.docs[index].data() as Map<String, dynamic>);
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              chat.nameMother,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(width: 20),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: chat.imageServiceProvider.isEmpty ||
                                        chat.imageServiceProvider == ''
                                        ? AssetImage("assets/img/profilePic.png")
                                        : NetworkImage(chat.imageServiceProvider),
                                  ),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                            ),
                          ],
                        ),
                        onTap: () {
                          Get.to(ChatScreen(chat: chat));
                        },
                      ),
                    );
                  },
                );
              },
            ),
        )
      ),
    );
  }
}
// Container(
//               height: MediaQuery.of(context).size.height * 0.1,
//               child: ListTile(
//                 title: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text(
//                       "رانيا",
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                     ),
//                     SizedBox(width: 20),
//                     Container(
//                       height: 50,
//                       width: 50,
//                       decoration: BoxDecoration(
//                           image: DecorationImage(
//                               image: AssetImage(
//                                 "assets/img/profilePic.png",
//                               ),
//                               fit: BoxFit.cover),
//                           borderRadius: BorderRadius.all(Radius.circular(50))),
//                     ),
//                   ],
//                 ),
//                 onTap: () {
//                   Get.to(ChatScreen());
//                 },
//               ),
//             );