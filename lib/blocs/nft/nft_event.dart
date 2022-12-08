part of 'nft_bloc.dart';

abstract class NftEvent{}

class LoadListNft extends NftEvent {
  LoadListNft();

  @override
  String toString() => 'LoadListNft';
}