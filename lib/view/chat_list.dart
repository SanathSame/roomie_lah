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
  final double borderRadius = 10;
  final double margin = 5;
  final double padding = 5;
  final double iconSize = 56;
  final Color backgroundColor = Color.fromRGBO(180, 180, 180, 0.2);
  final Color green = Color.fromRGBO(0, 110, 96, 1);
  final Color pink = Color.fromRGBO(254, 179, 189, 1);


  // To Test out functionality
  List<Widget> getRandomWidgetArray(int num){

    List<Widget> widgetList = [];

    for (int i=0; i<num; ++i){
      String name = "Atul";
      String lastMessage = "Hello";
      String time = "8:00 PM";

      Widget chatPreview = new ChatPreview(name, lastMessage, time);
      widgetList.add(chatPreview);
      widgetList.add(SizedBox(height: 20));
    }

    return widgetList;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body:
      SingleChildScrollView(
        child: Column(
          children:
            getRandomWidgetArray(30),
            ),
        ),);
  }
}