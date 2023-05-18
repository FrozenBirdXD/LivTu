import 'package:firebase_auth/firebase_auth.dart' as firebaseauth show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final String email;
  final bool isEmailVerified;
  final String id;
  final String? displayName;
  final String? photoURL;
  const AuthUser({
    required this.isEmailVerified,
    required this.email,
    required this.id,
    required this.displayName,
    required this.photoURL,
  });

  factory AuthUser.fromFirebase(firebaseauth.User user) => AuthUser(
        isEmailVerified: user.emailVerified,
        email: user.email!,
        id: user.uid,
        displayName: user.displayName,
        photoURL: user.photoURL,
      );
}
