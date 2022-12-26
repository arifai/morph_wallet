import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final ButtonStyle? style;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const SecondaryButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.style,
    this.padding = const EdgeInsets.only(bottom: 16.0),
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      child: OutlinedButton(
        onPressed: onPressed,
        style: style,
        child: Text(title),
      ),
    );
  }
}
