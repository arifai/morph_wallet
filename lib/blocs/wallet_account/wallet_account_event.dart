import 'package:flutter/material.dart';

@immutable
abstract class WalletAccountEvent {}

class LoadWalletAccount extends WalletAccountEvent {
  LoadWalletAccount();

  @override
  String toString() => 'LoadWalletAccount';
}
