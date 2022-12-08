part of 'nft_bloc.dart';

enum NftStatus { initial, loading, loaded }

class NftState extends Equatable {
  final NftStatus status;
  final List<Nft> nfts;

  const NftState({
    this.status = NftStatus.initial,
    this.nfts = const <Nft>[],
  });

  NftState copy({NftStatus? status, List<Nft>? nfts}) {
    return NftState(
      status: status ?? this.status,
      nfts: nfts ?? this.nfts,
    );
  }

  @override
  List<Object?> get props => [status, nfts];
}
