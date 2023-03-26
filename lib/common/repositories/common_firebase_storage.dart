// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commonFirebaseStorageRepositoryProvider =
    Provider((ref) => CommonFirebaseStorage(storage: FirebaseStorage.instance));

class CommonFirebaseStorage {
  final FirebaseStorage storage;
  CommonFirebaseStorage({
    required this.storage,
  });

  Future<String> storeFileToFirebase(String ref, File file) async {
    UploadTask uploadTask = storage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }
}
