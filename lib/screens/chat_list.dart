import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:roomie_lah/controllers/MatchController.dart';
import 'package:roomie_lah/widgets/Drawer.dart';
import 'package:roomie_lah/widgets/chat_preview.dart';
import 'package:roomie_lah/widgets/AppBar.dart';
import 'package:roomie_lah/constants.dart';
import 'package:roomie_lah/widgets/NavBar.dart';
import 'package:roomie_lah/screens/ConversationScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:roomie_lah/controllers/ProfilePicController.dart';
import 'package:async/async.dart';
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
  Future<List<dynamic>> buildProfilePic(List<String> matches) async {
    var users = ["kanye.jpeg", "kanye"];
    List<dynamic> imageURLS = List.filled(matches.length, "");
    imageURLS = List.filled(matches.length, "");
    print('Before Futures');
    print(imageURLS);

    FutureGroup futureGroup = FutureGroup();
    ProfilePicController profilePicController = new ProfilePicController();
    for (int i = 0; i < matches.length; ++i) {
      print("Starting future : $i");
      futureGroup.add(profilePicController.downloadURL(users[i % 2]));
    }
    //print("Num threads: $futureGroup");
    print("Waiting for futures");
    print("URLS: $imageURLS");
    futureGroup.close();
    await futureGroup.future.then((value) => {print(value), imageURLS = value});
    print("Futures Done... Got URLS");
    print(imageURLS);
    return imageURLS;
  }

  Future<List<Widget>> buildMatches(double height) async {
    List<Widget> widgetList = [];
    var listOfMatches = await MatchController().listMatches('user9');

    var profilePicURLs = await buildProfilePic(listOfMatches);

    print(profilePicURLs);
    for (int i = 0; i < listOfMatches.length; ++i) {
      String name = listOfMatches[i];
      String lastMessage = "Hello00000000000000000000000000000000000";
      String time = "8:00 PM";
      Widget chatPreview = new InkWell(
        onTap: () async {
          //AuthenticationController().login('user1@gmail.com', 'password');
          // final result = await FilePicker.platform.pickFiles(
          //     allowMultiple: false,
          //     type: FileType.custom,
          //     allowedExtensions: ['png', 'jpg', 'jpeg']);

          // if (result == null) {
          //   print('No File has been picked');
          //   return;
          // }

          // final path = result.files.single.path;
          // final name = result.files.single.name;

          // print(path);
          // print(name);
          // await ProfilePicController().uploadFile('user1', path!);
          // print('Done');
          Navigator.pushNamed(context, ConversationScreen.id);
          // MatchController matchController = new MatchController();
          // // matchController.listMatches();
        },
        child: ChatPreview(name, lastMessage, time, profilePicURLs[i]),
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
              print("Snapshot");
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
