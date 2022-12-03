import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morph_wallet/blocs/bottom_navbar/bottom_navbar_bloc.dart';
import 'package:morph_wallet/blocs/bottom_navbar/bottom_navbar_event.dart';
import 'package:morph_wallet/blocs/bottom_navbar/bottom_navbar_item.dart';
import 'package:morph_wallet/cores/morph_core.dart';
import 'package:morph_wallet/screens/empty/empty_screen.dart';
import 'package:morph_wallet/screens/collectible/collectible_list_screen.dart';
import 'package:morph_wallet/screens/token/token_list_screen.dart';
import 'package:morph_wallet/widgets/navbar/navbar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final bottomNavbarBloc = context.read<BottomNavbarBloc>();

    return BlocBuilder<BottomNavbarBloc, BottomNavbarItem>(
      bloc: bottomNavbarBloc,
      builder: (context, currentNavItem) {
        Widget body;

        if (currentNavItem == BottomNavbarItem.wallet) {
          body = const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              TokenListScreen(key: MorphKey.tokenKey),
              CollectibleListScreen(key: MorphKey.collectibleKey),
            ],
          );
        } else {
          body = const EmptyScreen();
        }

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
            body: body,
            bottomNavigationBar: Navbar(
              currentNavItem: currentNavItem,
              onSelectedNavItem: (item) => bottomNavbarBloc.add(
                NavbarItemUpdated(item),
              ),
            ),
          ),
        );
      },
    );
  }
}
