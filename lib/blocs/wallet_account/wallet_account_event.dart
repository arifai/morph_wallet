part of 'wallet_account_bloc.dart';

abstract class WalletAccountEvent {}

class LoadWalletAccount extends WalletAccountEvent {
  LoadWalletAccount();

  @override
  String toString() => 'LoadWalletAccount';
}
