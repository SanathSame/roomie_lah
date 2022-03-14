import 'package:flutter/material.dart';
import 'package:roomie_lah/constants.dart';
import 'package:roomie_lah/screens/WelcomeScreen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RoomieLah',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Color(0xff656865)
        ,
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
      },
      // initialRoute: WelcomeScreen.id,
      // routes: {
      //   // WelcomeScreen.id: (context) => WelcomeScreen(),
      // },
    );
  }
}
