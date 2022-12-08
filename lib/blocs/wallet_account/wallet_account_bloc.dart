import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wallet_account_event.dart';
part 'wallet_account_state.dart';

class WalletAccountBloc extends Bloc<WalletAccountEvent, WalletAccountState> {
  WalletAccountBloc() : super(const WalletAccountState()) {
    on<LoadWalletAccount>((event, emit) {
      emit(state.copy(status: WalletAccountStatus.loading));

      emit(state.copy(status: WalletAccountStatus.loaded));
    });
  }
}
