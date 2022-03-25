// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/cupertino.dart';

class CurrentUser {
  late String _name;
  late String _email;
  late String _username;
  late int _age;
  late String _universityName;
  late String _tagLine;
  late String _profilePictureURL;
  late List<String> _tags;

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
  String get tagLine => _tagLine;
  String get profilePicURL => _profilePictureURL;
  List<String> get tags => _tags;

  set name(String name) {
    _name = name;
  }

  set username(String userName) {
    _username = userName;
  }

  set age(int age) {
    _age = age;
  }

  set universityName(String universityName) {
    _universityName = universityName;
  }

  set tagLine(String tagLine) {
    _tagLine = tagLine;
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
