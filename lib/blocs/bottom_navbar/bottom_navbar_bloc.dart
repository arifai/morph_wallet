import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morph_wallet/blocs/bottom_navbar/bottom_navbar_event.dart';
import 'package:morph_wallet/blocs/bottom_navbar/bottom_navbar_item.dart';

class BottomNavbarBloc extends Bloc<BottomNavbarEvent, BottomNavbarItem> {
  BottomNavbarBloc() : super(BottomNavbarItem.wallet) {
    on<NavbarItemUpdated>((event, emit) => event.navbarItem);
  }
}
