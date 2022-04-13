import 'package:flutter/material.dart';

class CollectibleScreen extends StatefulWidget {
  const CollectibleScreen({Key? key}) : super(key: key);

  @override
  State<CollectibleScreen> createState() => _CollectibleScreenState();
}

class _CollectibleScreenState extends State<CollectibleScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Collectible Screen'),
    );
  }
}
