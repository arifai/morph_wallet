import 'package:flutter/material.dart';

class CollectibleListScreen extends StatefulWidget {
  const CollectibleListScreen({Key? key}) : super(key: key);

  @override
  State<CollectibleListScreen> createState() => _CollectibleListScreenState();
}

class _CollectibleListScreenState extends State<CollectibleListScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Collectible Screen'),
    );
  }
}
