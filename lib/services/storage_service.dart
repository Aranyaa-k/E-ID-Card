// ignore_for_file: non_constant_identifier_names

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Storage{
  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  Future<String> downloadURL (String docid, String imgname) async {
    String downloadURL = await storage.ref('Students/$docid/$imgname').getDownloadURL();
    return downloadURL;
  }
}