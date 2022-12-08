part of 'token_bloc.dart';

abstract class TokenEvent {}

class LoadListToken extends TokenEvent {
  LoadListToken();

  @override
  String toString() => 'LoadListToken';
}
