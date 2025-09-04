import 'package:flutter/material.dart';

/// Shows a reusable permission dialog and returns true if the user allows, false if denied, or null if dismissed.
Future<bool?> showPermissionDialog({
  required BuildContext context,
  required String title,
  required String content,
  String?denyText,
  String allowText = 'Allow',
}) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
         denyText!=null? TextButton(
            onPressed: () {
              Navigator.of(dialogContext, rootNavigator: true).pop(false);
            },
            child: Text(denyText),
          ):SizedBox(),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext, rootNavigator: true).pop(true);
            },
            child: Text(allowText),
          ),
        ],
      );
    },
  );
}

