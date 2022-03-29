import 'dart:convert';
import 'dart:math';
import 'package:async/async.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:roomie_lah/entity/user.dart';

class AlgorithmController {
  String url = "http://10.0.2.2:5000/";

  Future<List<String>> getRecommedations(String currentUsername) async {
    print(currentUsername);
    String host = url + "getRecommendations";
    print("host == $host");
    final response = await http.post(Uri.parse(host), body: currentUsername);
    print("here");
    final decoded = json.decode(response.body) as Map<String, dynamic>;

    List<String> recommendations =
        List<String>.from(decoded['List of Usernames']);
    print(recommendations);
    return recommendations;
  }

  Future<List<User>> getRecommendedUsers(String username) async {
    // List<String> usernames = await getRecommedations(username);
    List<String> usernames = ["user17", "Nami14", "Nami5", "Jinbe6", "Jinbe2"];
    List<User> profiles = [];

    print(usernames);

    FutureGroup futureGroup = FutureGroup();
    for (int i = 0; i < usernames.length; ++i) {
      print("Starting future : $i");
      futureGroup.add(retrieveDetails(usernames[i] + '@gmail.com'));
    }
    futureGroup.close();
    await futureGroup.future.then(
      (value) => {
        print(value),
        profiles = List<User>.from(value),
      },
    );

    print(profiles.length);
    for (int i = 0; i < profiles.length; i++) {
      print(profiles[i].email);
    }
    return profiles;
  }

  Future<User> retrieveDetails(String email) async {
    User user = User();
    print(email);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        user.email = email;
        user.name = documentSnapshot['name'];
        user.username = documentSnapshot['username'];
        user.age = documentSnapshot['age'];
        user.gender = documentSnapshot['gender'];
        user.course = documentSnapshot['course'];
        user.universityName = documentSnapshot['university'];
        user.nationality = documentSnapshot['nationality'];
        user.smoker = documentSnapshot['smoke'];
        user.alcohol = documentSnapshot['alcohol'];
        user.stayingIn = documentSnapshot['stayingIn'];
        user.dayPerson = documentSnapshot['dayPerson'];
        user.vegetarian = documentSnapshot['veg'];
        user.interests = List<String>.from(documentSnapshot['interests']);
        user.profilePicURL = documentSnapshot['profilePicURL'];
      } else {
        print('Document does not exist on the database');
      }
    });
    return user;
  }
}
