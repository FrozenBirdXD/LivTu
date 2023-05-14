import 'package:flutter/material.dart';
import 'package:livtu/utils/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: 'Oh no, an error has occurred!',
    content: text,
    optionBuilder: () => {
      'OK': null,
    },
  );
}
