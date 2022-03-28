import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:roomie_lah/controllers/MatchController.dart';
import 'package:roomie_lah/entity/CurrentUser.dart';
import 'package:roomie_lah/widgets/ChatAppBar.dart';
import 'package:roomie_lah/constants.dart';
import 'package:roomie_lah/controllers/chatRoomCtrller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'RoomieLah',
    home: ConversationScreen(
      chatWithUsername: "atul",
      profilePicURL: "",
    ),
    theme: ThemeData(
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: Color(0xff656865),
    ),
  ));
}

class ConversationScreen extends StatefulWidget {
  static String id = "conversation_screen";
  final currentUsername = CurrentUser().username;
  final String chatWithUsername;
  final String profilePicURL;
  ConversationScreen(
      {required this.chatWithUsername, required this.profilePicURL});
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

Widget messageList(msgList) {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    itemCount: msgList.length,
    itemBuilder: (context, index) {
      String message = msgList[index]["message"];
      bool sendByMe = msgList[index]["sendByMe"];
      return MessageTile(message: message, sendByMe: sendByMe);
    },
    shrinkWrap: true,
  );
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({required this.message, required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            top: 8,
            bottom: 8,
            left: sendByMe ? 0 : 24,
            right: sendByMe ? 24 : 0),
        alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin:
              sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
          padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
          decoration: BoxDecoration(
              borderRadius: sendByMe
                  ? BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                      bottomLeft: Radius.circular(23))
                  : BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                      bottomRight: Radius.circular(23)),
              gradient: LinearGradient(
                colors: sendByMe
                    ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                    : [const Color(0xCD908D8D), const Color(0xADA8A4A4)],
              )),
          child: Text(
            message,
            textAlign: TextAlign.start,
            style: kMediumText,
          ),
        ));
  }
}

class _ConversationScreenState extends State<ConversationScreen> {
  final TextEditingController messageController = new TextEditingController();
  final ChatRoomCtrller chatRoomCtrller = new ChatRoomCtrller();
  //List<Map<String, dynamic>> msgs = [];
  Stream<QuerySnapshot> chats = new Stream.empty();

  String getChatRoomID() {
    String currentUsername = widget.currentUsername;
    String chatWithUsername = widget.chatWithUsername;
    if (currentUsername.compareTo(chatWithUsername) < 0) {
      return widget.currentUsername + "_" + widget.chatWithUsername;
    } else {
      return widget.chatWithUsername + "_" + widget.currentUsername;
    }
  }

  @override
  void initState() {
    // setState(() {
    //   msgs.add({"message": "Hi! Hasbulla here", "sendByMe": false});
    //   msgs.add({"message": "I need some urgent money", "sendByMe": false});
    //
    // });
    String chatRoomID = getChatRoomID();
    print(chatRoomID);

    chatRoomCtrller.checkSnapshot(chatRoomID).then((val) {
      var snap = val;
      Map<String, dynamic> chatRoom = {
        "chatRoomId": chatRoomID,
      };
      if (snap == null || !snap.exists) {
        print("Snap is null");
        chatRoomCtrller.addChatRoom(chatRoom, chatRoomID);
      }
    });

    chatRoomCtrller.getChats(chatRoomID).then((val) {
      setState(() {
        chats = val;
      });
    });

    super.initState();
  }

  void addMessage() {
    if (this.messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": widget.currentUsername,
        "message": this.messageController.text,
        'time': DateTime.now(),
        //.millisecondsSinceEpoch,
      };

      String chatRoomID = getChatRoomID();
      chatRoomCtrller.addMessage(chatRoomID, chatMessageMap);
      MatchController().updateLastMessage(CurrentUser().username,
          widget.chatWithUsername, this.messageController.text, DateTime.now());
      setState(() {
        // msgs.add({"message": this.messageController.text, "sendByMe": true});
        messageController.text = "";
      });
    }
  }

  Widget messageBox([Color textColor = Colors.white, textController]) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            color: Color(0x54FFFFFF),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: kMediumText,
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: "Message ...",
                      hintStyle: kMediumText,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("Send message ... ");
                    addMessage();
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              const Color(0x36FFFFFF),
                              const Color(0x0FFFFFFF)
                            ],
                            begin: FractionalOffset.topLeft,
                            end: FractionalOffset.bottomRight),
                        borderRadius: BorderRadius.circular(40)),
                    padding: EdgeInsets.all(12),
                    child: widget.profilePicURL == ""
                        ? Image.asset(
                            "assets/images/send.png",
                            height: 25,
                            width: 25,
                          )
                        : Image.network(
                            widget.profilePicURL,
                            height: 25,
                            width: 25,
                          ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        print(snapshot.data);
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                    message: snapshot.data!.docs[index]["message"],
                    sendByMe: widget.currentUsername ==
                        snapshot.data!.docs[index]["sendBy"],
                  );
                })
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Map temp = ModalRoute.of(context)?.settings.arguments as Map;
    // String currentUser = temp['currentUsername'];
    // String chatWith = temp['chatWith'];
    // String profilePic = temp['profilePic'];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height * 0.075, // 10% of the height
        ),
        child: ChatAppBar(
            context,
            widget.chatWithUsername,
            widget.profilePicURL == ""
                ? Image.asset('assets/images/hasbullah.jpg', height: 50)
                : Image.network(widget.profilePicURL)),
      ),
      body: Container(
        color: Color(0xff656865),
        child: Column(
          children: [
            Expanded(child: chatMessages()),
            Container(
                alignment: Alignment.bottomCenter,
                child: messageBox(Colors.white, messageController)),
          ],
        ),
      ),
    );
  }
}
