// ignore_for_file: invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roomie_lah/screens/EditProfileScreen.dart';
import 'dart:async';

class MatchController {
  static CollectionReference matches =
      FirebaseFirestore.instance.collection('matches');

  Future<Map<String, List<dynamic>>> listMatches(String username) async {
    List<dynamic> matchesList = [];
    await matches
        .doc(username)
        .get()
        .then((DocumentSnapshot documentSnapshot) => {
              if (documentSnapshot.exists)
                {
                  matchesList = documentSnapshot['matches'],
                }
              else
                {matchesList = []}
            })
        .catchError((onError) => {print(onError)});

    return {'matches': matchesList};
  }

  Future<void> addMatch(dynamic leftMatch, dynamic rightMatch) async {
    var doc = await matches.doc(leftMatch).get();
    if (!doc.exists) {
      await matches.doc(leftMatch).set({'matches': []});
    }

    doc = await matches.doc(rightMatch).get();
    if (!doc.exists) {
      await matches.doc(rightMatch).set({'matches': []});
    }

    var leftMap = {
      'username': rightMatch,
      'profilePicURL': "",
      'lastMessage': "",
      'timestamp': DateTime.now()
    };
    var rightMap = {
      'username': leftMatch,
      'profilePicURL': "",
      'lastMessage': "",
      'timestamp': DateTime.now()
    };

    Future.wait(
      [
        matches.doc(leftMatch).update(
          {
            'matches': FieldValue.arrayUnion([leftMap])
          },
        ),
        matches.doc(rightMatch).update(
          {
            'matches': FieldValue.arrayUnion([rightMap])
          },
        )
      ],
    );
  }

// Not Good Implementation -- Need to delete Last Message and ProfilePicURL also
  Future<void> deleteMatch(dynamic leftMatch, dynamic rightMatch) async {
    var doc = await matches.doc(leftMatch).get();
    if (!doc.exists) {
      return;
    }

    doc = await matches.doc(rightMatch).get();
    if (!doc.exists) {
      return;
    }

    var leftMatchesList = [];
    var rightMatchesList = [];
    Future.wait(
      [
        matches.doc(leftMatch).get().then(
          (DocumentSnapshot documentSnapshot) async {
            if (documentSnapshot.exists) {
              leftMatchesList = documentSnapshot['matches'];
              print(leftMatchesList);
              for (int i = 0; i < leftMatchesList.length; ++i) {
                if (leftMatchesList[i]['username'] == rightMatch) {
                  leftMatchesList.removeAt(i);
                  await matches
                      .doc(leftMatch)
                      .set({'matches': leftMatchesList});
                  break;
                }
              }
            }
          },
        ),
        matches.doc(rightMatch).get().then(
          (DocumentSnapshot documentSnapshot) async {
            if (documentSnapshot.exists) {
              rightMatchesList = documentSnapshot['matches'];
              print(rightMatchesList);
              for (int i = 0; i < rightMatchesList.length; ++i) {
                if (rightMatchesList[i]['username'] == leftMatch) {
                  rightMatchesList.removeAt(i);
                  await matches
                      .doc(rightMatch)
                      .set({'matches': rightMatchesList});
                  break;
                }
              }
            }
          },
        ),
      ],
    );
  }

  Future<void> updateLastMessage(String leftUser, String rightUser,
      String lastMessage, DateTime timestamp) async {
    print("Updated message");
    List<dynamic> leftMatchesList = [];
    List<dynamic> rightMatchesList = [];
    Future.wait(
      [
        matches.doc(leftUser).get().then(
          (DocumentSnapshot documentSnapshot) async {
            if (documentSnapshot.exists) {
              leftMatchesList = documentSnapshot['matches'];
              print(leftMatchesList);
              for (int i = 0; i < leftMatchesList.length; ++i) {
                if (leftMatchesList[i]['username'] == rightUser) {
                  leftMatchesList[i]['lastMessage'] = lastMessage;
                  leftMatchesList[i]['timestamp'] = timestamp;
                  await matches.doc(leftUser).set({'matches': leftMatchesList});
                  break;
                }
              }
            }
          },
        ),
        matches.doc(rightUser).get().then(
          (DocumentSnapshot documentSnapshot) async {
            if (documentSnapshot.exists) {
              rightMatchesList = documentSnapshot['matches'];
              print(rightMatchesList);
              for (int i = 0; i < rightMatchesList.length; ++i) {
                if (rightMatchesList[i]['username'] == leftUser) {
                  rightMatchesList[i]['lastMessage'] = lastMessage;
                  rightMatchesList[i]['timestamp'] = timestamp;
                  await matches
                      .doc(rightUser)
                      .set({'matches': rightMatchesList});
                  break;
                }
              }
            }
          },
        ),
      ],
    );
  }

  Future<void> editProfilePic(String username, String url) async {
    var doc = await matches.doc(username).get();
    if (!doc.exists) {
      return;
    }

    var matchesList = [];
    await matches
        .doc(username)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        matchesList = documentSnapshot['matches'];
        var futures = <Future>[];

        for (int i = 0; i < matchesList.length; ++i) {
          var user = matchesList[i]['username'];
          futures.add(updateProfilePic(user, username, url));
        }

        await Future.wait(futures);
      }
    }).catchError((onError) => {print(onError)});
  }

  Future<void> updateProfilePic(
      String username, String userToChange, String url) async {
    var matchesList = [];
    await matches
        .doc(username)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        matchesList = documentSnapshot['matches'];
        for (int i = 0; i < matchesList.length; ++i) {
          if (matchesList[i]['username'] == userToChange) {
            matchesList[i]['profilePic'] = url;
            await matches.doc(username).set({'matches': matchesList});
            break;
          }
        }
      }
    });
  }
}

void main() {
  MatchController matchController = new MatchController();
  matchController.listMatches('user1');
}
