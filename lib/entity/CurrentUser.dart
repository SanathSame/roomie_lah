// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/cupertino.dart';

class CurrentUser {
  late String _name;
  late String _email;
  late String _username;
  late int _age;
  late String _gender;
  late String _universityName;
  late String _profilePictureURL;
  late List<String> _tags;
  late bool _smoker;
  late bool _drinker;
  late bool _dayPerson;

  // Singleton Pattern
  static final CurrentUser _singleton = CurrentUser._internal();

  factory CurrentUser() {
    return _singleton;
  }

  CurrentUser._internal();

  String get email => _email;
  String get name => _name;
  String get username => _username;
  int get age => _age;
  String get universityName => _universityName;
  String get profilePicURL => _profilePictureURL;
  List<String> get tags => _tags;
  bool get smoker => _smoker;
  bool get drinker => _drinker;
  bool get dayPerson => _dayPerson;
  String get gender => _gender;

  set name(String name) {
    _name = name;
  }

  set username(String userName) {
    _username = userName;
  }

  set age(int age) {
    _age = age;
  }

  set gender(String gender) {
    _gender = gender;
  }

  set universityName(String universityName) {
    _universityName = universityName;
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

  set tags(List<String> tags) {
    _tags = tags;
  }

  set email(String email) {
    _email = email;
  }
}
