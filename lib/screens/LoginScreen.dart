import 'dart:ui';

import "package:flutter/material.dart";
import "package:roomie_lah/constants.dart";
import "package:roomie_lah/widgets/appBar.dart";
import "package:roomie_lah/widgets/rounded_button.dart";
import "package:roomie_lah/widgets/rounded_input_field.dart";

class LoginScreen extends StatefulWidget {
  static String id = "login_page";

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
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: size.height * 0.03),
                  Image.asset(
                    // TODO: Add image asset
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
                  RoundedButton(
                    text: "LOGIN",
                    press: () async {},
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
