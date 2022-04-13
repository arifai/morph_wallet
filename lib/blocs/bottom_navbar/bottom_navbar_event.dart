import 'package:flutter/material.dart';
import 'package:morph_wallet/blocs/bottom_navbar/bottom_navbar_item.dart';

@immutable
abstract class BottomNavbarEvent {}

class NavbarItemUpdated extends BottomNavbarEvent {
  final BottomNavbarItem navbarItem;

  NavbarItemUpdated(this.navbarItem);

  @override
  String toString() => 'NavbarItemUpdated: { item: $navbarItem }';
}
