import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morph_wallet/services/wallet_service.dart';

part 'wallet_account_event.dart';
part 'wallet_account_state.dart';

class WalletAccountBloc extends Bloc<WalletAccountEvent, WalletAccountState> {
  WalletAccountBloc() : super(const WalletAccountState()) {
    on<LoadWalletAccount>((event, emit) async {
      final String? address = await WalletService().getAddress();
      final int balance = await WalletService().getBalance('$address');

      emit(state.copy(status: WalletAccountStatus.loading));

      emit(state.copy(
        status: WalletAccountStatus.loaded,
        address: address,
        balance: balance,
      ));
    });
  }
}
