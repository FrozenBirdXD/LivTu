import 'package:flutter/material.dart';
import 'package:livtu/utils/dialogs/generic_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: AppLocalizations.of(context)!.ohNoError,
    content: text,
    optionBuilder: () => {
      'OK': null,
    },
  );
}
