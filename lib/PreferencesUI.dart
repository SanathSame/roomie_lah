import 'package:flutter/material.dart';
import 'package:roomie_lah/constants.dart';
import 'package:multiselect/multiselect.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

enum DayNight { Day, Night }
enum InOut { StayingIn, GoingOut }
enum Gender { Male, Female, Nonbinary }

final username = TextEditingController();
final age = TextEditingController();
final university = TextEditingController();
final nationality = TextEditingController();
final course = TextEditingController();
bool _validateusername = false;
String dropdownValue = 'Year One';

class _MyAppState extends State<MyApp> {
  List<String> _selectedItems = [];

  DayNight? _character = DayNight.Day;
  Gender? _gender = Gender.Male;

  InOut? _in = InOut.StayingIn;
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: new Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Text('Enter your profile details',
                      style: kLargeBoldText, textAlign: TextAlign.center),
                  //Username
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: new TextFormField(
                      controller: username,
                      autocorrect: true,
                      decoration: new InputDecoration(
                        errorText:
                            _validateusername ? 'Value Can\'t Be Empty' : null,
                        border: InputBorder.none,
                        hintText: 'Enter your name',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white),
                          borderRadius: new BorderRadius.circular(25.7),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white),
                          borderRadius: new BorderRadius.circular(25.7),
                        ),
                      ),
                    ),
                  ),
                  //Age
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: new TextFormField(
                      controller: age,
                      autocorrect: true,
                      decoration: new InputDecoration(
                        errorText:
                            _validateusername ? 'Value Can\'t Be Empty' : null,
                        border: InputBorder.none,
                        hintText: 'Enter your age',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white),
                          borderRadius: new BorderRadius.circular(25.7),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white),
                          borderRadius: new BorderRadius.circular(25.7),
                        ),
                      ),
                    ),
                  ),
                  //University Name
                  ListTile(
                    leading: const Icon(Icons.home_work_outlined),
                    title: new TextFormField(
                      controller: university,
                      autocorrect: true,
                      decoration: new InputDecoration(
                        errorText:
                            _validateusername ? 'Value Can\'t Be Empty' : null,
                        border: InputBorder.none,
                        hintText: 'Enter the name of your university',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white),
                          borderRadius: new BorderRadius.circular(25.7),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white),
                          borderRadius: new BorderRadius.circular(25.7),
                        ),
                      ),
                    ),
                  ),
                  //Nationality
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: new TextFormField(
                      controller: nationality,
                      autocorrect: true,
                      decoration: new InputDecoration(
                        errorText:
                            _validateusername ? 'Value Can\'t Be Empty' : null,
                        border: InputBorder.none,
                        hintText: 'Enter your nationality',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white),
                          borderRadius: new BorderRadius.circular(25.7),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white),
                          borderRadius: new BorderRadius.circular(25.7),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: new TextFormField(
                      controller: course,
                      autocorrect: true,
                      decoration: new InputDecoration(
                        errorText:
                            _validateusername ? 'Value Can\'t Be Empty' : null,
                        border: InputBorder.none,
                        hintText: 'Enter your course',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white),
                          borderRadius: new BorderRadius.circular(25.7),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white),
                          borderRadius: new BorderRadius.circular(25.7),
                        ),
                      ),
                    ),
                  ),
                  ListTile(leading: Icon(gender), title: Text('Gender')),
                  ListTile(
                    title: Text('Male'),
                    leading: Radio<Gender>(
                      value: Gender.Male,
                      groupValue: _gender,
                      activeColor: Colors.black,
                      onChanged: (Gender? value) {
                        setState(() {
                          _gender = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Female'),
                    leading: Radio<Gender>(
                      value: Gender.Female,
                      groupValue: _gender,
                      activeColor: Colors.black,
                      onChanged: (Gender? value) {
                        setState(() {
                          _gender = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Non-binary'),
                    leading: Radio<Gender>(
                      value: Gender.Nonbinary,
                      groupValue: _gender,
                      activeColor: Colors.black,
                      onChanged: (Gender? value) {
                        setState(() {
                          _gender = value;
                        });
                      },
                    ),
                  ),
                  Row(children: <Widget>[
                    SizedBox(width: 20.0),
                    Text('Enter your year of study', style: kMediumText),
                    SizedBox(width: 20.0),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.teal),
                      underline: Container(
                        height: 2,
                        color: Colors.teal,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>[
                        'Year One',
                        'Year Two',
                        'Year Three',
                        'Year Four',
                        'Year Five'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ]),

                  SizedBox(height: 20.0),
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
                    leading: Radio<DayNight>(
                      value: DayNight.Day,
                      groupValue: _character,
                      activeColor: Colors.black,
                      onChanged: (DayNight? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Night'),
                    leading: Radio<DayNight>(
                      value: DayNight.Night,
                      groupValue: _character,
                      activeColor: Colors.black,
                      onChanged: (DayNight? value) {
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
                    leading: Radio<InOut>(
                      value: InOut.StayingIn,
                      groupValue: _in,
                      activeColor: Colors.black,
                      onChanged: (InOut? value) {
                        setState(() {
                          _in = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Going out'),
                    leading: Radio<InOut>(
                      value: InOut.GoingOut,
                      groupValue: _in,
                      activeColor: Colors.black,
                      onChanged: (InOut? value) {
                        setState(() {
                          _in = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                      leading: Icon(Icons.wb_sunny_rounded),
                      title: Text('Are you a vegetarian or non-vegeterian?')),
                  ListTile(
                    title: Text('Day'),
                    leading: Radio<DayNight>(
                      value: DayNight.Day,
                      groupValue: _character,
                      activeColor: Colors.black,
                      onChanged: (DayNight? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Night'),
                    leading: Radio<DayNight>(
                      value: DayNight.Night,
                      groupValue: _character,
                      activeColor: Colors.black,
                      onChanged: (DayNight? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                      leading: Icon(Icons.wb_sunny_rounded),
                      title: Text('Do you drink alcohol?')),
                  ListTile(
                    title: Text('Day'),
                    leading: Radio<DayNight>(
                      value: DayNight.Day,
                      groupValue: _character,
                      activeColor: Colors.black,
                      onChanged: (DayNight? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Night'),
                    leading: Radio<DayNight>(
                      value: DayNight.Night,
                      groupValue: _character,
                      activeColor: Colors.black,
                      onChanged: (DayNight? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                      leading: Icon(Icons.wb_sunny_rounded),
                      title: Text('Do you smoke`?')),
                  ListTile(
                    title: Text('Day'),
                    leading: Radio<DayNight>(
                      value: DayNight.Day,
                      groupValue: _character,
                      activeColor: Colors.black,
                      onChanged: (DayNight? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Night'),
                    leading: Radio<DayNight>(
                      value: DayNight.Night,
                      groupValue: _character,
                      activeColor: Colors.black,
                      onChanged: (DayNight? value) {
                        setState(() {
                          _character = value;
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
                      child: Text('Submit profile preferences',
                          style: kMediumText)),
                ],
              ),
            ),
          ),
        ));
  }
}
