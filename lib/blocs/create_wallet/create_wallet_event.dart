part of 'create_wallet_bloc.dart';

abstract class CreateWalletEvent {}

class CreateWalletButtonPressed extends CreateWalletEvent {
  final WalletAccount walletAccount;

  CreateWalletButtonPressed(this.walletAccount);

  @override
  String toString() => 'CreateWalletButtonPressed';
}
