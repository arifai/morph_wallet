import 'package:flutter/material.dart';
import 'package:morph_wallet/widgets/commons/morph_color.dart';

class WarningWidget extends StatelessWidget {
  final String text;
  const WarningWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: MorphColor.darkYellowColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.info_outline,
                color: MorphColor.yellowColor,
              ),
            ),
            Flexible(
              child: Text(
                text,
                style: const TextStyle(
                  color: MorphColor.yellowColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
