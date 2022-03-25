// ignore_for_file: unnecessary_getters_setters

// Matches of current user. Load after login

import 'package:roomie_lah/widgets/chat_preview.dart';

class ChatPreviewList {
  late List<ChatPreview> _chatpreviews;

  List<ChatPreview> get chatpreviews => _chatpreviews;

  // ignore: non_constant_identifier_names
  set matches(List<ChatPreview> chatpreviews) => _chatpreviews = chatpreviews;

  static final ChatPreviewList _singleton = ChatPreviewList._internal();

  factory ChatPreviewList() {
    return _singleton;
  }

  ChatPreviewList._internal();
}
