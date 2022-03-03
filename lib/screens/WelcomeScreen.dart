import 'dart:ui';

import "package:flutter/material.dart";
import "package:roomie_lah/constants.dart";

class WelcomeScreen extends StatelessWidget {
  static final String id = 'welcome_page';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // color: kPrimaryColor,
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
