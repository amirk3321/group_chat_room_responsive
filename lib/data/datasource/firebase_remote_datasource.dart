import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:group_chat_room_responsive/data/model/text_message_model.dart';
import 'package:group_chat_room_responsive/data/model/user_model.dart';
import 'package:group_chat_room_responsive/domain/entities/text_message_entity.dart';

abstract class FirebaseRemoteDataSource {
  Future<void> signUp(String email, String password);

  Future<void> signIn(String email, String password);

  Future<void> signOut();
  
  Future<bool> isSignIn();

  Future<String> getCurrentUid();

  Future<void> getCreateCurrentUser(
      String email, String name, String profileUrl);

  Future<void> sendTextMessage(TextMessageEntity textMessage);

  Stream<List<UserModel>> getUsers();

  Stream<List<TextMessageModel>> getMessages();
}

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _userCollection = FirebaseFirestore.instance.collection("users");
  final _globalChatChannelCollection =
      FirebaseFirestore.instance.collection("globalChatChannel");

  final String channelId = "8ghYhb9YN58qQeSBy2MG";

  @override
  Future<String> getCurrentUid() async => _auth.currentUser.uid;

  @override
  Future<bool> isSignIn() async => _auth.currentUser.uid != null;

  @override
  Future<void> signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signUp(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> getCreateCurrentUser(
      String email, String name, String profileUrl) async {
    _userCollection.doc(_auth.currentUser.uid).get().then((user) {
      if (!user.exists) {
        final newUser = UserModel(
          name: name,
          email: email,
          uid: _auth.currentUser.uid,
          profileUrl: profileUrl,
        ).toDocument();
        _userCollection.doc(_auth.currentUser.uid).set(newUser);
        return;
      } else {
        print("User Already exists");
        return;
      }
    });
  }

  @override
  Stream<List<TextMessageModel>> getMessages() {
    return _globalChatChannelCollection
        .doc(channelId)
        .collection("messages")
        .orderBy("time")
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((docSnapshot) => TextMessageModel.fromSnapshot(docSnapshot))
            .toList());
  }

  @override
  Stream<List<UserModel>> getUsers() {
    return _userCollection.snapshots().map(
          (querySnapShot) => querySnapShot.docs
              .map((docSnapshot) => UserModel.fromSnapshot(docSnapshot))
              .toList(),
        );
  }

  @override
  Future<void> sendTextMessage(TextMessageEntity textMessage) async {
    final newMessage = TextMessageModel(
      message: textMessage.message,
      recipientId: textMessage.recipientId,
      time: textMessage.time,
      receiverName: textMessage.receiverName,
      senderId: textMessage.senderId,
      senderName: textMessage.senderName,
      type: textMessage.type,
    );
    _globalChatChannelCollection
        .doc(channelId)
        .collection("messages")
        .add(newMessage.toDocument());
  }

  @override
  Future<void> signOut() async{
    await _auth.signOut();
  }
  
}
