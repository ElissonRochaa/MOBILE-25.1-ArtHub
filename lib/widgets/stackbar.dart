import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message) {
  final theme = Theme.of(context);
  Color bgColor;

  bgColor = Theme.of(context).colorScheme.surface;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: theme.colorScheme.tertiary,
          fontWeight: theme.textTheme.bodySmall?.fontWeight,
        ),
      ),
      backgroundColor: bgColor,
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.all(30),
      elevation: 20,
    ),
  );
}
