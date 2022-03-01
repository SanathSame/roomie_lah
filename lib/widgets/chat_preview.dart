import 'package:flutter/material.dart';


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
    return Container(
      child: Row(
        children: <Widget> [
          new CircleAvatar(
            backgroundImage: AssetImage('../../assets/hasbullah.jpeg'),
            radius: 50.0,
          ),
          Column(
            children: <Widget> [
              Text(this._name),
              Padding(padding: EdgeInsets.all(4)),
              Text(this._lastMessage),
            ],
          ),
          Spacer(),
          Text(this._time),
        ],
      ),
    );
  }
}