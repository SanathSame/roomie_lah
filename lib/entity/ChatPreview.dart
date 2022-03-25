// ignore_for_file: unnecessary_getters_setters

class ChatPreview {
  late String _username;
  late String _profilePicURL;
  late String _lastMessage;
  late String _timestamp;

  ChatPreview(
      {required String username,
      required String profilePicURL,
      required String lastMessage,
      required String timestamp})
      : _username = username,
        _profilePicURL = profilePicURL,
        _lastMessage = lastMessage,
        _timestamp = timestamp;

  String get username => _username;
  String get profilePicURL => _profilePicURL;
  String get lastMessage => _lastMessage;
  String get timestamp => _timestamp;

  set username(String username) => _username = username;
  set profilePicURL(String profilePicURL) => _profilePicURL = profilePicURL;
  set lastMessage(String lastMessage) => _lastMessage = lastMessage;
  set timestamp(String timestamp) => _timestamp = timestamp;
}
