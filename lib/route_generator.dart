import 'package:flutter/material.dart';
import 'package:morph_wallet/blocs/morph/morph_bloc.dart';
import 'package:morph_wallet/cores/morph_core.dart';
import 'package:morph_wallet/screens/create_wallet/create_wallet.dart';
import 'package:morph_wallet/screens/empty/empty_screen.dart';
import 'package:morph_wallet/screens/onboarding/onboarding_screen.dart';

class RouteGenerator {
  final RouteSettings settings;
  final MorphBloc morphBloc;

  RouteGenerator(this.settings, this.morphBloc);

  Route<dynamic>? generate() {
    final Object? args = settings.arguments;

    switch (settings.name) {
      case MorphRoute.onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
      case MorphRoute.createWallet:
        return MaterialPageRoute(
          builder: (_) => CreateWallet(mnemonic: args as String),
        );
      default:
        return MaterialPageRoute(builder: (_) => const EmptyScreen());
    }
  }
}
