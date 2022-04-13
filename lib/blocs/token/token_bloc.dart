import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morph_wallet/blocs/token/token_event.dart';
import 'package:morph_wallet/blocs/token/token_state.dart';
import 'package:morph_wallet/models/token/token.dart';

class TokenBloc extends Bloc<TokenEvent, TokenState> {
  static TokenState get initialState => TokenListLoading();

  TokenBloc() : super(TokenBloc.initialState) {
    on<LoadListToken>((event, emit) {
      emit(TokenListLoading());

      var solLogo =
          'https://s2.coinmarketcap.com/static/img/coins/200x200/5426.png';
      var samoLogo =
          'https://pbs.twimg.com/profile_images/1477759103250358274/Fhq3wD1d_400x400.jpg';

      emit(
        TokenListLoaded(
          [
            Token(solLogo, '-2.7%', 'SOL', 1409820.19, 1.65, 2326977.60),
            Token(samoLogo, '-6.63%', 'SAMO', 279.76, 578, 156405.77),
          ],
        ),
      );
    });
  }
}
