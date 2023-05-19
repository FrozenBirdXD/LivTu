import 'package:livtu/services/auth/auth_user.dart';

class GlobalUser {
  final AuthUser user;
  final String? iconURL;
  final String? description;

  GlobalUser({
    required this.user,
    required this.iconURL,
    required this.description,
  });
}
