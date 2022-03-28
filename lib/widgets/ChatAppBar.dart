import 'package:flutter/material.dart';
import 'package:roomie_lah/constants.dart';

Widget ChatAppBar(BuildContext context, String NameOfChatWith, Widget ProfilePic) {
  return AppBar(
    backgroundColor: kPrimaryColor,
    title: Row(
      children: [
        Expanded(child: Text(
          NameOfChatWith,
          style: biggerTextStyle(),

          )
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: ProfilePic,
        ),
      ],
    ),
    elevation: 0.0,
    centerTitle: false,
  );
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white54),
      focusedBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
}

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 16);
}

TextStyle biggerTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 20);
}
