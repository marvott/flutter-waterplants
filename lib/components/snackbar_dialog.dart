import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(BuildContext context,
          {required String message, Color? color}) =>
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(
            message,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          duration: const Duration(seconds: 2),
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0, // Inner padding for SnackBar content.
          ),
          backgroundColor: color ?? Colors.grey.shade700,
        ));
}
