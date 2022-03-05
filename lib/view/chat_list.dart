import 'package:flutter/material.dart';
import 'package:roomie_lah/widgets/chat_preview.dart';
import 'package:roomie_lah/widgets/AppBar.dart';
import 'package:roomie_lah/constants.dart';



void main() => runApp(
  MaterialApp(
    title: 'RoomieLah',
    home: ChatListPage(),
    theme: ThemeData(
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: Colors.white,
    ),
  ),
);


class ChatListPage extends StatefulWidget {
  @override
  createState() {
    return new ChatListPageState();
  }
}

class ChatListPageState extends State<ChatListPage> {

  // To Test out functionality
  List<Widget> getRandomWidgetArray(int num, height){

    List<Widget> widgetList = [];

    for (int i=0; i<num; ++i){
      String name = "Atul";
      String lastMessage = "Hello00000000000000000000000000000000000";
      String time = "8:00 PM";

      Widget chatPreview = new InkWell(
        onTap: (){},
        child: ChatPreview(name, lastMessage, time),
      );
      widgetList.add(chatPreview);
      widgetList.add(SizedBox(height: 0.015 * height));
    }

    return widgetList;
  }

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height * 0.1, // 10% of the height
        ),
        child: appBar(title: "Chat"
        ),
      ),
      body:
      SingleChildScrollView(
        child: Column(
          children:
            getRandomWidgetArray(10, height),
            ),
        ),);
  }
}