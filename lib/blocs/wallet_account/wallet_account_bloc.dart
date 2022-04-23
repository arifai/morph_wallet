import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morph_wallet/blocs/wallet_account/wallet_account_event.dart';
import 'package:morph_wallet/blocs/wallet_account/wallet_account_state.dart';

class WalletAccountBloc extends Bloc<WalletAccountEvent, WalletAccountState> {
  static WalletAccountState get initialState => WalletAccountLoading();

  WalletAccountBloc() : super(WalletAccountBloc.initialState) {
    on<LoadWalletAccount>((event, emit) {
      emit(initialState);

      emit(WalletAccountLoaded());
    });
  }
}
