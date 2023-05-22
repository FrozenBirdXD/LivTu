import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:livtu/services/profile/global_user_constants.dart';

class GlobalUser {
  final String documentId;
  final String userId;
  final String? photoURL;
  final String? displayName;
  final String? iconURL;
  final String? description;

  GlobalUser({
    required this.photoURL,
    required this.displayName,
    required this.iconURL,
    required this.description, 
    required this.documentId,
    required this.userId,
  });

  GlobalUser.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        userId = snapshot.data()[userIdFieldName],
        photoURL = snapshot.data()[photoURLFieldName],
        displayName = snapshot.data()[displayNameFieldName],
        iconURL = snapshot.data()[iconURLFieldName],
        description = snapshot.data()[descriptionFieldName] as String;
}
