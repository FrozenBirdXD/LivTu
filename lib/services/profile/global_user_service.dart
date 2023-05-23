import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:livtu/services/auth/auth_service.dart';
import 'package:livtu/services/profile/global_user.dart';
import 'package:livtu/services/profile/global_user_constants.dart';
import 'package:livtu/services/profile/global_user_exceptions.dart';

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

  Future<GlobalUser> createNewUser() async {
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
