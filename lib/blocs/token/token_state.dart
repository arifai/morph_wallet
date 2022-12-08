part of 'token_bloc.dart';

enum TokenStatus { initial, loading, loaded, failure }

class TokenState extends Equatable {
  final TokenStatus status;
  final List<Token> tokens;

  const TokenState({
    this.status = TokenStatus.initial,
    this.tokens = const <Token>[],
  });

  TokenState copy({TokenStatus? status, List<Token>? tokens}) {
    return TokenState(
      status: status ?? this.status,
      tokens: tokens ?? this.tokens,
    );
  }

  @override
  List<Object?> get props => [status, tokens];
}
