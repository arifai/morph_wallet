import 'package:flutter/material.dart';
import 'package:morph_wallet/cores/morph_core.dart';

class MnemonicWidget extends StatelessWidget {
  final String mnemonic;

  const MnemonicWidget({Key? key, required this.mnemonic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: MorphColor.secondaryDarkColor,
      ),
      child: Center(
        child: Text(
          mnemonic,
          softWrap: true,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
