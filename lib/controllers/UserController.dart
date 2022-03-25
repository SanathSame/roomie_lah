import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roomie_lah/controllers/MatchController.dart';
import 'package:roomie_lah/controllers/ProfilePicController.dart';
import 'package:roomie_lah/entity/ChatPreviewList.dart';
import 'package:roomie_lah/entity/CurrentUser.dart';
import 'package:roomie_lah/entity/Matches.dart';
import 'package:async/async.dart';

class UserController {
  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUseronSignup(
      String email, String name, String username) async {
    await users
        .doc(email)
        .set({'name': name, 'username:': username})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add  new user: $error"));
  }

  Future<void> retrieveDetails(String email) async {
    print(email);
    CurrentUser currentUser = CurrentUser();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        currentUser.email = email;
        currentUser.name = documentSnapshot['name'];
        currentUser.username = documentSnapshot['username'];
      } else {
        print('Document does not exist on the database');
      }
    });
  }

// Retrieve important details
  Future<void> setupProfile(String email) async {
    CurrentUser currentUser = CurrentUser();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        currentUser.email = email;
        currentUser.name = documentSnapshot['name'];
        currentUser.username = documentSnapshot['username'];
      } else {
        print('Document does not exist on the database');
      }
    });

    print(currentUser.username);
    currentUser.profilePicURL =
        await ProfilePicController().downloadURL(currentUser.username);

    Matches matches = Matches();

    matches.matches = await MatchController().listMatches(currentUser.username);

    print(matches.matches);

    List<dynamic> imageURLs = [];

    imageURLs = List.filled(matches.matches.length, "");

    FutureGroup futureGroup = FutureGroup();
    ProfilePicController profilePicController = new ProfilePicController();
    for (int i = 0; i < matches.matches.length; ++i) {
      print("Starting future : $i");
      futureGroup.add(profilePicController.downloadURL(matches.matches[i]));
    }
    futureGroup.close();
    await futureGroup.future.then((value) => imageURLs = value);

    ChatPreviewList chatPreviewList = ChatPreviewList();

    for (int i = 0; i < matches.matches.length; ++i) {
      chatPreviewList.addChatPreview(
          matches.matches[i], imageURLs[i], "Hello", "8:00");
    }
  }
}
