import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morph_wallet/models/nft/nft.dart';

part 'nft_event.dart';
part 'nft_state.dart';

class NftBloc extends Bloc<NftEvent, NftState> {
  NftBloc() : super(const NftState()) {
    on<LoadListNft>((event, emit) {
      emit(state.copy(status: NftStatus.loading));

      var imgDeGods =
          'https://img-cdn.magiceden.dev/rs:fill:640:640:0:0/plain/https://metadata.degods.com/g/8555.png';
      var imgFox =
          'https://img-cdn.magiceden.dev/rs:fill:640:640:0:0/plain/https://ipfs.io/ipfs/QmNzVL7pWcc2qdMek6AqSTiHT8oJF1S6yarf7gmCd1fMQ2';

      emit(state.copy(
        status: NftStatus.loaded,
        nfts: [
          Nft(imgDeGods, 'DeGods', 1),
          Nft(imgFox, 'Famous Fox Federation', 1),
        ],
      ));
    });
  }
}
