// ignore_for_file: unnecessary_getters_setters

// Matches of current user. Load after login

class Matches {
  late List<String> _matches;

  List<String> get matches => _matches;

  set matches(List<String> matches) => _matches = matches;

  // Singleton Pattern
  static final Matches _singleton = Matches._internal();

  factory Matches() {
    return _singleton;
  }

  Matches._internal();
}
