import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final ButtonStyle? style;

  const PrimaryButton({
    Key? key,
    this.onPressed,
    required this.title,
    this.padding = const EdgeInsets.only(bottom: 16.0),
    this.margin,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      child: ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: Text(title),
      ),
    );
  }
}
