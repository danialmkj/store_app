import 'package:flutter/material.dart';

class CustomSnackBar {
  static showsnack(context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message,
          textDirection: TextDirection.rtl,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: color));
  }
}
