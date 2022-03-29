import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomCtrller{
  static CollectionReference chatRoomCollection =
  FirebaseFirestore.instance.collection('ChatRoom');

  Future<void> addChatRoom(chatRoom, chatRoomId) async{
    chatRoomCollection.doc(chatRoomId)
        .set(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  getChats(String chatRoomId) async{
    return chatRoomCollection.doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  Future<void> addMessage(String chatRoomId, chatMessageData) async{

    chatRoomCollection
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData).catchError((e){
      print(e.toString());
    });
  }

  checkSnapshot(String chatRoomId) async{
    return chatRoomCollection
        .doc(chatRoomId)
        .get();
  }
}
