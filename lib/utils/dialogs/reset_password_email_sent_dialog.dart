import 'package:flutter/material.dart';
import 'package:livtu/utils/dialogs/generic_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> showResetPasswordEmailSentDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: AppLocalizations.of(context)!.passwordResetEmailSent,
    content: AppLocalizations.of(context)!.passwordResetInstructions,
    optionBuilder: () => {
      'OK': null,
    },
  );
}
