// ignore_for_file: unnecessary_getters_setters

// Matches of current user. Load after login

import 'package:roomie_lah/entity/ChatPreview.dart';
import 'package:roomie_lah/entity/ChatPreview.dart';

class ChatPreviewList {
  List<ChatPreview> _chatpreviews = [];

  List<ChatPreview> get chatpreviews => _chatpreviews;

  // ignore: non_constant_identifier_names
  set chatpreviews(List<ChatPreview> chatpreviews) =>
      _chatpreviews = chatpreviews;

  // singleton pattern
  static final ChatPreviewList _singleton = ChatPreviewList._internal();

  factory ChatPreviewList() {
    return _singleton;
  }

  ChatPreviewList._internal();

  void addChatPreview(String username, String profilePicURL, String lastMessage,
      String timestamp) {
    _singleton.chatpreviews.add(ChatPreview(
        username: username,
        profilePicURL: profilePicURL,
        lastMessage: lastMessage,
        timestamp: timestamp));
  }
}
