import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morph_wallet/blocs/bottom_navbar/bottom_navbar_bloc.dart';
import 'package:morph_wallet/blocs/bottom_navbar/bottom_navbar_event.dart';
import 'package:morph_wallet/blocs/bottom_navbar/bottom_navbar_item.dart';
import 'package:morph_wallet/screens/empty/empty_screen.dart';
import 'package:morph_wallet/screens/home/home_screen.dart';
import 'package:morph_wallet/widgets/navbar/navbar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomNavbarBloc = context.read<BottomNavbarBloc>();

    return BlocBuilder<BottomNavbarBloc, BottomNavbarItem>(
      builder: (_, item) {
        Widget? body;

        if (item == BottomNavbarItem.wallet) {
          body = const HomeScreen();
        } else {
          body = const EmptyScreen();
        }

        return Scaffold(
          body: body,
          bottomNavigationBar: Navbar(
            currentNavItem: item,
            onSelectedNavItem: (item) => bottomNavbarBloc.add(
              NavbarItemUpdated(item),
            ),
          ),
        );
      },
    );
  }
}
