import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:roomie_lah/controllers/MatchController.dart';
import 'package:roomie_lah/entity/ChatPreviewList.dart';
import 'package:roomie_lah/entity/CurrentUser.dart';
import 'package:roomie_lah/entity/Matches.dart';
import 'package:roomie_lah/widgets/Drawer.dart';
import 'package:roomie_lah/widgets/chat_preview.dart';
import 'package:roomie_lah/widgets/AppBar.dart';
import 'package:roomie_lah/constants.dart';
import 'package:roomie_lah/widgets/NavBar.dart';
import 'package:roomie_lah/screens/ConversationScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:roomie_lah/controllers/ProfilePicController.dart';
import 'package:async/async.dart';
import 'package:intl/intl.dart';
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
  List<Widget> buildMatches(double height, listOfMatches) {
    List<Widget> widgetList = [];

    print(listOfMatches);
    if (listOfMatches == null) return [];
    var matches = listOfMatches['matches'];
    Matches().matches = matches;

    // Sort based on time... Might need to reverse the order
    matches.sort((a, b) =>
        (b['timestamp'] as DateTime).compareTo(a['timestamp'] as DateTime));

    DateFormat formatter = DateFormat('MM-dd hh:mm');

    for (int i = 0; i < Matches().matches!.length; ++i) {
      var name = matches[i]['username'];
      var lastMessage = matches[i]['lastMessage'];
      var time = formatter.format(matches[i]['timestamp'] as DateTime);
      var profilePic = matches[i]["profilePicURL"];
      Widget chatPreview = new InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConversationScreen(
                  chatWithUsername: name, profilePicURL: profilePic),
            ),
          );
        },
        child: ChatPreview(name, lastMessage, time, profilePic),
      );
      widgetList.add(chatPreview);
      widgetList.add(SizedBox(height: 0.015 * height));
    }
    print(widgetList.length);
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return StreamBuilder(
        stream: MatchController.matches.doc(CurrentUser().username).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              print(snapshot.data?.data());
              return Column(
                children: buildMatches(height, snapshot.data?.data()),
              );
            } else {
              return Text("No matches");
            }
          }
          if (snapshot.hasError) {
            Column(
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
          }
          return Container();
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
      endDrawer: CustomDrawer(),
      body: SingleChildScrollView(child: ChatListBody()),
      bottomNavigationBar: BasicBottomNavBar(),
    );
  }
}

/*

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
              print(snapshot.data);
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
*/
