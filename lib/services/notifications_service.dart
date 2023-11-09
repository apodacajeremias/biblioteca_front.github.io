import 'package:flutter/material.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.green.withOpacity(0.9),
      content:
          Text(message, style: const TextStyle(color: Colors.white, fontSize: 20)),
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }

  static showSnackbarError(String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red.withOpacity(0.9),
      content:
          Text(message, style: const TextStyle(color: Colors.white, fontSize: 20)),
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
