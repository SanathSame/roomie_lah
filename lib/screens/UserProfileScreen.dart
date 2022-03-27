// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'EditProfileScreen.dart';
import "package:roomie_lah/constants.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'RoomieLah',
    home: UserProfileUI(
      age: '20',
      course: 'CS',
      gender: 'Male',
      interests: '',
      nationality: 'Indian',
      university: 'NTU',
      username: '',
    ),
    theme: ThemeData(
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: Colors.white,
    ),
  ));
}

class UserProfileUI extends StatefulWidget {
  late String username = "";
  late String university = "";
  String age = "";
  String course = "";
  String nationality = "";
  String gender = "";
  String interests = "";
  static String id = "user_profile_screen";

  UserProfileUI(
      {Key? key,
      required this.username,
      required this.age,
      required this.university,
      required this.course,
      required this.nationality,
      required this.gender,
      required this.interests})
      : super(key: key);

  @override
  _UserProfileUIState createState() => _UserProfileUIState();
}

class _UserProfileUIState extends State<UserProfileUI> {
  List<String> attributes = <String>[
    'Name:',
    'Age:',
    'Gender:',
    'Course:',
    //'Year of Study:',
    'Nationality:',
    'University:',
    'Interests:',
  ];
  List<String> tst = [];
  void initState() {
    super.initState();
    tst = <String>[
      '${widget.username}',
      '${widget.age}',
      '${widget.gender}',
      '${widget.course}',
      '${widget.nationality}',
      '${widget.university}',
      '${widget.interests}',
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text("User Profile", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, EditProfileScreen.id,
                    arguments: false);
              },
              icon: Icon(Icons.edit))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 50.0),
              Container(
                height: 420,
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: attributes.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.teal[300],
                        ),
                        child: Center(
                            child: Text('${attributes[i]} ${tst[i]}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                    fontFamily: 'FjallaOne',
                                    color: Colors.white))));
                  },
                  separatorBuilder: (BuildContext context, int i) =>
                      const Divider(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
