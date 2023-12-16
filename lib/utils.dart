import 'dart:developer';
import 'package:flutter/material.dart';

class CustomDialogs {
  static Future<T?> showDefaultAlertDialog<T>(
    BuildContext context, {
    String? contentText,
    String? contentTitle,
  }) async {
    log('ERROR OCCURED');
    log(contentTitle.toString());
    log(contentText.toString());
    return await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(contentTitle ?? ''),
          content: Text(contentText ?? ''),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }
}
