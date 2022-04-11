import 'package:flutter/material.dart';
import 'package:morph_wallet/widgets/commons/morph_color.dart';

class MnemonicWidget extends StatelessWidget {
  final List<String> mnemonic;

  const MnemonicWidget({Key? key, required this.mnemonic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: mnemonic.length,
      // padding: const EdgeInsets.all(5.0),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 50,
        crossAxisSpacing: 3.0,
        mainAxisSpacing: 3.0,
      ),
      itemBuilder: (_, idx) => Container(
        color: MorphColor.darkColor,
        padding: const EdgeInsets.all(4.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: MorphColor.secondaryDarkColor,
          ),
          child: Center(
            child: Text(
              mnemonic[idx],
              softWrap: true,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
