import 'package:flutter/material.dart';
import 'package:morph_wallet/widgets/commons/morph_color.dart';

Future<dynamic>? modalBottomSheet(
    {required BuildContext context,
    required Widget title,
    required Widget child,
    required Widget bottomContent,
    double? heightFactor = 0.85}) {
  return showModalBottomSheet(
    context: context,
    elevation: 0,
    backgroundColor: MorphColor.darkColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: heightFactor,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [title, child, bottomContent],
          ),
        ),
      );
    },
  );
}
