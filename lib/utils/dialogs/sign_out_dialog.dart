import 'package:flutter/material.dart';
import 'package:livtu/utils/dialogs/generic_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<bool> showSignOutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: AppLocalizations.of(context)!.signOut,
    content: AppLocalizations.of(context)!.signOutConformation,
    optionBuilder: () => {
      AppLocalizations.of(context)!.cancel: false,
      AppLocalizations.of(context)!.signOut: true,
    },
  ).then(
    (value) => value ?? false,
  );
}
