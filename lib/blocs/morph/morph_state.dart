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

class CreateOrImportFirst extends MorpthState {
  @override
  String toString() => 'CreateOrImportFirst';
}

class HasAnAccount extends MorpthState {
  @override
  String toString() => 'HasAnAccount';
}
