import 'package:flutter/material.dart';

@immutable
abstract class TokenEvent {}

class LoadListToken extends TokenEvent {
  LoadListToken();

  @override
  String toString() => 'LoadListToken';
}
