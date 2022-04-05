import 'package:flutter/material.dart';
import 'package:morph_wallet/size_config.dart';

class PrimaryButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final MaterialStateProperty<Size?>? fixedSize;

  const PrimaryButton(
      {Key? key, this.onPressed, required this.title, this.fixedSize})
      : super(key: key);

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
      ),
    );
  }
}
