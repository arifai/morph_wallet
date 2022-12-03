import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morph_wallet/blocs/morph/morph_event.dart';
import 'package:morph_wallet/blocs/morph/morph_state.dart';
import 'package:morph_wallet/repositories/account/account_repository.dart';

class MorphBloc extends Bloc<MorphEvent, MorpthState> {
  final AccountRepository accountRepository;
  static MorpthState get initialState => AppInitialization();

  MorphBloc(this.accountRepository) : super(MorphBloc.initialState) {
    on<StartupEvent>((event, emit) async {
      emit(WalletLoading());

      try {
        final bool hasAccount = await accountRepository.hasAccount();

        if (hasAccount) {
          emit(HasAnAccount());
        } else {
          emit(CreateOrImportFirst());
        }
      } catch (e) {
        emit(WalletError('WalletError: $e'));
      }
    });
  }
}
