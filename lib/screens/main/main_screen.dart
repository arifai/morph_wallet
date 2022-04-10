// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:morph_wallet/cores/morph_core.dart';
import 'package:morph_wallet/screens/main/collection_screen.dart';
import 'package:morph_wallet/screens/main/wallet_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late TabController _controller;
  late int _selectedIndex = 0;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(_tabListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_tabListener);
    super.dispose();
  }

  void _tabListener() {
    setState(() => _selectedIndex = _controller.index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TabBar(
          controller: _controller,
          tabs: const [
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
      body: TabBarView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          WalletScreen(key: MorphKey.walletKey),
          CollectionScreen(key: MorphKey.collectionKey),
        ],
      ),
    );
  }
}
