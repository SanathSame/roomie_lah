import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roomie_lah/controllers/MatchController.dart';
import 'package:roomie_lah/controllers/ProfilePicController.dart';
import 'package:roomie_lah/entity/ChatPreviewList.dart';
import 'package:roomie_lah/entity/CurrentUser.dart';
import 'package:roomie_lah/entity/Matches.dart';
import 'package:async/async.dart';
import 'package:roomie_lah/entity/user.dart';

class PreferencesController {
  static CollectionReference users =
      FirebaseFirestore.instance.collection('preferences');

  Future<void> setPreferences(
    String email,
    String username,
    bool smoker,
    bool drinker,
    bool dayPerson,
    bool veg,
    bool stayingIn,
  ) async {
    await users
        .doc(email)
        .set(
          {
            'username:': username,
            'smoke': smoker,
            'drink': drinker,
            'dayPerson': dayPerson,
            'veg': veg,
            'stayinIn': stayingIn,
          },
        )
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add  new user: $error"));
  }

  Future<void> retrieveDetails(String email) async {
    CurrentUser currentUser = CurrentUser();
    await FirebaseFirestore.instance
        .collection('preferences')
        .doc(email)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        currentUser.alcoholPref = documentSnapshot['alcohol'];
        currentUser.smokePref = documentSnapshot['smoke'];
        currentUser.vegPref = documentSnapshot['veg'];
        currentUser.stayinInPref = documentSnapshot['stayingIn'];
        currentUser.dayPersonPref = documentSnapshot['dayPerson'];
      } else {
        print('Document does not exist on the database');
      }
    });
  }
}
