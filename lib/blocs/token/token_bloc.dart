import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morph_wallet/models/token/token.dart';

part 'token_event.dart';
part 'token_state.dart';

class TokenBloc extends Bloc<TokenEvent, TokenState> {
  TokenBloc() : super(const TokenState()) {
    on<LoadListToken>((event, emit) {
      emit(state.copy(status: TokenStatus.loading));

      var solLogo =
          'https://s2.coinmarketcap.com/static/img/coins/200x200/5426.png';
      var samoLogo =
          'https://s2.coinmarketcap.com/static/img/coins/64x64/9721.png';

      emit(
        state.copy(status: TokenStatus.loaded, tokens: [
          Token(solLogo, '-2.7%', 'SOL', 1409820.19, 1.65, 2326977.60),
          Token(samoLogo, '-6.63%', 'SAMO', 279.76, 578, 156405.77),
        ]),
      );
    });
  }
}
