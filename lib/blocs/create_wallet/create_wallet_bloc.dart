import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morph_wallet/blocs/create_wallet/create_wallet_event.dart';
import 'package:morph_wallet/blocs/create_wallet/create_wallet_state.dart';
import 'package:morph_wallet/repositories/account/account_repository.dart';

class CreateWalletBloc extends Bloc<CreateWalletEvent, CreateWalletState> {
  final AccountRepository accountRepository;
  static CreateWalletState get initialState => CreateWalletInitial();

  CreateWalletBloc(this.accountRepository)
      : super(CreateWalletBloc.initialState) {
    on<CreateWalletButtonPressed>((event, emit) {
      emit(CreateWalletLoading());

      try {
        accountRepository.create(
          name: event.name,
          mnemonic: event.mnemonic,
          password: event.password,
        );

        emit(CreateWalletSuccess());
      } catch (e) {
        emit(CreateWalletFailure(message: e.toString()));
      }
    });
  }
}
