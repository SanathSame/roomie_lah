import 'dart:ui';

import "package:flutter/material.dart";
import "package:roomie_lah/constants.dart";
import 'package:roomie_lah/screens/UserProfileScreen.dart';
import "package:roomie_lah/widgets/AppBar.dart";
import "package:roomie_lah/widgets/rounded_button.dart";
import "package:roomie_lah/widgets/rounded_input_field.dart";
import "package:roomie_lah/screens/recommendation_screen.dart";

class SignupScreen extends StatefulWidget {
  static String id = "signup_screen";

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

String enteredUsername = "";
String reenteredUsername = "";
String enteredPassword = "";
bool obscureBool = true;

class _SignupScreenState extends State<SignupScreen> {
  @override
  buildPopUp(String title, String body) {
    return AlertDialog(
      title: Text(title),
      content: Column(mainAxisSize: MainAxisSize.min, children: [Text(body)]),
    );
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: kPrimaryColor,
        title: Center(
          child: Text(
            'SIGNUP',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.0,
                fontSize: 23.0),
          ),
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.03, width: size.width),
              Image.asset(
                "assets/images/RoomieLah_logo.png",
                height: size.height * 0.2,
              ),
              SizedBox(height: size.height * 0.1),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  // color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(29),
                  border: Border.all(color: kPrimaryColor),
                ),
                child: TextField(
                  onChanged: (value) {
                    enteredUsername = value;
                  },
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: "Enter your username",
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  // color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(29),
                  border: Border.all(color: kPrimaryColor),
                ),
                child: TextField(
                  onChanged: (value) {
                    reenteredUsername = value;
                  },
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: "Re-enter your username",
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  // color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(29),
                  border: Border.all(color: kPrimaryColor),
                ),
                child: TextField(
                  obscureText: obscureBool,
                  onChanged: (value) {
                    enteredPassword = value;
                  },
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: "Password",
                    icon: Icon(
                      Icons.lock,
                      color: kPrimaryColor,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureBool = !obscureBool;
                        });
                      },
                      icon: Icon(
                        obscureBool ? Icons.visibility : Icons.visibility_off,
                        color: kPrimaryColor,
                      ),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    primary: Colors.white,
                    padding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 20)),
                onPressed: () => {
                  if (enteredUsername == reenteredUsername)
                    {Navigator.pushNamed(context, UserProfileUI.id)}
                  else
                    {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => buildPopUp("Error",
                              'Re-entered username does not match the original entry.'))
                    }
                  // Navigator.pushNamed(context, RecommendationScreen.id)
                },
                child: Text(
                  "Signup",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
