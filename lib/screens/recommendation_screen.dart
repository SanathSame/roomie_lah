// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:roomie_lah/controllers/AlgorithmController.dart';
import 'package:roomie_lah/controllers/swiping_controller.dart';
import 'package:roomie_lah/entity/CurrentUser.dart';
import 'package:roomie_lah/entity/user.dart';
import 'package:roomie_lah/constants.dart';
import 'package:roomie_lah/widgets/AppBar.dart';
import 'package:roomie_lah/widgets/Drawer.dart';
import 'package:roomie_lah/widgets/NavBar.dart';
import 'package:roomie_lah/controllers/MatchController.dart';
import 'package:roomie_lah/widgets/recommendations.dart';

void main() => runApp(MaterialApp(
      title: 'RoomieLah',
      home: RecommendationScreen(),
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
    ));

class RecommendationScreen extends StatefulWidget {
  static const String id = 'recommendation_screen';

  @override
  _RecommendationScreenState createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  List<User> recommendedProfiles = [];
  late double height;
  late double width;
  late bool showFront;
  late Color bgColor;
  late User currentUser;

  @override
  void initState() {
    super.initState();

    showFront = true;
    bgColor = Colors.transparent;
  }

  Widget buildRecommendations(List<User>? users) {
    return new Recommendations(users: users);
    // CardController controller;
    // recommendedProfiles =
    //     await AlgorithmController().getRecommendedUsers("currentUsername");
    // return [];
    // [
    //   new Center(
    //     child: Container(
    //       color: bgColor,
    //       height: height * 0.6,
    //       child: GestureDetector(
    //         onTap: () {
    //           setState(() {
    //             showFront = !showFront;
    //           });
    //         },
    //         child: new TinderSwapCard(
    //           swipeUp: false,
    //           swipeDown: false,
    //           orientation: AmassOrientation.BOTTOM,
    //           totalNum: recommendedProfiles.length,
    //           stackNum: recommendedProfiles.length,
    //           swipeEdge: 4.0,
    //           maxWidth: width * 0.9,
    //           maxHeight: width * 0.9,
    //           minWidth: width * 0.8,
    //           minHeight: width * 0.8,
    //           cardBuilder: (context, index) => Card(
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(30.0),
    //             ),
    //             elevation: 5,
    //             color: Colors.grey[200],
    //             child: showFront
    //                 ? getCardFrontColumn(index)
    //                 : getCardBackColumn(index),
    //           ),
    //           cardController: controller = CardController(),
    //           swipeUpdateCallback:
    //               (DragUpdateDetails details, Alignment align) {
    //             /// Get swiping card's alignment
    //             if (align.x < 0) {
    //               //Card is LEFT swiping

    //             } else if (align.x > 0) {
    //               //Card is RIGHT swiping

    //             }
    //           },
    //           swipeCompleteCallback:
    //               (CardSwipeOrientation orientation, int index) async {
    //             if (orientation == CardSwipeOrientation.RIGHT) {
    //               print("swiped right");
    //               SwipingController().updateSwipeData(CurrentUser().username,
    //                   recommendedProfiles[index].username, "right");
    //               // remove hard-coded username
    //               if (await SwipingController()
    //                   .checkMatch(CurrentUser().username, recommendedProfiles[index].username)) {
    //                 MatchController()
    //                     .addMatch(CurrentUser().username, recommendedProfiles[index].username);
    //                 showDialog(
    //                   context: context,
    //                   builder: (BuildContext context) => AlertDialog(
    //                     title: const Text('Congratulations!'),
    //                     content: Text(
    //                         'You have matched with ${recommendedProfiles[index].username}. You can proceed to the Chat Screen to know them further.'),
    //                     actions: <Widget>[
    //                       TextButton(
    //                         onPressed: () => Navigator.pop(context, 'OK'),
    //                         child: const Text('OK'),
    //                       ),
    //                     ],
    //                   ),
    //                 );
    //               }
    //             } else if (orientation == CardSwipeOrientation.LEFT) {
    //               print("swiped left");
    //               SwipingController().updateSwipeData(currentUser.username,
    //                   recommendedProfiles[index].username, "left");
    //             }
    //           },
    //         ),
    //       ),
    //     ),
    //   ),
    // ];
  }

  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appBar(
        title: "Recommendations",
        key: UniqueKey(),
      ),
      body: FutureBuilder<List<User>>(
        future:
            AlgorithmController().getRecommendedUsers(CurrentUser().username),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          Widget child;

          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null && snapshot.requireData.length > 0) {
              child = buildRecommendations(snapshot.data);
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
            child = Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                    width: 200,
                    height: 200,
                  ),
                ),
              ],
            );
          }
          return child;
        },
      ),
      bottomNavigationBar: BasicBottomNavBar(),
      endDrawer: CustomDrawer(),
    );
  }

  Widget getCardFrontColumn(int index) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: height * 0.3,
            width: width * 0.8,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: recommendedProfiles[index].profilePicURL == ""
                      ? AssetImage('assets/images/hasbullah.jpg')
                          as ImageProvider
                      : NetworkImage(recommendedProfiles[index].profilePicURL)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(recommendedProfiles[index].name),
              Text(recommendedProfiles[index].age.toString())
            ],
          ),
          Text(recommendedProfiles[index].universityName)
        ]);
  }

  Widget getCardBackColumn(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [Text("Back Side of ${recommendedProfiles[index].name}")],
    );
  }
}
