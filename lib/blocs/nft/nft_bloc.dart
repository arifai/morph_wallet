import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morph_wallet/blocs/nft/nft_event.dart';
import 'package:morph_wallet/blocs/nft/nft_state.dart';
import 'package:morph_wallet/models/nft/nft.dart';

class NftBloc extends Bloc<NftEvent, NftState> {
  static NftState get initialState => NftListLoading();

  NftBloc() : super(NftBloc.initialState) {
    on<LoadListNft>((event, emit) {
      emit(NftListLoading());

      var imgDeGods =
          'https://img-cdn.magiceden.dev/rs:fill:640:640:0:0/plain/https://metadata.degods.com/g/8555.png';
      var imgFox =
          'https://img-cdn.magiceden.dev/rs:fill:640:640:0:0/plain/https://ipfs.io/ipfs/QmNzVL7pWcc2qdMek6AqSTiHT8oJF1S6yarf7gmCd1fMQ2';

      emit(
        NftListLoaded([
          Nft(imgDeGods, 'DeGods', 1),
          Nft(imgFox, 'Famous Fox Federation', 1),
        ]),
      );
    });
  }
}
