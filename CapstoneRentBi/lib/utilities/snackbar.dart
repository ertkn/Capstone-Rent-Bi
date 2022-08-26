import 'package:flutter/material.dart';

class SnackBarMessage {
  static void showSnackBar(
    BuildContext context, {
    required String text,
  }) {
    // Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}