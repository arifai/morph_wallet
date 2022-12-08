import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morph_wallet/models/wallet_account/wallet_account.dart';
import 'package:morph_wallet/repositories/account/account_repository.dart';

part 'create_wallet_event.dart';
part 'create_wallet_state.dart';

class CreateWalletBloc extends Bloc<CreateWalletEvent, CreateWalletState> {
  final AccountRepository accountRepository;

  CreateWalletBloc(this.accountRepository) : super(const CreateWalletState()) {
    on<CreateWalletButtonPressed>((event, emit) async {
      emit(state.copy(status: CreateWalletStatus.loading));

      try {
        await accountRepository.create(
          event.walletAccount.name,
          event.walletAccount.mnemonic,
          event.walletAccount.password,
        );

        emit(state.copy(status: CreateWalletStatus.success));
      } catch (e) {
        emit(state.copy(status: CreateWalletStatus.failure, message: '$e'));
      }
    });
  }
}
