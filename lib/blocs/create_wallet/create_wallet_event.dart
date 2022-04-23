import 'package:flutter/material.dart';
import 'package:morph_wallet/models/wallet_account/wallet_account.dart';

@immutable
abstract class CreateWalletEvent {}

class CreateWalletButtonPressed extends CreateWalletEvent {
  final WalletAccount walletAccount;

  CreateWalletButtonPressed(this.walletAccount);

  @override
  String toString() => 'CreateWalletButtonPressed';
}
