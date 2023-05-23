import 'package:flutter/material.dart';
import 'package:livtu/services/profile/global_user_exceptions.dart';
import 'package:livtu/services/profile/global_user_service.dart';
import 'package:livtu/utils/dialogs/error_dialog.dart';

Future<String> getUserName(BuildContext context) async {
  GlobalUserService userService = GlobalUserService();
    try {
      String displayName = await userService.getDisplayName();
      if (displayName.isEmpty) {
        return 'username not set';
      } else {
        return displayName;
      }
    } on GlobalUserException {
      await showErrorDialog(context, 'Username not found');
      throw CouldNotGetDisplayName();
    }
  }