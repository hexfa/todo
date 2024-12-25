import 'package:flutter/material.dart';

Future<void> showCustomDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String cancelText,
  required String confirmText,
  required VoidCallback onConfirm,
  Color? primaryColor, // Optional for custom color
}) async {
  final theme = Theme.of(context); // To use the theme
  return showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(
          title,
          style: TextStyle(color: primaryColor ?? theme.colorScheme.primary),
        ),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
            child: Text(
              cancelText,
              style:
                  TextStyle(color: primaryColor ?? theme.colorScheme.primary),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              onConfirm(); // Execute confirmation action
            },
            child: Text(
              confirmText,
              style:
                  TextStyle(color: primaryColor ?? theme.colorScheme.primary),
            ),
          ),
        ],
      );
    },
  );
}
