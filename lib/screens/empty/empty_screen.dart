import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  final String? text;
  const EmptyScreen({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          text ?? 'Emtpy Screen',
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
