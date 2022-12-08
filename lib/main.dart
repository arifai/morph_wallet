import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:morph_wallet/blocs/morph/morph_bloc.dart';
import 'package:morph_wallet/blocs/simple_bloc_observer.dart';
import 'package:morph_wallet/cores/locator.dart';
import 'package:morph_wallet/cores/morph_core.dart';
import 'package:morph_wallet/cores/morph_theme.dart';
import 'package:morph_wallet/cores/route_generator.dart';
import 'package:morph_wallet/repositories/account/account_repository.dart';
import 'package:morph_wallet/services/navigation_service.dart';

void main() async {
  // Load .env file
  await dotenv.load();

  // Hive initialize
  await Hive.initFlutter();

  // Setup locator
  setupLocator();

  // Account repository
  final AccountRepository accountRepository = locator<AccountRepository>();

  // Fonts license registry
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['fonts'], license);
  });

  // Setup custom BlocObserver
  Bloc.observer = SimpleBlocObserver();

  runApp(
    BlocProvider<MorphBloc>(
      create: (_) => MorphBloc(accountRepository)..add(StartupEvent()),
      child: MorphWalletApp(accountRepository: accountRepository),
    ),
  );
}

class MorphWalletApp extends StatelessWidget {
  final AccountRepository accountRepository;

  const MorphWalletApp({Key? key, required this.accountRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Morph Wallet',
      themeMode: ThemeMode.dark,
      darkTheme: MorphTheme.applyDarkMode,
      navigatorKey: locator<NavigationService>().navigationKey,
      initialRoute: MorphRoute.onboarding,
      onGenerateRoute: (settings) =>
          RouteGenerator(settings, accountRepository).generate(),
    );
  }
}
