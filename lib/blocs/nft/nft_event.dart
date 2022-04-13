import 'package:flutter/material.dart';

@immutable
abstract class NftEvent{}

class LoadListNft extends NftEvent {
  LoadListNft();

  @override
  String toString() => 'LoadListNft';
}