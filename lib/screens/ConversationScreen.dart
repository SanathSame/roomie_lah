import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:roomie_lah/widgets/ChatAppBar.dart';
import 'package:roomie_lah/constants.dart';

void main() => runApp(MaterialApp(
      title: 'RoomieLah',
      home: ConversationScreen(),
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Color(0xff656865),
      ),
    ));

class ConversationScreen extends StatefulWidget {
  static String id = "conversation_screen";

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
  List<Map<String, dynamic>> msgs = [];

  @override
  void initState() {
    setState(() {
      msgs.add({"message": "Hi! Hasbulla here", "sendByMe": false});
      msgs.add({"message": "I need some urgent money", "sendByMe": false});
    });
    super.initState();
  }

  void addMessgae() {
    setState(() {
      msgs.add({"message": this.messageController.text, "sendByMe": true});
      messageController.text = "";
    });
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
                    this.addMessgae();
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
                      child: Image.asset(
                        "assets/images/send.png",
                        height: 25,
                        width: 25,
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height * 0.075, // 10% of the height
        ),
        child: ChatAppBar(context),
      ),
      body: Container(
          color: Color(0xff656865),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: messageList(this.msgs),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                    child: messageBox(Colors.white, messageController)),
              ),
            ],
          )),
    );
  }
}
