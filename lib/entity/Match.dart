class Match{
  String _user;

  List<String> _matches;

  Match({required String user, required List<String> matches
  }) : _user=user,
  _matches=matches;

  get user => _user;
  get matches => _matches;
}