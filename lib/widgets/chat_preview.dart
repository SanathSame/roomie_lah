import 'dart:math';

import 'package:flutter/material.dart';
import 'package:roomie_lah/controllers/MatchController.dart';

// CHANGE OPACITY DEPENDING ON IF THE MESSAGE HAS BEEN READ OR NOT
// CHANGE THE SIZE OF WIDGETS DEPENDING ON SIZE OF SCREEN
// CAN ADD A CIRCLE ON THE PROFILE IF THE PERSON IS ONLINE OR NOT

// ignore: must_be_immutable
class ChatPreview extends StatelessWidget {
  late String _profilePicURL;
  late String _name;
  late String _lastMessage;
  late String _time;
  late String _currentUser;

  ChatPreview(String currentUser, String name, String lastMessage, String time,
      String profilePicURL) {
    print("Profile Pic: $profilePicURL");
    this._profilePicURL = profilePicURL;
    this._currentUser = currentUser;
    this._name = name;
    this._lastMessage = lastMessage;
    this._time = time;
    print('Created Chat Preview :$_profilePicURL');
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.01),
      child: Row(
        children: <Widget>[
          new CircleAvatar(
            backgroundImage: this._profilePicURL == ""
                ? AssetImage('assets/images/hasbullah.jpg') as ImageProvider
                : NetworkImage(this._profilePicURL),
            radius: 0.03 * max(width, height),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    this._name,
                    style: TextStyle(
                        fontSize: 0.03 * width, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 0.015 * height,
                  ),
                  Opacity(
                    opacity: 0.64,
                    child: Text(
                      this._lastMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 0.03 * width),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Column(
            children: [
              IconButton(
                  onPressed: (() {
                    MatchController()
                        .deleteMatch(this._currentUser, this._name);
                  }),
                  icon: Icon(Icons.more_horiz)),
              Opacity(
                opacity: 0.64,
                child: Text(
                  this._time,
                  style: TextStyle(fontSize: 0.025 * width),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
