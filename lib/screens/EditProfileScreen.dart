// ignore_for_file: unnecessary_null_comparison
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:roomie_lah/constants.dart';
import 'package:multiselect/multiselect.dart';
import 'package:roomie_lah/controllers/MatchController.dart';
import 'package:roomie_lah/controllers/PreferencesController.dart';
import 'package:roomie_lah/controllers/ProfilePicController.dart';
import 'package:roomie_lah/controllers/UserController.dart';
import 'package:roomie_lah/screens/recommendation_screen.dart';
import '../entity/CurrentUser.dart';

void main() {
  runApp(MaterialApp(
    home: EditProfileScreen(
      firstTime: true,
    ),
  ));
}

// ignore: must_be_immutable
class EditProfileScreen extends StatefulWidget {
  final bool firstTime;
  static final String id = "edit_profile";

  EditProfileScreen({required this.firstTime});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

enum DayNight { Day, Night }

enum InOut { StayingIn, GoingOut }

enum Smoking { Yes, No }

enum Alcohol { Yes, No }

enum Veg { veg, Nonveg }

var username = TextEditingController();
var age = TextEditingController();

var university = TextEditingController();

var nationality = TextEditingController();

var course = TextEditingController();

List<String> _selectedItems = [];
String _gender = "Male";
bool _validateusername = false;
bool _validateage = false;
bool _validateuni = false;
bool _validatenationality = false;
bool _validatecourse = false;
String dropdownValue = 'Year One';

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool showSpinner = false;
  String filePath = "";
  String fileName = "";

  late DayNight? _character;
  late Smoking? _smoking;
  late Alcohol _alcohol;
  late Veg _veg;
  late InOut? _in;

  late DayNight? _characterPref;
  late Smoking? _smokingPref;
  late Alcohol _alcoholPref;
  late Veg _vegPref;
  late InOut? _inPref;

  // ignore: must_call_super
  void initState() {
    _character = widget.firstTime
        ? DayNight.Day
        : CurrentUser().dayPerson
            ? DayNight.Day
            : DayNight.Night;

    _smoking = widget.firstTime
        ? Smoking.No
        : CurrentUser().smoker
            ? Smoking.Yes
            : Smoking.No;
    _alcohol = widget.firstTime
        ? Alcohol.No
        : CurrentUser().alcohol
            ? Alcohol.Yes
            : Alcohol.No;
    _veg = widget.firstTime
        ? Veg.veg
        : CurrentUser().vegetarian
            ? Veg.veg
            : Veg.Nonveg;

    _in = widget.firstTime
        ? InOut.StayingIn
        : CurrentUser().stayingIn
            ? InOut.StayingIn
            : InOut.GoingOut;

    _characterPref = widget.firstTime
        ? DayNight.Day
        : CurrentUser().dayPersonPref
            ? DayNight.Day
            : DayNight.Night;

    _smokingPref = widget.firstTime
        ? Smoking.No
        : CurrentUser().smokePref
            ? Smoking.Yes
            : Smoking.No;
    _alcoholPref = widget.firstTime
        ? Alcohol.No
        : CurrentUser().alcoholPref
            ? Alcohol.Yes
            : Alcohol.No;
    _vegPref = widget.firstTime
        ? Veg.veg
        : CurrentUser().vegPref
            ? Veg.veg
            : Veg.Nonveg;

    _inPref = widget.firstTime
        ? InOut.StayingIn
        : CurrentUser().stayingInPref
            ? InOut.StayingIn
            : InOut.GoingOut;

    username = widget.firstTime
        ? TextEditingController()
        : TextEditingController(text: CurrentUser().name);
    age = widget.firstTime
        ? TextEditingController()
        : TextEditingController(text: CurrentUser().age.toString());
    university = widget.firstTime
        ? TextEditingController()
        : TextEditingController(text: CurrentUser().universityName);
    nationality = widget.firstTime
        ? TextEditingController()
        : TextEditingController(text: CurrentUser().nationality);
    course = widget.firstTime
        ? TextEditingController()
        : TextEditingController(text: CurrentUser().course);

    _gender = widget.firstTime ? "Male" : CurrentUser().gender;
  }

