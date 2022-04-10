import 'package:flutter/material.dart';

@immutable
abstract class MorpthState {}

class AppInitialization extends MorpthState {
  @override
  String toString() => 'AppInitialization';
}

class WalletLoading extends MorpthState {
  @override
  String toString() => 'WalletLoading';
}
