import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:roomie_lah/entity/user.dart';

class RecommendationScreen extends StatefulWidget {
  static const String id = 'recommendation_screen';

  @override
  _RecommendationScreenState createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  List<User> recommendedProfiles = [];
  double height;
  double width;
  bool showFront;

  @override
  void initState() {
    super.initState();
    recommendedProfiles.addAll([
      new User(
          fullName: "Gopal Agarwal",
          age: 20,
          password: "password",
          universityName: "Nanyang Technological University",
          tagLine: "I am the tag line for Gopal",
          tags: ["hello1", "hello2", "hello 3"]),
      new User(
          fullName: "Aks Tayal",
          age: 21,
          password: "password1",
          universityName: "Singapore Management University",
          tagLine: "I am the tag line for Aks",
          tags: ["hello4", "hello5", "hello6"]),
      new User(
          fullName: "Jasraj Singh",
          age: 21,
          password: "password3",
          universityName: "National University of Singapore",
          tagLine: "I am the tag line for Jas",
          tags: ["hello7", "hello8", "hello 9"]),
    ]);
    showFront = true;
  }

  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    CardController controller;
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: Colors.teal,
        title: Center(
          child: Text(
            'RECOMMENDATIONS',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.0,
                fontSize: 23.0),
          ),
        ),
      ),
      body: new Center(
        child: Container(
          height: height * 0.4,
          child: GestureDetector(
            onTap: () {
              setState(() {
                showFront = !showFront;
              });
            },
            child: new TinderSwapCard(
              swipeUp: false,
              swipeDown: false,
              orientation: AmassOrientation.BOTTOM,
              totalNum: recommendedProfiles.length,
              stackNum: 2,
              swipeEdge: 4.0,
              maxWidth: width * 0.9,
              maxHeight: width * 0.9,
              minWidth: width * 0.8,
              minHeight: width * 0.8,
              cardBuilder: (context, index) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 5,
                color: Colors.grey[200],
                child: showFront
                    ? getCardFrontColumn(index)
                    : getCardBackColumn(index),
              ),
              cardController: controller = CardController(),
              swipeUpdateCallback:
                  (DragUpdateDetails details, Alignment align) {
                /// Get swiping card's alignment
                if (align.x < 0) {
                  //Card is LEFT swiping
                } else if (align.x > 0) {
                  //Card is RIGHT swiping
                }
              },
              swipeCompleteCallback:
                  (CardSwipeOrientation orientation, int index) {
                /// Get orientation & index of swiped card!
              },
            ),
          ),
        ),
      ),
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
                image: AssetImage(
                    'assets/images/Profile Picture ${index + 1}.png'),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(recommendedProfiles[index].fullname),
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
      children: [Text("Back Side of ${recommendedProfiles[index].fullname}")],
    );
  }
}
