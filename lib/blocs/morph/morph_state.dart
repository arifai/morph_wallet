import 'package:flutter/material.dart';

@immutable
abstract class MorpthState {}

class AppInitial extends MorpthState {
  @override
  String toString() => 'App initialization';
}

class AuthenticationLoading extends MorpthState {
  @override
  String toString() => 'AuthenticationLoading';
}
