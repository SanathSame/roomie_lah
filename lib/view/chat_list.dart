import 'package:flutter/material.dart';
import 'package:roomie_lah/widgets/chat_preview.dart';



void main() => runApp(
  MaterialApp(
    title: 'Diabetes App',
    home: ChatListPage(),
    theme: ThemeData(
      // Define the default brightness and colors.
      primaryColor: Colors.teal.shade800,
      backgroundColor: Colors.pink.shade100,

      // Define the default font family.
      fontFamily: 'Roboto',

      // Define the default TextTheme. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: TextTheme(
          headline3: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black),
          headline4: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade800),
          headline5: TextStyle(fontSize: 40, color: Colors.teal.shade800),
          headline6: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black)),
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
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body:
      SingleChildScrollView(
        child: Column(
          children:
            getRandomWidgetArray(30, height),
            ),
        ),);
  }
}