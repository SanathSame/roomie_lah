import 'package:flutter/material.dart';
import 'package:roomie_lah/controllers/MatchController.dart';
import 'package:roomie_lah/widgets/chat_preview.dart';
import 'package:roomie_lah/widgets/AppBar.dart';
import 'package:roomie_lah/constants.dart';
import 'package:roomie_lah/widgets/NavBar.dart';
import 'package:roomie_lah/screens/ConversationScreen.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'RoomieLah',
    home: ChatListPage(),
    theme: ThemeData(
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: Colors.white,
    ),
  ));
}

class ChatListBody extends StatefulWidget {
  static String id = "chat_list_screen";

  @override
  createState() {
    return new ChatListBodyState();
  }
}

class ChatListBodyState extends State<ChatListBody> {
  // To Test out functionality
  Future<List<Widget>> buildMatches(height) async {
    List<Widget> widgetList = [];

    MatchController matchController = new MatchController();
    // matchController.addMatch('user1', 'user2');
    // matchController.addMatch('user1', 'user3');
    // matchController.addMatch('user2', 'user4');
    // matchController.addMatch('user1', 'user4');
    // matchController.deleteMatch('user2', 'user4');
    await matchController.addMatch('user9', 'user10');
    var listOfMatches = await matchController.listMatches('user10');

    for (int i = 0; i < listOfMatches.length; ++i) {
      String name = listOfMatches[i];
      String lastMessage = "Hello00000000000000000000000000000000000";
      String time = "8:00 PM";
      Widget chatPreview = new InkWell(
        onTap: () {
          Navigator.pushNamed(context, ConversationScreen.id);
          // MatchController matchController = new MatchController();
          // // matchController.listMatches();
        },
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

    return FutureBuilder<List<Widget>>(
        future: buildMatches(height),
        builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
          Widget child;

          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null && snapshot.requireData.length > 0) {
              child = Column(
                children: snapshot.requireData,
              );
            } else {
              child = Text("No Matches");
            }
          } else if (snapshot.hasError) {
            child = Column(
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ],
            );
          } else {
            child = Column(children: [
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
            ]);
          }
          return child;
        });
  }
}

class ChatListPage extends StatelessWidget {
  static String id = "chat_list";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: "Chat",
        key: UniqueKey(),
      ),
      body: SingleChildScrollView(child: ChatListBody()),
      bottomNavigationBar: BasicBottomNavBar(),
    );
  }
}
