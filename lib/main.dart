import 'package:flutter/material.dart';
import 'package:roomie_lah/constants.dart';

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
        scaffoldBackgroundColor: Colors.white,
      ),
      // initialRoute: WelcomeScreen.id,
      routes: {
        // WelcomeScreen.id: (context) => WelcomeScreen(),
      },
    );
  }
}
