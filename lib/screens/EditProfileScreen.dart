import 'package:flutter/material.dart';
import 'package:roomie_lah/constants.dart';
import 'package:multiselect/multiselect.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'UserProfileScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'RoomieLah',
    home: EditProfileUI(),
    theme: ThemeData(
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: Colors.white,
    ),
  ));
}

class EditProfileUI extends StatefulWidget {
  static String id = "edit_profile_screen";

  @override
  _MyAppState createState() => _MyAppState();
}

enum DayNight { Day, Night }
enum InOut { StayingIn, GoingOut }
enum Smoking { Yes, No }
enum Alcohol { Yes, No }
enum Veg { veg, Nonveg }
final username = TextEditingController();
final age = TextEditingController();
final university = TextEditingController();
final nationality = TextEditingController();
final course = TextEditingController();
List<String> _selectedItems = [];
String _gender = "Male";
bool _validateusername = false;
bool _validateage = false;
bool _validateuni = false;
bool _validatenationality = false;
bool _validatecourse = false;

String dropdownValue = 'Year One';

getItemAndNavigate(BuildContext context) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => UserProfileUI(
                username: username.text,
                age: age.text,
                university: university.text,
                course: course.text,
                nationality: nationality.text,
                gender: _gender,
                interests: _selectedItems.toString(),
              )));
}

class _MyAppState extends State<EditProfileUI> {
  DayNight? _character = DayNight.Day;

  Smoking? _smoking = Smoking.No;
  Alcohol _alcohol = Alcohol.No;
  Veg _veg = Veg.veg;
  InOut? _in = InOut.StayingIn;
  void onSubmit() async {
    setState(() {
      username.text.isEmpty
          ? _validateusername = true
          : _validateusername = false;
      age.text.isEmpty ? _validateage = true : _validateage = false;
      university.text.isEmpty ? _validateuni = true : _validateuni = false;
      nationality.text.isEmpty
          ? _validatenationality = true
          : _validatenationality = false;
      course.text.isEmpty ? _validatecourse = true : _validatecourse = false;

      if ((_validateusername == false) &&
          (_validateuni == false) &&
          (_validatenationality == false) &&
          (_validateage == false) &&
          (_validatecourse == false) &&
          _selectedItems.isEmpty == false) {
        getItemAndNavigate(context);
      }
    });
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 5.0,
          title: Text('Preferences'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: new Column(
                // Profile Pic Selection

                children: <Widget>[
                  SizedBox(height: 20),
                  Text('Enter your profile details',
                      style: kLargeBoldText, textAlign: TextAlign.center),
                  SizedBox(height: 10.0),
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
                            _validateage ? 'Value Can\'t Be Empty' : null,
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
                            _validateuni ? 'Value Can\'t Be Empty' : null,
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
                        errorText: _validatenationality
                            ? 'Value Can\'t Be Empty'
                            : null,
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
                            _validatecourse ? 'Value Can\'t Be Empty' : null,
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
                  Row(children: <Widget>[
                    SizedBox(width: 20.0),
                    Icon(Icons.home_work_outlined),
                    SizedBox(width: 20.0),
                    Text('Enter your year of study',
                        style: TextStyle(color: Colors.black, fontSize: 15.0)),
                    SizedBox(width: 50.0),
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
                  ListTile(leading: Icon(Icons.male), title: Text('Gender')),
                  ListTile(
                    title: Text('Male'),
                    leading: Radio<String>(
                      value: "Male",
                      groupValue: _gender,
                      activeColor: Colors.black,
                      onChanged: (String? value) {
                        setState(() {
                          _gender = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Female'),
                    leading: Radio<String>(
                      value: "Female",
                      groupValue: _gender,
                      activeColor: Colors.black,
                      onChanged: (String? value) {
                        setState(() {
                          _gender = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Non-binary'),
                    leading: Radio<String>(
                      value: "Non Binary",
                      groupValue: _gender,
                      activeColor: Colors.black,
                      onChanged: (String? value) {
                        setState(() {
                          _gender = value!;
                        });
                      },
                    ),
                  ),
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
                      leading: Icon(Icons.adb_outlined),
                      title: Text('Are you a vegetarian or non-vegeterian?')),
                  ListTile(
                    title: Text('Vegetarian'),
                    leading: Radio<Veg>(
                      value: Veg.veg,
                      groupValue: _veg,
                      activeColor: Colors.black,
                      onChanged: (Veg? value) {
                        setState(() {
                          _veg = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Non-vegetarian'),
                    leading: Radio<Veg>(
                      value: Veg.Nonveg,
                      groupValue: _veg,
                      activeColor: Colors.black,
                      onChanged: (Veg? value) {
                        setState(() {
                          _veg = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                      leading: Icon(Icons.no_drinks),
                      title: Text('Do you drink alcohol?')),
                  ListTile(
                    title: Text('Yes'),
                    leading: Radio<Alcohol>(
                      value: Alcohol.Yes,
                      groupValue: _alcohol,
                      activeColor: Colors.black,
                      onChanged: (Alcohol? value) {
                        setState(() {
                          _alcohol = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('No'),
                    leading: Radio<Alcohol>(
                      value: Alcohol.No,
                      groupValue: _alcohol,
                      activeColor: Colors.black,
                      onChanged: (Alcohol? value) {
                        setState(() {
                          _alcohol = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                      leading: Icon(Icons.smoke_free),
                      title: Text('Do you smoke`?')),
                  ListTile(
                    title: Text('Yes'),
                    leading: Radio<Smoking>(
                      value: Smoking.Yes,
                      groupValue: _smoking,
                      activeColor: Colors.black,
                      onChanged: (Smoking? value) {
                        setState(() {
                          _smoking = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('No'),
                    leading: Radio<Smoking>(
                      value: Smoking.No,
                      groupValue: _smoking,
                      activeColor: Colors.black,
                      onChanged: (Smoking? value) {
                        setState(() {
                          _smoking = value;
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
                      child: Text('Update profile preferences',
                          style: kMediumText)),
                ],
              ),
            ),
          ),
        ));
  }
}
