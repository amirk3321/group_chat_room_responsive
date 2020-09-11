import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:flutter/foundation.dart';
import 'package:group_chat_room_responsive/domain/entities/text_message_entity.dart';

class TextMessageModel extends TextMessageEntity {
  TextMessageModel({String recipientId, String senderId, String senderName,
      String type="TEXT", Timestamp time, String message, String receiverName})
      : super(recipientId, senderId, senderName, type, time, message, receiverName);

  factory TextMessageModel.fromJson(Map<String,dynamic> json){
    return TextMessageModel(
      recipientId: json['recipientId'],
      message:json['message'],
      time: json['time'],
      receiverName:json['receiverName'],
      senderId:json['senderId'],
      senderName:json['senderName'],
      type:json['type'],
    );
  }

  factory TextMessageModel.fromSnapshot(DocumentSnapshot documentSnapshot){
    return TextMessageModel(
      time: documentSnapshot.data()['time'],
      message:documentSnapshot.data()['message'],
      receiverName: documentSnapshot.data()['receiverName'],
      recipientId: documentSnapshot.data()['recipientId'],
      senderId:documentSnapshot.data()['senderId'],
      senderName:documentSnapshot.data()['senderName'],
      type:documentSnapshot.data()['type'],
    );
  }

  Map<String,dynamic> toDocument(){
    return {
      "recipientId":recipientId,
      "senderId":senderId,
      "senderName":senderName,
      "type":type,
      "time":time,
      "message":message,
      "receiverName":receiverName
    };
  }
}
