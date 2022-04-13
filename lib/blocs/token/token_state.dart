import 'package:flutter/material.dart';
import 'package:morph_wallet/models/token/token.dart';

@immutable
abstract class TokenState {}

class TokenListLoading extends TokenState {
  @override
  String toString() => 'TokenListLoading';
}

class TokenListLoaded extends TokenState {
  final List<Token> tokens;

  TokenListLoaded(this.tokens);

  @override
  String toString() => 'TokenListLoaded';
}
