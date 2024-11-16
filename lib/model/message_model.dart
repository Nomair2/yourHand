import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String? sender;
  final String? message;
  final Timestamp? timestamp;

  const MessageModel({
    required this.sender,
    required this.message,
    required this.timestamp,
  });

  factory MessageModel.fromJson(Map<dynamic, dynamic> json) {
    return MessageModel(
      sender: json['sender'],
      message: json['message'] ?? "",
      timestamp:
          json['timestamp'] != null ? json['timestamp'] : Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
