import 'package:flutter/material.dart';
import 'package:morph_wallet/widgets/commons/morph_color.dart';

class FormWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Function()? onEditingComplete;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final AutovalidateMode? autovalidateMode;
  final int maxLines;
  final int? maxLength;
  final bool autofocus;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? suffixText;
  final String? errorText;

  const FormWidget({
    Key? key,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.autovalidateMode,
    this.maxLines = 1,
    this.maxLength,
    this.autofocus = false,
    this.obscureText = false,
    this.suffixIcon,
    this.suffixText,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      maxLength: maxLength,
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      autofocus: autofocus,
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText,
      onFieldSubmitted: onFieldSubmitted,
      autovalidateMode: autovalidateMode,
      onEditingComplete: onEditingComplete,
      style: const TextStyle(
        color: MorphColor.whiteColor,
        fontSize: 15.0,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        suffixText: suffixText,
        counterText: '',
        errorText: errorText,
      ),
    );
  }
}
