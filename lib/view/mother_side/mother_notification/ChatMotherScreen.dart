import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourhand/controller/mother_controller/chat_Mother_controller.dart';
import 'package:yourhand/model/chat_model.dart';
import 'package:yourhand/model/message_model.dart';
import 'package:yourhand/theme.dart';

class ChatMotherScreen extends StatefulWidget {
  ChatMotherScreen({super.key, required this.chat});
  ChatModel chat;

  @override
  State<ChatMotherScreen> createState() => _ChatMotherScreenState();
}

class _ChatMotherScreenState extends State<ChatMotherScreen> {
  ChatMotherController controller = Get.find<ChatMotherController>();

  @override
  Widget build(BuildContext context) {
    controller.idChat.value = widget.chat.idChat;
    return Scaffold(
      backgroundColor: ThemeColor.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeColor.primary,
        title: ZoomIn(
          delay: Duration(milliseconds: 150),
          child: Text(widget.chat.nameServiceProvider,
              style: TextStyle(color: ThemeColor.white, fontSize: 23)),
        ),
        actions: [
          Container(
            height: 50,
            width: 50,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: widget.chat.imageServiceProvider.isEmpty ||
                            widget.chat.imageServiceProvider == ''
                        ? AssetImage("assets/img/profilePic.png")
                        : NetworkImage(widget.chat.imageServiceProvider),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.all(Radius.circular(50))),
          ),
        ],
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: controller.getMessages(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 10, right: 10),
                    child: ListView.builder(
                      reverse: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        MessageModel message = MessageModel.fromJson(
                            snapshot.data!.docs[index].data()
                                as Map<dynamic, dynamic>);

                        return Padding(
                            padding: EdgeInsets.only(
                                bottom: 10, right: 10, left: 10),
                            child: MessageBubble(message: message));
                      },
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Container();
                }
              },
            )),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.text,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      if (controller.text.text.isNotEmpty) {
                        controller.sendMessage(widget.chat.idChat);
                        controller.text.clear();
                        setState(() {});
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final MessageModel message;

  const MessageBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Row(
          textDirection: message.sender == 'mother'
              ? TextDirection.rtl
              : TextDirection.ltr,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              decoration: BoxDecoration(
                color: message.sender == 'mother'
                    ? ThemeColor.primary
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(30.0),
                // Add a tail to the message bubbles
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(message.message ?? ""),
            ),
          ]);
    });
  }
}

class Message {
  final String sender;
  final String text;
  final bool isMe;

  const Message({required this.sender, required this.text, required this.isMe});
}
