import 'package:flutter/material.dart';

/// Morph wallet routes.
class MorphRoute {
  static const onboarding = '/onboarding_screen';
  static const createWallet = '/create_wallet_screen';
  static const importWallet = '/import_wallet_screen';
  static const walletInfoForm = '/wallet_info_form_screen';
}

/// Morph images asset
class MorphImage {
  static const pattern = 'assets/images/pattern.png';
}

/// Morph wallet keys.
class MorphKey {
  static final homeKey = GlobalKey();
  static const onboardingKey = Key('__onboarding_screen__');
  static const createWalletKey = Key('__create_wallet_screen__');
  static const importWalletKey = Key('__import_wallet_screen__');
}

/// Morph wallet colors pallet.
class MorphColor {
  static const Color darkColor = Color(0xFF232323);
  static const Color secondaryDarkColor = Color(0xFF353535);
  static const Color whiteColor = Colors.white;
  static const Color primaryColor = Color(0xFF8B50F5);
  static const Color errorColor = Color(0xFFF13440);
  static const Color yellowColor = Color(0xFFF0B134);
  static const Color darkYellowColor = Color(0xFF3F3727);
  static const Color pinkColor = Color(0xFFF5509F);
  static const Color greyColor = Color(0xFF9E9E9E);
  static const Color darkGreyColor = Color(0xFF4F4F4F);
  static const Color greenColor = Color(0xFF34F174);
}
