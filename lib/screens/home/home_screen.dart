import 'package:flutter/material.dart';
import 'package:morph_wallet/cores/morph_core.dart';
import 'package:morph_wallet/screens/collectible/collectible_list_screen.dart';
import 'package:morph_wallet/screens/token/token_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const TabBar(
            tabs: [
              Tab(text: 'Token', height: 30.0),
              Tab(text: 'Koleksi', height: 30.0),
            ],
          ),
          leading: const Icon(Icons.menu_rounded),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Icon(Icons.more_horiz_rounded),
            ),
          ],
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            TokenListScreen(key: MorphKey.tokenKey),
            CollectibleListScreen(key: MorphKey.collectibleKey),
          ],
        ),
      ),
    );
  }
}
