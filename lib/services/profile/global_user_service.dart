import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:livtu/services/profile/global_user.dart';
import 'package:livtu/services/profile/global_user_constants.dart';
import 'package:livtu/services/profile/global_user_exceptions.dart';

class GlobalUserService {
  final users = FirebaseFirestore.instance.collection('users');

  // singleton
  static final GlobalUserService _shared = GlobalUserService._sharedInstance();
  GlobalUserService._sharedInstance();
  factory GlobalUserService() => _shared;

  Future<String> getDocumentId({required String userId}) async {
    QuerySnapshot querySnapshot = await users.where(userIdFieldName, isEqualTo: userId).get();
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
    } else {
      throw GlobalUserNotFound();
    }
  }

  Stream<Iterable<GlobalUser>> getGlobalUser({required String userId}) {
    return users
        .where(userIdFieldName, isEqualTo: userId)
        .snapshots()
        .map((event) => event.docs.map((doc) => GlobalUser.fromSnapshot(doc)));
  }

  Future<void> updatePhotoURL({
    required String documentId,
    required String url,
  }) async {
    try {
      await users.doc(documentId).update({photoURLFieldName: url});
    } catch (e) {
      throw CouldNotUpdatePhotoURL();
    }
  }

  Future<void> updateDisplayName({
    required String documentId,
    required String name,
  }) async {
    try {
      await users.doc(documentId).update({displayNameFieldName: name});
    } catch (e) {
      throw CouldNotUpdateDisplayName();
    }
  }

  Future<void> updateIconURL({
    required String documentId,
    required String url,
  }) async {
    try {
      await users.doc(documentId).update({iconURLFieldName: url});
    } catch (e) {
      throw CloudNotUpdateIconURL();
    }
  }

  Future<void> updateDescription({
    required String documentId,
    required String description,
  }) async {
    try {
      await users.doc(documentId).update({descriptionFieldName: description});
    } catch (e) {
      throw CouldNotUpdateDescription();
    }
  }

  Future<GlobalUser> createNewUser({required String userId}) async {
    final doc = await users.add({
      userIdFieldName: userId,
      photoURLFieldName: '',
      displayNameFieldName: '',
      iconURLFieldName: '',
      descriptionFieldName: '',
    });
    final user = await doc.get();
    return GlobalUser(
      documentId: user.id,
      userId: userId,
      description: '',
      iconURL: '',
      displayName: '',
      photoURL: '',
    );
  }
}
