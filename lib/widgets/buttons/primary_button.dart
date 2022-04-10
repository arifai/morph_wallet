import 'package:flutter/material.dart';
import 'package:morph_wallet/size_config.dart';

class PrimaryButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final MaterialStateProperty<Size?>? fixedSize;
  final double borderRadius;

  const PrimaryButton({
    Key? key,
    this.onPressed,
    required this.title,
    this.fixedSize,
    this.borderRadius = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
      style: ButtonStyle(
        fixedSize: fixedSize ??
            MaterialStateProperty.all(
              Size(
                SizeConfig.blockSizeVertical * 41,
                SizeConfig.blockSizeHorizontal * 13,
              ),
            ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
