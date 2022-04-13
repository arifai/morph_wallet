import 'package:flutter/material.dart';
import 'package:morph_wallet/models/nft/nft.dart';

@immutable
abstract class NftState {}

class NftListLoading extends NftState {
  @override
  String toString() => 'NftListLoading';
}

class NftListLoaded extends NftState {
  final List<Nft> nfts;

  NftListLoaded(this.nfts);

  @override
  String toString() => 'NftListLoaded';
}
