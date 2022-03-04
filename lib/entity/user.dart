import 'package:flutter/cupertino.dart';

class User {
  String _fullName;
  String _password;
  int _age;
  String _universityName;
  String _tagLine;
  // Image _profilePicture;
  List<String> _tags;

  User(
      {String fullName,
      String password,
      int age,
      String universityName,
      String tagLine,
      Image profilePicture,
      List<String> tags})
      : _fullName = fullName,
        _password = password,
        _age = age,
        _universityName = universityName,
        _tagLine = tagLine,
        // _profilePicture = profilePicture,
        _tags = tags;

  String get fullname => _fullName;
  String get password => _password;
  int get age => _age;
  String get universityName => _universityName;
  String get tagLine => _tagLine;
  // Image get profilePicture => _profilePicture;
  List<String> get tags => _tags;

  set fullname(String fullName) {
    _fullName = fullName;
  }

  set password(String password) {
    _password = password;
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

  // set profilePicture(Image profilePicture) {
  //   _profilePicture = profilePicture;
  // }

  set tags(List<String> tags) {
    _tags = tags;
  }
}
