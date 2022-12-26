import 'package:flutter/material.dart';

/// Morph wallet routes.
class MorphRoute {
  static const main = '/main_screen';
  static const onboarding = '/onboarding_screen';
  static const createWallet = '/create_wallet_screen';
  static const importWallet = '/import_wallet_screen';
  static const walletInfoForm = '/wallet_info_form_screen';
}

/// Morph images asset
class MorphImage {
  static const solanaGreyScale = 'assets/images/solana_grey_scale.png';
  static const pattern = 'assets/images/pattern.png';
}

/// Morph wallet keys.
class MorphKey {
  static final homeKey = GlobalKey();
  static const onboardingKey = Key('__onboarding_screen__');
  static const createWalletKey = Key('__create_wallet_screen__');
  static const importWalletKey = Key('__import_wallet_screen__');
  static const walletKey = Key('__wallet_screen__');
  static const tokenKey = Key('__token_screen__');
  static const collectibleKey = Key('__collectible_screen__');
  static const swapKey = Key('__swap_screen__');
  static const dAppsKey = Key('__dapps_screen__');
  static const newsKey = Key('__news_screen__');
  static const settingsKey = Key('__settings_screen__');
  static const navbarKey = Key('__navbar_widget__');
}
