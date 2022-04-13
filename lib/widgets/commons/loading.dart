import 'package:flutter/material.dart';
import 'package:morph_wallet/widgets/commons/morph_color.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: MorphColor.primaryColor,
      ),
    );
  }
}
