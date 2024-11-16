import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourhand/controller/mother_controller/chat_Mother_controller.dart';
import 'package:yourhand/model/chat_model.dart';
import 'package:yourhand/theme.dart';
import 'ChatMotherScreen.dart';

class ChatMother extends StatefulWidget {
  const ChatMother({super.key});

  @override
  State<ChatMother> createState() => _ChatMotherState();
}

class _ChatMotherState extends State<ChatMother> {
  ChatMotherController controller = Get.put(ChatMotherController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
                          chat.nameServiceProvider,
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
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                        ),
                      ],
                    ),
                    onTap: () {
                      Get.to(ChatMotherScreen(chat: chat));
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
