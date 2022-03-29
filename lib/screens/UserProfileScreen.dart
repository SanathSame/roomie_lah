// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'EditProfileScreen.dart';
import 'package:roomie_lah/entity/CurrentUser.dart';
import 'package:roomie_lah/widgets/NavBar.dart';
import 'package:roomie_lah/widgets/UserProfileTopImg.dart';
import "package:roomie_lah/constants.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'RoomieLah',
    home: UserProfileScreen(),
    theme: ThemeData(
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: Colors.white,
    ),
  ));
}

class TextRow extends StatelessWidget {
  late double width = 0;
  late String text = "";
  TextRow({Key? key, required this.width, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: width),
        Text(
          text,
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}

class UserProfileScreen extends StatefulWidget {
  static String id = 'userProfileScreen';
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          size.width,
          size.height * 0.075, // 10% of the height
        ),
        child: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text("User Profile",
              style: kLargeText, textAlign: TextAlign.center),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, EditProfileScreen.id,
                      arguments: {'firstTime': false});
                },
                icon: Icon(Icons.edit))
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: size.height * 0.25,
                width: size.width,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: size.height * 0.25,
                      width: size.width,
                      child: CustomPaint(
                        painter: CurvePainter(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: size.height * 0.2,
                        width: size.height * 0.2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            "https://www.seekpng.com/png/detail/966-9665317_placeholder-image-person-jpg.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Image.network(CurrentUser().profilePicURL),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                height: size.height * 0.1,
                width: size.width,
                child: Column(
                  children: [
                    Text(
                      '{CurrentUser.username}', // TODO: Change to username
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      '{CurrentUser.name} | {CurrentUser.universityName}', // TODO: Change to actual details
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              const Divider(
                thickness: 2.5,
                color: kPrimaryColor,
              ),
              ExpandablePanel(
                header: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Icon(Icons.person),
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Text(
                      "Personal Information",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                collapsed: Row(),
                expanded: Column(
                  children: [
                    const Divider(
                      thickness: 1,
                      color: kPrimaryColor,
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextRow(
                      width: size.width * 0.05,
                      text: "Name: {CurrentUser.name}",
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextRow(
                      width: size.width * 0.05,
                      text: "Email: {CurrentUser.email}",
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextRow(
                      width: size.width * 0.05,
                      text: "Age: {CurrentUser.age}",
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextRow(
                      width: size.width * 0.05,
                      text: "Course: {CurrentUser.course}",
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextRow(
                      width: size.width * 0.05,
                      text: "Nationality: {CurrentUser.nationality}",
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextRow(
                      width: size.width * 0.05,
                      text: "Gender: {CurrentUser.gender}",
                    ),
                    SizedBox(height: size.height * 0.02),
                  ],
                ),
                controller: ExpandableController(
                  initialExpanded: true,
                ),
              ),
              const Divider(
                thickness: 2.5,
                color: kPrimaryColor,
              ),
              ExpandablePanel(
                header: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Icon(Icons.person),
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Text(
                      "Personal Preferences",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                collapsed: Row(),
                expanded: Column(
                  children: [
                    const Divider(
                      thickness: 1,
                      color: kPrimaryColor,
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextRow(
                      width: size.width * 0.05,
                      text: "Smoker: {CurrentUser.smoker}",
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextRow(
                      width: size.width * 0.05,
                      text: "Drinker: {CurrentUser.drinker}",
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextRow(
                      width: size.width * 0.05,
                      text: "Day Person: {CurrentUser.dayPerson}",
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextRow(
                      width: size.width * 0.05,
                      text: "Vegetarian: {CurrentUser.vegetarian}",
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextRow(
                      width: size.width * 0.05,
                      text: "Prefer Staying In: {CurrentUser.stayingIn}",
                    ),
                    SizedBox(height: size.height * 0.02),
                  ],
                ),
                controller: ExpandableController(
                  initialExpanded: false,
                ),
              ),
              const Divider(
                thickness: 2.5,
                color: kPrimaryColor,
              ),
              ExpandablePanel(
                header: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Icon(Icons.person),
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Text(
                      "Roommate Preferences",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                collapsed: Row(),
                expanded: Column(
                  children: [
                    const Divider(
                      thickness: 1,
                      color: kPrimaryColor,
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextRow(
                      width: size.width * 0.05,
                      text: "Prefer a smoker: {CurrentUser.smokePref}",
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextRow(
                      width: size.width * 0.05,
                      text: "Prefer a drinker: {CurrentUser.alcoholPref}",
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextRow(
                      width: size.width * 0.05,
                      text: "Prefer a day person: {CurrentUser.dayPersonPref}",
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextRow(
                      width: size.width * 0.05,
                      text: "Prefer a vegetarian: {CurrentUser.vegPref}",
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextRow(
                      width: size.width * 0.05,
                      text:
                          "Prefer roommate staying in: {CurrentUser.stayingInPref}",
                    ),
                    SizedBox(height: size.height * 0.02),
                  ],
                ),
                controller: ExpandableController(
                  initialExpanded: false,
                ),
              ),
              const Divider(
                thickness: 2.5,
                color: kPrimaryColor,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BasicBottomNavBar(),
    );
  }
}
