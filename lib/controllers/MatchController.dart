// ignore_for_file: invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';

class MatchController {
  static CollectionReference matches =
      FirebaseFirestore.instance.collection('matches');

  Future<List<String>> listMatches(String username) async {
    List<String> matchesList = [];
    await matches
        .doc(username)
        .collection('matches')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) async {
                matchesList.add(doc['user']);
              })
            })
        .catchError((onError) => {print(onError)});

    return matchesList;
  }

  Future<void> addMatch(String leftMatch, String rightMatch) async {
    await matches
        .doc(leftMatch)
        .collection('matches')
        .add({'user': rightMatch})
        .then((value) => {'{rightMatch} added to {leftMatch}'})
        .catchError((onError) => {print(onError)});

    await matches
        .doc(rightMatch)
        .collection('matches')
        .add({'user': leftMatch})
        .then((value) => {'{leftMatch} added to {rightMatch}'})
        .catchError((onError) => {print(onError)});
  }

  Future<void> deleteMatch(String leftMatch, String rightMatch) async {
    await matches
        .doc(leftMatch)
        .collection('matches')
        .where('user', isEqualTo: rightMatch)
        .get()
        .then((snapshot) async => {
              for (DocumentSnapshot documentSnapshot in snapshot.docs)
                {await documentSnapshot.reference.delete()}
            })
        .catchError((onError) => print(onError));

    await matches
        .doc(rightMatch)
        .collection('matches')
        .where('user', isEqualTo: leftMatch)
        .get()
        .then((snapshot) async => {
              for (DocumentSnapshot documentSnapshot in snapshot.docs)
                {await documentSnapshot.reference.delete()}
            })
        .catchError((onError) => print(onError));
  }
}

void main() {
  MatchController matchController = new MatchController();
  matchController.listMatches('user1');
}
