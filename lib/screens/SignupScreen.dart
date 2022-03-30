import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import "package:roomie_lah/constants.dart";
import 'package:roomie_lah/controllers/AuthenticationController.dart';
import 'package:roomie_lah/entity/CurrentUser.dart';
import 'package:roomie_lah/screens/EditProfileScreen.dart';
import 'package:roomie_lah/screens/UserProfileScreen.dart';
import "package:roomie_lah/widgets/AppBar.dart";
import "package:roomie_lah/widgets/rounded_button.dart";
import "package:roomie_lah/widgets/rounded_input_field.dart";
import "package:roomie_lah/screens/recommendation_screen.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'RoomieLah',
    home: SignupScreen(),
    theme: ThemeData(
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: Colors.white,
    ),
  ));
}

class SignupScreen extends StatefulWidget {
  static String id = "signup_screen";

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

String enteredUsername = "";
String reenteredPassword = "";
String enteredPassword = "";
bool obscureBool = true;

class _SignupScreenState extends State<SignupScreen> {
  @override
  bool showSpinner = false;
  buildPopUp(String title, String body) {
    return AlertDialog(
      title: Text(title),
      content: Column(mainAxisSize: MainAxisSize.min, children: [Text(body)]),
    );
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
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
                      hintText: "Enter your email",
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
                      reenteredPassword = value;
                    },
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: "Re-enter password",
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
                  onPressed: () async {
                    AuthenticationController auth =
                        new AuthenticationController();
                    bool success = false;
                    if (enteredPassword == reenteredPassword) {
                      setState(() {
                        showSpinner = true;
                      });
                      success =
                          await auth.signUp(enteredUsername, enteredPassword);

                      if (success) {
                        CurrentUser currentUser = CurrentUser();
                        currentUser.email = enteredUsername;
                        currentUser.username = enteredUsername.split("@")[0];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditProfileScreen(firstTime: true),
                          ),
                        );
                      } else {
                        setState(() {
                          showSpinner = false;
                          invalidDetails('Email Already exists');
                        });
                      }
                    } else {
                      setState(() {
                        showSpinner = false;
                        invalidDetails(
                            'Confirmation Password must be the same as Password');
                      });
                      // showDialog(
                      //     context: context,
                      //     builder: (BuildContext context) => buildPopUp("Error",
                      //         'Re-entered username does not match the original entry.'));
                    }
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
      ),
    );
  }

  Future<void> invalidDetails(String message) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        // can add logic to store entry here
        return AlertDialog(
          //title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                SizedBox(height: 20),
                TextButton(
                  child: Text('Cancel',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 200, 20, 34))),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          // can't center button if put in actions
          // actions: <Widget>[
          //     TextButton(
          //     child: Text('OK',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Colors.black)),
          //     style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(Colors.green[500]) ),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),

          // ],
        );
      },
    );
  }
}
