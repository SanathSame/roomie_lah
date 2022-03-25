// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:file_picker/file_picker.dart';

class ProfilePicController {
  static FirebaseStorage imageStorage = FirebaseStorage.instance;

  Future<void> selectFile() async {}

  Future<void> uploadFile(String username, String filePath) async {
    File file = new File(filePath);

    try {
      await imageStorage.ref('profilePic/$username').putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<ListResult> listFiles() async {
    ListResult result = await imageStorage.ref('profilePic').listAll();

    result.items.forEach((element) {
      print('Found File: $element');
    });
    return result;
  }

  Future<String> downloadURL(String username) async {
    String url = "";
    print('Trying');
    try {
      url = await imageStorage.ref('profilePic/$username').getDownloadURL();
      print('Succeeded');
      // ignore: non_constant_identifier_names
    } catch (StorageException) {
      url = "";
      print('Failed');
    }

    print('Done');
    return url;
  }
}

void main() {}
