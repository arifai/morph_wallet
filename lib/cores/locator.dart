import 'package:get_it/get_it.dart';
import 'package:morph_wallet/services/navigation_service.dart';

/// Service locator.
GetIt locator = GetIt.instance;

/// Setup service locator.
void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}
