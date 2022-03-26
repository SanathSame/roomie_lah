// ignore_for_file: unnecessary_getters_setters

// Matches of current user. Load after login

class Matches {
  late List<dynamic>? _matches;
  List<dynamic>? get matches => _matches;

  set matches(List<dynamic>? matches) => _matches = matches;
  // Singleton Pattern
  static final Matches _singleton = Matches._internal();

  factory Matches() {
    return _singleton;
  }

  Matches._internal();
}
