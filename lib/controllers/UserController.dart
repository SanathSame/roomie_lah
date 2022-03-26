import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roomie_lah/controllers/MatchController.dart';
import 'package:roomie_lah/controllers/ProfilePicController.dart';
import 'package:roomie_lah/entity/ChatPreviewList.dart';
import 'package:roomie_lah/entity/CurrentUser.dart';
import 'package:roomie_lah/entity/Matches.dart';
import 'package:async/async.dart';
import 'package:roomie_lah/entity/user.dart';

class UserController {
  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  // String course, String University, bool smoke, drink, day, veg, String profilePic
  Future<void> addUseronSignup(
      String email,
      String name,
      String username,
      String gender,
      String course,
      String university,
      int age,
      bool smoker,
      bool drinker,
      bool dayPerson,
      bool veg,
      String profilePicURL) async {
    await users
        .doc(email)
        .set({
          'name': name,
          'username:': username,
          'course': course,
          'university': university,
          'age': age,
          'gender': gender,
          'smoke': smoker,
          'drink': drinker,
          'dayPerson': dayPerson,
          'veg': veg,
          'profilePicURL': profilePicURL
        })
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

  // TODO: Implement this for Recommendation and Algorithm
  Future<List<User>> listUsers() async {
    return [];
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
