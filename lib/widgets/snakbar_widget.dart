import 'package:flutter/material.dart';
import 'package:morph_wallet/widgets/commons/morph_color.dart';

class SnackBarWidget {
  SnackBarWidget._();

  static void show(
    BuildContext context, {
    required String message,
    Color? bgColor = MorphColor.pinkColor,
    int durationInScnd = 2,
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0.0,
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: bgColor,
        duration: Duration(seconds: durationInScnd),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.5)),
        behavior: SnackBarBehavior.floating,
        action: action,
      ),
    );
  }
}