  void onSubmit() async {
    setState(() {
      showSpinner = true;
      username.text.isEmpty
          ? _validateusername = true
          : _validateusername = false;
      age.text.isEmpty ? _validateage = true : _validateage = false;
      university.text.isEmpty ? _validateuni = true : _validateuni = false;
      nationality.text.isEmpty
          ? _validatenationality = true
          : _validatenationality = false;
      course.text.isEmpty ? _validatecourse = true : _validatecourse = false;
    });

    var downloadURL = "";
    if (filePath != "") {
      await ProfilePicController().uploadFile(CurrentUser().username, filePath);
      downloadURL =
          await ProfilePicController().downloadURL(CurrentUser().username);
    }
    CurrentUser().profilePicURL = downloadURL;
    //await MatchController().editProfilePic(CurrentUser().username, downloadURL);
    if ((_validateusername == false) &&
        (_validateuni == false) &&
        (_validatenationality == false) &&
        (_validateage == false) &&
        (_validatecourse == false) &&
        _selectedItems.isEmpty == false) {
      // Parallel Execution
      await Future.wait(
        [
          UserController().setUserProfile(
              CurrentUser().email,
              username.text,
              CurrentUser().username,
              _gender,
              course.text,
              university.text,
              nationality.text,
              int.parse(age.text),
              _smoking == Smoking.Yes,
              _alcohol == Alcohol.Yes,
              _character == DayNight.Day,
              _veg == Veg.veg,
              _in == InOut.StayingIn,
              _selectedItems,
              downloadURL),
          PreferencesController().setPreferences(
            CurrentUser().email,
            CurrentUser().username,
            _smokingPref == Smoking.Yes,
            _alcoholPref == Alcohol.Yes,
            _characterPref == DayNight.Day,
            _inPref == InOut.StayingIn,
            _vegPref == Veg.veg,
          )
        ],
      );

      // Set Singelton User Object
      CurrentUser currentUser = CurrentUser();
      currentUser.name = username.text;
      currentUser.age = int.parse(age.text);
      currentUser.gender = _gender;
      currentUser.universityName = university.text;
      currentUser.course = course.text;
      currentUser.smoker = _smoking == Smoking.Yes;
      currentUser.alcohol = _alcohol == Alcohol.Yes;
      currentUser.dayPerson = _character == DayNight.Day;
      currentUser.interests = _selectedItems;
      currentUser.stayinIn = _in == InOut.StayingIn;
      currentUser.vegetarian = _veg == Veg.veg;
      currentUser.nationality = nationality.text;

      currentUser.smokePref = _smokingPref == Smoking.Yes;
      currentUser.alcoholPref = _alcoholPref == Alcohol.Yes;
      currentUser.dayPersonPref = _characterPref == DayNight.Day;
      currentUser.stayinInPref = _inPref == InOut.StayingIn;
      currentUser.vegPref = _vegPref == Veg.veg;
      Navigator.pushNamed(context, RecommendationScreen.id);
    }
    setState(() {
      showSpinner = false;
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
    // Map temp = ModalRoute.of(context)?.settings.arguments as Map;
    // bool firstTime = temp['firstTime'];

    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.teal,
          elevation: 5.0,
          title: Text('Preferences'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: new Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Text('Enter your profile details',
                      style: kLargeBoldText, textAlign: TextAlign.center),
                  SizedBox(height: 10.0),
                  //Username
                  GestureDetector(
                    onTap: () {
                      addProfilePicture();
                    },
                    child: CircleAvatar(
                      backgroundImage: (filePath != "")
                          ? Image.file(
                              File(filePath),
                              fit: BoxFit.cover,
                            ).image
                          : (widget.firstTime)
                              ? AssetImage('assets/hasbullah.jpeg')
                                  as ImageProvider
                              : NetworkImage(CurrentUser().profilePicURL),
                      radius: 50,
                    ),
                  ),
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
                  Row(
                    children: <Widget>[
                      SizedBox(width: 20.0),
                      Icon(Icons.home_work_outlined),
                      SizedBox(width: 20.0),
                      Text('Enter your year of study',
                          style:
                              TextStyle(color: Colors.black, fontSize: 15.0)),
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
                          setState(
                            () {
                              dropdownValue = newValue!;
                            },
                          );
                        },
                        items: <String>[
                          'Year One',
                          'Year Two',
                          'Year Three',
                          'Year Four',
                          'Year Five'
                        ].map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                  ListTile(leading: Icon(gender), title: Text('Gender')),
                  ListTile(
                    title: Text('Male'),
                    leading: Radio<String>(
                      value: "Male",
                      groupValue: _gender,
                      activeColor: Colors.black,
                      onChanged: (String? value) {
                        setState(
                          () {
                            _gender = value!;
                          },
                        );
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
                        setState(
                          () {
                            _gender = value!;
                          },
                        );
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
                        setState(
                          () {
                            _gender = value!;
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text('Enter your profile',
                      style: kLargeBoldText, textAlign: TextAlign.center),
                  SizedBox(height: 30),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: new Text('What are your top interests?'),
                  ),
                  DropDownMultiSelect(
                    onChanged: (List<String> x) {
                      setState(
                        () {
                          _selectedItems = x;
                        },
                      );
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
                        setState(
                          () {
                            _character = value;
                          },
                        );
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
                        setState(
                          () {
                            _character = value;
                          },
                        );
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
                        setState(
                          () {
                            _in = value;
                          },
                        );
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
                        setState(
                          () {
                            _in = value;
                          },
                        );
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
                        setState(
                          () {
                            _veg = value!;
                          },
                        );
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
                        setState(
                          () {
                            _veg = value!;
                          },
                        );
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
                        setState(
                          () {
                            _alcohol = value!;
                          },
                        );
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
                        setState(
                          () {
                            _alcohol = value!;
                          },
                        );
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
                        setState(
                          () {
                            _smoking = value;
                          },
                        );
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
                        setState(
                          () {
                            _smoking = value;
                          },
                        );
                      },
                    ),
                  ),
                  Text(
                      'Complete these statements for us to better understand your preferences',
                      style: kLargeBoldText,
                      textAlign: TextAlign.center),
                  ListTile(
                      leading: Icon(Icons.adb_outlined),
                      title: Text('My ideal roommate would be')),
                  ListTile(
                    title: Text('Vegetarian'),
                    leading: Radio<Veg>(
                      value: Veg.veg,
                      groupValue: _vegPref,
                      activeColor: Colors.black,
                      onChanged: (Veg? value) {
                        setState(
                          () {
                            _vegPref = value!;
                          },
                        );
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Non-vegetarian'),
                    leading: Radio<Veg>(
                      value: Veg.Nonveg,
                      groupValue: _vegPref,
                      activeColor: Colors.black,
                      onChanged: (Veg? value) {
                        setState(
                          () {
                            _vegPref = value!;
                          },
                        );
                      },
                    ),
                  ),
                  ListTile(
                      leading: Icon(Icons.no_drinks),
                      title: Text('I prefer a roommate who drinks')),
                  ListTile(
                    title: Text('Yes'),
                    leading: Radio<Alcohol>(
                      value: Alcohol.Yes,
                      groupValue: _alcoholPref,
                      activeColor: Colors.black,
                      onChanged: (Alcohol? value) {
                        setState(
                          () {
                            _alcoholPref = value!;
                          },
                        );
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('No'),
                    leading: Radio<Alcohol>(
                      value: Alcohol.No,
                      groupValue: _alcoholPref,
                      activeColor: Colors.black,
                      onChanged: (Alcohol? value) {
                        setState(
                          () {
                            _alcoholPref = value!;
                          },
                        );
                      },
                    ),
                  ),
                  ListTile(
                      leading: Icon(Icons.smoke_free),
                      title: Text('I do not mind a roommate who smokes')),
                  ListTile(
                    title: Text('Yes'),
                    leading: Radio<Smoking>(
                      value: Smoking.Yes,
                      groupValue: _smokingPref,
                      activeColor: Colors.black,
                      onChanged: (Smoking? value) {
                        setState(
                          () {
                            _smokingPref = value;
                          },
                        );
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('No'),
                    leading: Radio<Smoking>(
                      value: Smoking.No,
                      groupValue: _smokingPref,
                      activeColor: Colors.black,
                      onChanged: (Smoking? value) {
                        setState(
                          () {
                            _smokingPref = value;
                          },
                        );
                      },
                    ),
                  ),
                  ListTile(
                      leading: Icon(Icons.wb_sunny_rounded),
                      title: Text('I prefer a roommate who is a ')),
                  ListTile(
                    title: Text('Day Person'),
                    leading: Radio<DayNight>(
                      value: DayNight.Day,
                      groupValue: _characterPref,
                      activeColor: Colors.black,
                      onChanged: (DayNight? value) {
                        setState(
                          () {
                            _characterPref = value;
                          },
                        );
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Night Person'),
                    leading: Radio<DayNight>(
                      value: DayNight.Night,
                      groupValue: _characterPref,
                      activeColor: Colors.black,
                      onChanged: (DayNight? value) {
                        setState(
                          () {
                            _characterPref = value;
                          },
                        );
                      },
                    ),
                  ),
                  ListTile(
                      leading: Icon(Icons.beach_access),
                      title: Text('I prefer a roommate who would like')),
                  ListTile(
                    title: Text('Staying in'),
                    leading: Radio<InOut>(
                      value: InOut.StayingIn,
                      groupValue: _inPref,
                      activeColor: Colors.black,
                      onChanged: (InOut? value) {
                        setState(
                          () {
                            _inPref = value;
                          },
                        );
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Going out'),
                    leading: Radio<InOut>(
                      value: InOut.GoingOut,
                      groupValue: _inPref,
                      activeColor: Colors.black,
                      onChanged: (InOut? value) {
                        setState(
                          () {
                            _inPref = value;
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                      ),
                      onPressed: (onSubmit),
                      child: Text(
                          widget.firstTime
                              ? 'Create'
                              : 'Edit Profile Preferences',
                          style: kMediumText)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  addProfilePicture() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg']);

    if (result == null) {
      print('No File has been picked');
      return;
    }

    setState(() {
      filePath = result.files.single.path!;
      fileName = result.files.single.name;
    });

    print(filePath);
    print(fileName);
  }
}
