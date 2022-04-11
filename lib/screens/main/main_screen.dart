// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:morph_wallet/cores/morph_core.dart';
import 'package:morph_wallet/screens/main/collection_screen.dart';
import 'package:morph_wallet/screens/main/wallet_screen.dart';
import 'package:morph_wallet/widgets/commons/morph_icon.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late int _selectedIndex = 0;
  late int _selectedNavItem = 0;
  final List<NavBarItem> _navIcons = [
    NavBarItem(MorphIcon.wallet, 'Dompet'),
    NavBarItem(MorphIcon.arrow_swap, 'Tukar'),
    NavBarItem(MorphIcon.globe, 'DApps'),
    NavBarItem(MorphIcon.book_coin, 'Berita'),
    NavBarItem(MorphIcon.settings, 'Pengaturan')
  ];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_tabListener);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.removeListener(_tabListener);
    super.dispose();
  }

  void _tabListener() {
    setState(() => _selectedIndex = _tabController.index);
  }

  void _onNavItemTapped(int index) {
    setState(() => _selectedNavItem = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TabBar(
          controller: _tabController,
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
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          WalletScreen(key: MorphKey.walletKey),
          CollectionScreen(key: MorphKey.collectionKey),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedNavItem,
        onTap: _onNavItemTapped,
        items: _navIcons
            .map((e) =>
                BottomNavigationBarItem(icon: Icon(e.icon), label: e.label))
            .toList(),
      ),
    );
  }
}

class NavBarItem {
  final IconData icon;
  final String label;

  NavBarItem(this.icon, this.label);
}
