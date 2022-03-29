import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:roomie_lah/constants.dart';
import 'package:roomie_lah/controllers/MatchController.dart';
import 'package:roomie_lah/controllers/swiping_controller.dart';
import 'package:roomie_lah/entity/CurrentUser.dart';
import 'package:roomie_lah/entity/user.dart';

class Recommendations extends StatefulWidget {
  late List<User>? users;

  Recommendations({Key? key, required this.users}) : super(key: key);

  @override
  _RecommendationsState createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  bool showFront = true;
  late double height;
  late double width;
  var bgColor = Colors.transparent;
  @override
  Widget build(BuildContext context) {
    CardController controller;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return new Center(
      child: Container(
        color: bgColor,
        height: height * 0.9,
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
            totalNum: widget.users?.length,
            stackNum: widget.users?.length,
            swipeEdge: 4.0,
            maxWidth: width,
            maxHeight: height,
            minWidth: width * 0.7,
            minHeight: height * 0.9,
            cardBuilder: (context, index) => Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black, width: 5),
                borderRadius: BorderRadius.circular(30.0),
              ),
              elevation: 5,
              color: Colors.grey[200],
              child: showFront
                  ? getCardFrontColumn(index)
                  : getCardBackColumn(index),
            ),
            cardController: controller = CardController(),
            swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
              /// Get swiping card's alignment
              if (align.x < 0) {
                //Card is LEFT swiping

              } else if (align.x > 0) {
                //Card is RIGHT swiping

              }
            },
            swipeCompleteCallback:
                (CardSwipeOrientation orientation, int index) async {
              if (orientation == CardSwipeOrientation.RIGHT) {
                print("swiped right");
                SwipingController().updateSwipeData(CurrentUser().username,
                    widget.users![index].username, "right");
                // remove hard-coded username
                if (await SwipingController().checkMatch(
                    CurrentUser().username, widget.users![index].username)) {
                  MatchController().addMatch(
                      CurrentUser().username, widget.users![index].username);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Congratulations!'),
                      content: Text(
                          'You have matched with ${widget.users![index].username}. You can proceed to the Chat Screen to know them further.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              } else if (orientation == CardSwipeOrientation.LEFT) {
                print("swiped left");
                SwipingController().updateSwipeData(CurrentUser().username,
                    widget.users![index].username, "left");
              }
            },
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
            height: height * 0.7,
            width: width * 0.9,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: widget.users?[index].profilePicURL == ""
                      ? AssetImage('assets/images/hasbullah.jpg')
                          as ImageProvider
                      : NetworkImage(widget.users![index].profilePicURL)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(
              //   width: 20,
              // ),
              Text(
                widget.users![index].name +
                    ',   ' +
                    (widget.users![index].age).toString() +
                    " " +
                    (widget.users![index].gender)[0],
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(
              //   width: 20,
              // ),
              Text(
                "University:   " + widget.users![index].universityName,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ],
          )
        ]);
  }

  Widget getCardBackColumn(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      // children: buildInterests(widget.users![index].interests),
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          "Nationality: ${widget.users![index].nationality}",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Course: ${widget.users![index].course}",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "${widget.users![index].name}'s characterisctics:",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTags(widget.users![index].smoker ? "Smokes" : "No Smoke",
                Colors.red),
            buildTags(widget.users![index].alcohol ? "Drinks" : "No Drinks",
                Colors.red),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTags(
                widget.users![index].vegetarian
                    ? "Vegetarian"
                    : "Non-vegetarian",
                Colors.red),
            buildTags(
                widget.users![index].dayPerson ? "Day Person" : "Night Person",
                Colors.red),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        buildTags(
            widget.users![index].stayingIn
                ? "Prefers to Stay in"
                : "Prfers to go out",
            Colors.red),
        SizedBox(
          height: 20,
        ),
        Text(
          "${widget.users![index].name}'s interests:",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        SizedBox(
          height: 10,
        ),
        // buildTags((widget.users![index].interests)[0], Colors.blue),
        // Column(children: buildInterests(widget.users![index].interests)),
      ],
    );
  }

  List<Widget> buildInterests(List<String> interests) {
    int l = interests.length;
    // int n_rows = (l / 2).ceil();
    List<Widget> widgetList = [];
    for (int i = 0; i < l; i + 2) {
      widgetList.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTags(interests[i], Colors.blue),
            i + 1 < l ? buildTags(interests[i + 1], Colors.blue) : Text(""),
          ],
        ),
      );
    }
    return widgetList;
  }

  Widget buildTags(String text, Color bgColor) {
    return Container(
      height: 30,
      width: 120,
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      decoration: new BoxDecoration(
        color: bgColor,
        border: Border.all(color: Colors.black, width: 0.0),
        borderRadius: new BorderRadius.all(Radius.elliptical(90, 45)),
      ),
      child: Center(
          child: Text(
        text,
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
      )),
    );
  }
}
