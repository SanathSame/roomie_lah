import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
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
        height: height * 0.6,
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
            height: height * 0.3,
            width: width * 0.8,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(widget.users![index].name),
              Text(widget.users![index].age.toString())
            ],
          ),
          Text(widget.users![index].universityName)
        ]);
  }

  Widget getCardBackColumn(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [Text("Back Side of ${widget.users![index].name}")],
    );
  }
}
