import 'package:livtu/services/profile/global_user_exceptions.dart';
import 'package:livtu/services/profile/global_user_service.dart';

Future<String> getUserName() async {
  GlobalUserService userService = GlobalUserService();
  try {
    String displayName = await userService.getDisplayName();
    if (displayName.isEmpty) {
      return 'username not set';
    } else {
      return displayName;
    }
  } on GlobalUserException {
    throw CouldNotGetDisplayName();
  }
}

Future<String> getIconURL() async {
  GlobalUserService userService = GlobalUserService();
  try {
    String iconURL = await userService.getIconURL();
    if (iconURL.isEmpty) {
      return 'https://firebasestorage.googleapis.com/v0/b/livtu-flutter.appspot.com/o/profile_images%2Fdefault%20icon.png?alt=media&token=c33ce1c3-f961-4c3e-ae7d-41da985659d9';
    } else {
      return iconURL;
    }
  } on GlobalUserException {
    throw CouldNotGetIconURL();
  }
}
