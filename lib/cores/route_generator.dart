import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morph_wallet/blocs/bottom_navbar/bottom_navbar_bloc.dart';
import 'package:morph_wallet/blocs/create_wallet/create_wallet_bloc.dart';
import 'package:morph_wallet/blocs/nft/nft_bloc.dart';
import 'package:morph_wallet/blocs/token/token_bloc.dart';
import 'package:morph_wallet/blocs/wallet_account/wallet_account_bloc.dart';
import 'package:morph_wallet/cores/morph_core.dart';
import 'package:morph_wallet/models/args/create_or_import_args.dart';
import 'package:morph_wallet/repositories/account/account_repository.dart';
import 'package:morph_wallet/screens/create_wallet/create_wallet.dart';
import 'package:morph_wallet/screens/create_wallet/wallet_info_form_screen.dart';
import 'package:morph_wallet/screens/empty/empty_screen.dart';
import 'package:morph_wallet/screens/main/main_screen.dart';
import 'package:morph_wallet/screens/onboarding/onboarding_screen.dart';

class RouteGenerator {
  final RouteSettings settings;
  final AccountRepository accountRepository;

  RouteGenerator(this.settings, this.accountRepository);

  Route<dynamic>? generate() {
    final Object? args = settings.arguments;

    switch (settings.name) {
      case MorphRoute.onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
      case MorphRoute.createWallet:
        return MaterialPageRoute(
          builder: (_) => const CreateWallet(),
        );
      case MorphRoute.walletInfoForm:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => CreateWalletBloc(accountRepository),
            child: WalletInfoFormScreen(args: args as CreateOrImportArgs),
          ),
        );
      case MorphRoute.main:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => BottomNavbarBloc(),
              ),
              BlocProvider(
                create: (_) => TokenBloc()..add(LoadListToken()),
              ),
              BlocProvider(
                create: (_) => NftBloc()..add(LoadListNft()),
              ),
              BlocProvider(
                create: (_) => WalletAccountBloc()..add(LoadWalletAccount()),
              ),
            ],
            child: const MainScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const EmptyScreen(text: '404'),
        );
    }
  }
}
