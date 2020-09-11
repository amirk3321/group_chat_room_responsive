

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TextMessageEntity extends Equatable{
  final String recipientId;
  final String senderId;
  final String senderName;
  final String type;
  final Timestamp time;
  final String message;
  final String receiverName;

  TextMessageEntity(this.recipientId, this.senderId, this.senderName, this.type, this.time, this.message, this.receiverName);

  @override
  // TODO: implement props
  List<Object> get props => [recipientId, senderId, senderName, type, time, message, receiverName];

}