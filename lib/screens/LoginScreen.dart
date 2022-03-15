import 'dart:ui';

import "package:flutter/material.dart";
import "package:roomie_lah/constants.dart";
import "package:roomie_lah/widgets/AppBar.dart";
import "package:roomie_lah/widgets/rounded_button.dart";
import "package:roomie_lah/widgets/rounded_input_field.dart";
import "package:roomie_lah/screens/recommendation_screen.dart";
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(MaterialApp(
      title: 'RoomieLah',
      home: LoginScreen(),
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
    ));

class LoginScreen extends StatefulWidget {
  static String id = "login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

String enteredUsername = "";
String enteredPassword = "";
bool obscureBool = true;

class _LoginScreenState extends State<LoginScreen> {
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
            'LOGIN',
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
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: size.height * 0.03, width: size.width),
                  Image.asset(
                    "assets/images/RoomieLah_logo.png",
                    height: size.height * 0.1,
                  ),
                  SizedBox(height: size.height * 0.03),
                  RoundedInputField(
                    hintText: "Enter Your Username",
                    onChanged: (value) {
                      enteredUsername = value;
                    },
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: size.width * 0.5,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(29),
                      border: Border.all(color: Colors.white),
                    ),
                    child: TextField(
                      obscureText: obscureBool,
                      onChanged: (value) {
                        enteredPassword = value;
                      },
                      cursorColor: kPrimaryColor,
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
                            obscureBool
                                ? Icons.visibility
                                : Icons.visibility_off,
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
                    onPressed: () =>
                        {Navigator.pushNamed(context, RecommendationScreen.id)},
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
