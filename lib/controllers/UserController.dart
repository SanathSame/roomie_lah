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

    var matchData = await MatchController().listMatches(currentUser.username);

    Matches().matches = matchData['matches'];
    print(Matches().matches);
  }
}
