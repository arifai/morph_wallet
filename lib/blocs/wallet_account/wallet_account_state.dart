import 'package:flutter/material.dart';

@immutable
abstract class WalletAccountState {}

class WalletAccountLoading extends WalletAccountState {
  WalletAccountLoading();

  @override
  String toString() => 'WalletAccountLoading';
}

class WalletAccountLoaded extends WalletAccountState {
  WalletAccountLoaded();

  @override
  String toString() => 'WalletAccountLoaded';
}
