import 'package:flutter/material.dart';
import 'package:morph_wallet/blocs/bottom_navbar/bottom_navbar_item.dart';
import 'package:morph_wallet/cores/morph_core.dart';
import 'package:morph_wallet/widgets/commons/morph_icon.dart';

class Navbar extends StatelessWidget {
  final BottomNavbarItem currentNavItem;
  final Function(BottomNavbarItem) onSelectedNavItem;

  const Navbar({
    Key? key,
    required this.currentNavItem,
    required this.onSelectedNavItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Key key;
    String label;

    return BottomNavigationBar(
      key: MorphKey.navbarKey,
      currentIndex: BottomNavbarItem.values.indexOf(currentNavItem),
      onTap: (i) => onSelectedNavItem(BottomNavbarItem.values[i]),
      items: BottomNavbarItem.values.map((e) {
        if (e == BottomNavbarItem.wallet) {
          icon = MorphIcon.wallet;
          key = MorphKey.walletKey;
          label = 'Dompet';
        } else if (e == BottomNavbarItem.swap) {
          icon = MorphIcon.arrow_swap;
          key = MorphKey.swapKey;
          label = 'Tukar';
        } else if (e == BottomNavbarItem.dApps) {
          icon = MorphIcon.globe;
          key = MorphKey.dAppsKey;
          label = 'DApps';
        } else if (e == BottomNavbarItem.news) {
          icon = MorphIcon.book_coin;
          key = MorphKey.newsKey;
          label = 'Berita';
        } else {
          icon = MorphIcon.settings;
          key = MorphKey.newsKey;
          label = 'Pengaturan';
        }

        return BottomNavigationBarItem(
          icon: Icon(icon, key: key),
          label: label,
        );
      }).toList(),
    );
  }
}
