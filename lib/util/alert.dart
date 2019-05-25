///
/// `alert.dart`
/// Utility class contains alerts
/// Source: Copied from my own project, MedicCare. (https://github.com/itforge-eros/MedicCare)
///

import 'package:flutter/material.dart';

class Alert {
  static Future displayAlert(
    BuildContext context, {
    String title = '',
    String content = '',
    String confirm = 'OK',
    Function onPressed,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              child: Text(confirm),
              onPressed: onPressed ??
                  () {
                    Navigator.of(context).pop();
                  },
            )
          ],
        );
      },
    );
  }
}
