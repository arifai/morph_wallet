import 'package:flutter/material.dart';

@immutable
abstract class CreateWalletState {}

class CreateWalletInitial extends CreateWalletState {
  @override
  String toString() => 'CreateWalletInitial';
}

class CreateWalletLoading extends CreateWalletState {
  @override
  String toString() => 'CreateWalletLoading';
}

class CreateWalletSuccess extends CreateWalletState {
  @override
  String toString() => 'CreateWalletSuccess';
}

class CreateWalletFailure extends CreateWalletState {
  final String message;

  CreateWalletFailure({required this.message});

  @override
  String toString() => 'CreateWalletFailure';
}
