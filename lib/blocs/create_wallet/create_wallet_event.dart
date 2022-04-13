import 'package:flutter/material.dart';

@immutable
abstract class CreateWalletEvent {}

class CreateWalletButtonPressed extends CreateWalletEvent {
  final String name;
  final String mnemonic;
  final String password;

  CreateWalletButtonPressed(this.name, this.mnemonic, this.password);

  @override
  String toString() => 'CreateWalletButtonPressed';
}
