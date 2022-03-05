import 'dart:math';

import 'package:flutter/material.dart';




// CHANGE OPACITY DEPENDING ON IF THE MESSAGE HAS BEEN READ OR NOT
// CHANGE THE SIZE OF WIDGETS DEPENDING ON SIZE OF SCREEN
// CAN ADD A CIRCLE ON THE PROFILE IF THE PERSON IS ONLINE OR NOT



// ignore: must_be_immutable
class ChatPreview extends StatelessWidget {

  Image _profilePic;
  String _name;
  String _lastMessage;
  String _time;


  ChatPreview(String name, String lastMessage, String time){
    //this._profilePic = profilePic;
    this._name = name;
    this._lastMessage = lastMessage;
    this._time = time;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20 * 0.75),
      child: Row(
        children: <Widget> [
          new CircleAvatar(
            backgroundImage: AssetImage('../../assets/hasbullah.jpeg'),
            radius: 0.05 * max(width, height),
          ),
          Expanded(
          child:Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                  Text(this._name, style: TextStyle(fontSize: 0.03 * width, fontWeight: FontWeight.w500),),
                  SizedBox(height: 0.027 * height,),
                  Opacity(
                    opacity: 0.64,
                      child: Text(this._lastMessage, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 0.03 * width),),),
                  ],
              ),
          ),
          ),
          Spacer(),
          Opacity(
              opacity: 0.64,
              child: Text(this._time, style:
                TextStyle(fontSize: 0.025 * width),)),
        ],
      ),
    );
  }
}