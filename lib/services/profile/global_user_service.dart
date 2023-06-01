import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:livtu/services/auth/auth_service.dart';
import 'package:livtu/services/profile/global_user.dart';
import 'package:livtu/services/profile/global_user_constants.dart';
import 'package:livtu/services/profile/global_user_exceptions.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class GlobalUserService {
  String? userId;
  final users = FirebaseFirestore.instance.collection('users');

  // singleton
  static final GlobalUserService _shared = GlobalUserService._sharedInstance();
  GlobalUserService._sharedInstance();
  factory GlobalUserService() => _shared;

  Future<String> getDisplayName() async {
    try {
      userId = AuthService.firebase().currentUser!.id;

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

  Stream<List<String>> getSubjectsStream() {
    userId = AuthService.firebase().currentUser!.id;

    return users
        .where(userIdFieldName, isEqualTo: userId)
        .snapshots()
        .map((event) => event.docs.first)
        .map((doc) => List<String>.from(doc.data()[subjectsFieldName] ?? []));
  }

  Stream<String> getIconURLStream() {
    userId = AuthService.firebase().currentUser!.id;

    return users
        .where(userIdFieldName, isEqualTo: userId)
        .snapshots()
        .map((event) => event.docs.first)
        .map((doc) => doc.data()[iconURLFieldName] ?? '');
  }

  Stream<String> getDescriptionStream() {
    userId = AuthService.firebase().currentUser!.id;

    return users
        .where(userIdFieldName, isEqualTo: userId)
        .snapshots()
        .map((event) => event.docs.first)
        .map((doc) => doc.data()[descriptionFieldName] ?? '');
  }

  Stream<String> getDisplayNameStream() {
    userId = AuthService.firebase().currentUser!.id;

    return users
        .where(userIdFieldName, isEqualTo: userId)
        .snapshots()
        .map((event) => event.docs.first)
        .map((doc) => doc.data()[displayNameFieldName] ?? '');
  }

  Stream<String> getPhotoURLStream() {
    userId = AuthService.firebase().currentUser!.id;

    return users
        .where(userIdFieldName, isEqualTo: userId)
        .snapshots()
        .map((event) => event.docs.first)
        .map((doc) => doc.data()[photoURLFieldName] ?? '');
  }

  Future<String> getIconURL() async {
    userId = AuthService.firebase().currentUser!.id;

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
    userId = AuthService.firebase().currentUser!.id;

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
    userId = AuthService.firebase().currentUser!.id;

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
    userId = AuthService.firebase().currentUser!.id;

    QuerySnapshot querySnapshot =
        await users.where(userIdFieldName, isEqualTo: userId).get();
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
    } else {
      throw GlobalUserNotFound();
    }
  }

  Stream<Iterable<GlobalUser>> getGlobalUser() {
    userId = AuthService.firebase().currentUser!.id;

    return users
        .where(userIdFieldName, isEqualTo: userId)
        .snapshots()
        .map((event) => event.docs.map((doc) => GlobalUser.fromSnapshot(doc)));
  }

  Future<void> updatePhotoURL({
    required String url,
  }) async {
    userId = AuthService.firebase().currentUser!.id;

    try {
      String documentId = await getDocumentId();
      await users.doc(documentId).update({photoURLFieldName: url});
    } catch (e) {
      throw CouldNotUpdatePhotoURL();
    }
  }

  Future<void> updateSubjects({
    required List<String> subjects,
  }) async {
    userId = AuthService.firebase().currentUser!.id;

    try {
      String documentId = await getDocumentId();
      await users.doc(documentId).update({subjectsFieldName: subjects});
    } catch (e) {
      throw CouldNotUpdatePhotoURL();
    }
  }

  Future<void> updateDisplayName({
    required String name,
  }) async {
    userId = AuthService.firebase().currentUser!.id;

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
    userId = AuthService.firebase().currentUser!.id;

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
    userId = AuthService.firebase().currentUser!.id;

    try {
      String documentId = await getDocumentId();
      await users.doc(documentId).update({descriptionFieldName: description});
    } catch (e) {
      throw CouldNotUpdateDescription();
    }
  }

  Future<GlobalUser> createNewUser({required String newUserId}) async {
    userId = AuthService.firebase().currentUser!.id;

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
      description:
          'Write a brief introduction here - interests, academic background...',
      iconURL: '',
      displayName: '',
      photoURL: '',
      subjects: [''],
    );
  }
}
