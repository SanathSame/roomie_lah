// ignore_for_file: invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roomie_lah/screens/EditProfileScreen.dart';

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
      'timestamp': "9:00"
    };
    var rightMap = {
      'username': leftMatch,
      'profilePicURL': "",
      'lastMessage': "",
      'timestamp': "9:00"
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
      await matches.doc(leftMatch).set(
        {
          'matches': [],
          'lastMessage': [],
          "profilePicURL": [],
        },
      );
    }

    doc = await matches.doc(rightMatch).get();
    if (!doc.exists) {
      await matches.doc(rightMatch).set(
        {
          'matches': [],
          'lastMessage': [],
          "profilePicURL": [],
        },
      );
    }

    Future.wait([
      matches.doc(leftMatch).update({
        'matches': FieldValue.arrayRemove([rightMatch])
      }),
      matches.doc(rightMatch).update({
        'matches': FieldValue.arrayRemove([leftMatch])
      })
    ]);
  }

  Future<void> updateLastMessage(String leftUser, String rightUser,
      String lastMessage, String timestamp) async {
    print("Updated message");
    List<dynamic> leftMatchesList = [];
    List<dynamic> rightMatchesList = [];
    Future.wait(
      [
        matches.doc(leftUser).get().then(
              (DocumentSnapshot documentSnapshot) async => {
                if (documentSnapshot.exists)
                  {
                    leftMatchesList = documentSnapshot['matches'],
                    print(leftMatchesList),
                    for (int i = 0; i < leftMatchesList.length; ++i)
                      {
                        if (leftMatchesList[i]['username'] == rightUser)
                          {
                            leftMatchesList[i]['lastMessage'] = lastMessage,
                            leftMatchesList[i]['timestamp'] = timestamp,
                            await matches
                                .doc(leftUser)
                                .set({'matches': leftMatchesList})
                          }
                      }
                  }
              },
            ),
        matches.doc(rightUser).get().then(
              (DocumentSnapshot documentSnapshot) async => {
                if (documentSnapshot.exists)
                  {
                    rightMatchesList = documentSnapshot['matches'],
                    print(rightMatchesList),
                    for (int i = 0; i < rightMatchesList.length; ++i)
                      {
                        if (rightMatchesList[i]['username'] == leftUser)
                          {
                            rightMatchesList[i]['lastMessage'] = lastMessage,
                            rightMatchesList[i]['timestamp'] = timestamp,
                            await matches
                                .doc(rightUser)
                                .set({'matches': rightMatchesList})
                          }
                      }
                  }
              },
            ),
      ],
    );
  }
}

void main() {
  MatchController matchController = new MatchController();
  matchController.listMatches('user1');
}
