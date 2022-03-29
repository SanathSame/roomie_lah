import 'dart:convert';
import 'dart:math';

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
        List<String>.from(decoded['list of profiles']);
    print(recommendations);
    return recommendations;
  }

  Future<List<User>> getRecommendedUsers(String username) async {
    List<String> usernames = await getRecommedations(username);
    List<User> profiles = [];
    usernames.forEach((element) async {
      profiles.add(await retrieveDetails(element));
    });
    return profiles;
  }

  Future<User> retrieveDetails(String email) async {
    print(email);
    User user = User();
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
        user.stayinIn = documentSnapshot['stayingIn'];
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
