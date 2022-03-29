// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/cupertino.dart';

class User {
  late String _name;
  late String _email;
  late String _username;
  late int _age;
  late String _gender;
  late String _universityName;
  late String _profilePictureURL;
  late List<String> _interests;
  late bool _smoker;
  late bool _drinker;
  late bool _dayPerson;
  late bool _vegetarian;
  late bool _alcohol;
  late String _course;
  late String _nationality;
  late bool _stayingIn;

  // preferences below
  late bool _stayingInPref;
  late bool _smokePref;
  late bool _alcoholPref;
  late bool _vegPref;
  late bool _dayPersonPref;

  // Singleton Pattern
  static final User _singleton = User._internal();

  factory User() {
    return _singleton;
  }

  User._internal();

  String get email => _email;
  String get name => _name;
  String get username => _username;
  int get age => _age;
  String get universityName => _universityName;
  String get course => _course;
  String get nationality => _nationality;
  String get profilePicURL => _profilePictureURL;
  List<String> get interests => _interests;
  bool get smoker => _smoker;
  bool get drinker => _drinker;
  bool get dayPerson => _dayPerson;
  String get gender => _gender;
  bool get alcohol => _alcohol;
  bool get vegetarian => _vegetarian;
  bool get stayingIn => _stayingIn;

  // Preference below

  bool get stayingInPref => _stayingInPref;
  bool get smokePref => _smokePref;
  bool get alcoholPref => _alcoholPref;
  bool get dayPersonPref => _dayPersonPref;
  bool get vegPref => _vegPref;

  set name(String name) {
    _name = name;
  }

  set vegetarian(bool vegetarian) {
    _vegetarian = vegetarian;
  }

  set username(String userName) {
    _username = userName;
  }

  set stayinIn(bool stayingIn) {
    _stayingIn = stayingIn;
  }

  set age(int age) {
    _age = age;
  }

  set course(String course) {
    _course = course;
  }

  set gender(String gender) {
    _gender = gender;
  }

  set alcohol(bool alcohol) {
    _alcohol = alcohol;
  }

  set universityName(String universityName) {
    _universityName = universityName;
  }

  set nationality(String nationality) {
    _nationality = nationality;
  }

  set drinker(bool drinker) {
    _drinker = drinker;
  }

  set smoker(bool smoker) {
    _smoker = smoker;
  }

  set dayPerson(bool dayPerson) {
    _dayPerson = dayPerson;
  }

  set profilePicURL(String profilePictureURL) {
    _profilePictureURL = profilePictureURL;
  }

  set interests(List<String> interests) {
    _interests = interests;
  }

  set email(String email) {
    _email = email;
  }

  // Preferences

  set stayinInPref(bool stayingInPref) {
    _stayingInPref = stayingInPref;
  }

  set dayPersonPref(bool dayPersonPref) {
    _dayPersonPref = dayPersonPref;
  }

  set smokePref(bool smokePref) {
    _smokePref = smokePref;
  }

  set alcoholPref(bool alcoholPref) {
    _alcoholPref = alcoholPref;
  }

  set vegPref(bool vegPref) {
    _vegPref = vegPref;
  }
}
