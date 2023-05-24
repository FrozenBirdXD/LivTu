import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:livtu/services/auth/auth_service.dart';
import 'package:livtu/services/profile/global_user.dart';
import 'package:livtu/services/profile/global_user_constants.dart';
import 'package:livtu/services/profile/global_user_exceptions.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class GlobalUserService {
  String userId = AuthService.firebase().currentUser!.id;
  final users = FirebaseFirestore.instance.collection('users');

  // singleton
  static final GlobalUserService _shared = GlobalUserService._sharedInstance();
  GlobalUserService._sharedInstance();
  factory GlobalUserService() => _shared;

  Future<String> getDisplayName() async {
    try {
      String documentId = await getDocumentId();
      DocumentSnapshot snapshot = await users.doc(documentId).get();
      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          return data[displayNameFieldName] ?? '';
        }
      }
      throw GlobalUserNotFound();
    } catch (e) {
      throw CouldNotGetDisplayName();
    }
  }

  Stream<String> getIconURLStream() {
    return users
        .where(userIdFieldName, isEqualTo: userId)
        .snapshots()
        .map((event) => event.docs.first)
        .map((doc) => doc.data()[iconURLFieldName] ?? '');
  }

  Stream<String> getDisplayNameStream() {
    return users
        .where(userIdFieldName, isEqualTo: userId)
        .snapshots()
        .map((event) => event.docs.first)
        .map((doc) => doc.data()[displayNameFieldName] ?? '');
  }

  Stream<String> getPhotoURLStream() {
    return users
        .where(userIdFieldName, isEqualTo: userId)
        .snapshots()
        .map((event) => event.docs.first)
        .map((doc) => doc.data()[photoURLFieldName] ?? '');
  }

  Future<String> getIconURL() async {
    try {
      String documentId = await getDocumentId();
      DocumentSnapshot snapshot = await users.doc(documentId).get();
      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          return data[iconURLFieldName] ?? '';
        }
      }
      throw GlobalUserNotFound();
    } catch (e) {
      throw CouldNotGetIconURL();
    }
  }

  Future<String> uploadProfileBackgroundToStorage(XFile pickedImage) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      firebase_storage.Reference storageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('profile_background/$fileName');

      await storageRef.putFile(File(pickedImage.path));

      String downloadURL = await storageRef.getDownloadURL();

      return downloadURL;
    } catch (e) {
      throw CouldNotUploadImage();
    }
  }

  Future<String> uploadProfileIconToStorage(XFile pickedImage) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      firebase_storage.Reference storageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('profile_images/$fileName');

      await storageRef.putFile(File(pickedImage.path));

      String downloadURL = await storageRef.getDownloadURL();

      return downloadURL;
    } catch (e) {
      throw CouldNotUploadImage();
    }
  }

  Future<String> getDocumentId() async {
    QuerySnapshot querySnapshot =
        await users.where(userIdFieldName, isEqualTo: userId).get();
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
    } else {
      throw GlobalUserNotFound();
    }
  }

  Stream<Iterable<GlobalUser>> getGlobalUser() {
    return users
        .where(userIdFieldName, isEqualTo: userId)
        .snapshots()
        .map((event) => event.docs.map((doc) => GlobalUser.fromSnapshot(doc)));
  }

  Future<void> updatePhotoURL({
    required String url,
  }) async {
    try {
      String documentId = await getDocumentId();
      await users.doc(documentId).update({photoURLFieldName: url});
    } catch (e) {
      throw CouldNotUpdatePhotoURL();
    }
  }

  Future<void> updateDisplayName({
    required String name,
  }) async {
    try {
      String documentId = await getDocumentId();
      await users.doc(documentId).update({displayNameFieldName: name});
    } catch (e) {
      throw CouldNotUpdateDisplayName();
    }
  }

  Future<void> updateIconURL({
    required String url,
  }) async {
    try {
      String documentId = await getDocumentId();
      await users.doc(documentId).update({iconURLFieldName: url});
    } catch (e) {
      throw CloudNotUpdateIconURL();
    }
  }

  Future<void> updateDescription({
    required String description,
  }) async {
    try {
      String documentId = await getDocumentId();
      await users.doc(documentId).update({descriptionFieldName: description});
    } catch (e) {
      throw CouldNotUpdateDescription();
    }
  }

  Future<GlobalUser> createNewUser({required String newUserId}) async {
    final doc = await users.add({
      userIdFieldName: newUserId,
      photoURLFieldName: '',
      displayNameFieldName: '',
      iconURLFieldName: '',
      descriptionFieldName: '',
    });
    final user = await doc.get();
    return GlobalUser(
      documentId: user.id,
      userId: newUserId,
      description: '',
      iconURL: '',
      displayName: '',
      photoURL: '',
    );
  }
}
