import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:roomie_lah/constants.dart';
import 'package:roomie_lah/widgets/AppBar.dart';
import 'package:multiselect/multiselect.dart';
import 'package:roomie_lah/widgets/NavBar.dart';

void main() => runApp(MaterialApp(
      title: 'RoomieLah',
      home: PreferencesScreen(),
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
    ));

class PreferencesScreen extends StatefulWidget {
  static String id = "preferences_screen";

  @override
  _PreferenceScreenState createState() => _PreferenceScreenState();
}

enum SingingCharacter { Day, Night }
enum Singing { StayingIn, GoingOut }

class _PreferenceScreenState extends State<PreferencesScreen> {
  List<String> _selectedItems = [];

  SingingCharacter? _character = SingingCharacter.Day;
  Singing? _in = Singing.StayingIn;
  void onSubmit() async {
    if (_selectedItems.isEmpty) {
      errorAlertDialog(context);
    }
  }

  errorAlertDialog(BuildContext context) {
    Widget okButton = RaisedButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text(
          "Your preferences could not be registered. Please try filling all credentials!"),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 5.0,
        title: Text('Preferences', textAlign: TextAlign.center),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Center(
          child: new Column(
            children: <Widget>[
              SizedBox(height: 20),
              Text('Enter your profile preferences',
                  style: kLargeBoldText, textAlign: TextAlign.center),
              SizedBox(height: 30),
              ListTile(
                leading: const Icon(Icons.person),
                title: new Text('What are your top interests?'),
              ),
              DropDownMultiSelect(
                onChanged: (List<String> x) {
                  setState(() {
                    _selectedItems = x;
                  });
                },
                options: [
                  'Netflix',
                  'Gaming',
                  'Photography',
                  'Music',
                  'Football',
                  'Baking',
                  'Board Games',
                  'Eating',
                  'Trekking',
                  'Gigs'
                ],
                selectedValues: _selectedItems,
                whenEmpty: 'Select Something',
              ),
              SizedBox(height: 10),
              ListTile(
                  leading: Icon(Icons.wb_sunny_rounded),
                  title: Text('Are you a day person or night person?')),
              ListTile(
                title: Text('Day'),
                leading: Radio<SingingCharacter>(
                  value: SingingCharacter.Day,
                  groupValue: _character,
                  activeColor: Colors.black,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Night'),
                leading: Radio<SingingCharacter>(
                  value: SingingCharacter.Night,
                  groupValue: _character,
                  activeColor: Colors.black,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
              ),
              ListTile(
                  leading: Icon(Icons.beach_access),
                  title: Text('Do you prefer staying in or going out?')),
              ListTile(
                title: Text('Staying in'),
                leading: Radio<Singing>(
                  value: Singing.StayingIn,
                  groupValue: _in,
                  activeColor: Colors.black,
                  onChanged: (Singing? value) {
                    setState(() {
                      _in = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Going out'),
                leading: Radio<Singing>(
                  value: Singing.GoingOut,
                  groupValue: _in,
                  activeColor: Colors.black,
                  onChanged: (Singing? value) {
                    setState(() {
                      _in = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                  ),
                  onPressed: (onSubmit),
                  child: Text('Submit profile preferences', style: kMediumText))
            ],
          ),
        ),
      ),
      bottomNavigationBar: BasicBottomNavBar(),
    );
  }
}
