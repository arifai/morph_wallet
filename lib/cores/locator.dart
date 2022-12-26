import 'package:get_it/get_it.dart';
import 'package:morph_wallet/repositories/account/account_repository.dart';
import 'package:morph_wallet/services/navigation_service.dart';
import 'package:morph_wallet/services/solana_rpc_service.dart';

/// Service locator.
GetIt locator = GetIt.instance;

/// Setup service locator.
void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerSingleton(AccountRepository());
  locator.registerSingleton(SolanaRpcService());
}
