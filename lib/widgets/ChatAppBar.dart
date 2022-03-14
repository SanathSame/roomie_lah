import 'package:flutter/material.dart';

Widget ChatAppBar(BuildContext context) {
  return AppBar(
    title: Row(
      children: [
        Expanded(child: Text(
          "Hasbullah",
          style: biggerTextStyle(),

          )
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: Image.asset(
            'assets/images/hasbullah.jpg',
            height: 50
          ),
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
