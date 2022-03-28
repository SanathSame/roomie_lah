import 'dart:ui';
import 'dart:async';
import "package:flutter/material.dart";
import "package:roomie_lah/constants.dart";
import "package:roomie_lah/screens/LoginScreen.dart";

void main() => runApp(MaterialApp(
      title: 'RoomieLah',
      home: WelcomeScreen(),
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
    ));

class WelcomeScreen extends StatefulWidget {
  static final String id = 'welcome_screen';
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
        () => Navigator.pushNamed(context, LoginScreen.id));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: AssetImage('assets/images/temp_logo.png'),
        ),
      ),
    );
  }
}

// class WelcomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       height: size.height,
//       width: size.width,
//       decoration: BoxDecoration(
//         color: kPrimaryColor,
//         image: DecorationImage(
//           fit: BoxFit.fitWidth,
//           image: AssetImage('assets/images/temp_logo.png'),
//         ),
//       ),
//     );
//   }
// }
